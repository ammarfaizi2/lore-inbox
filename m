Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTFPScB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFPScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:32:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33449 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264094AbTFPS3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:29:24 -0400
Date: Mon, 16 Jun 2003 11:41:49 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS w83781d during rmmod (2.5.70-bk1[1234]))
Message-ID: <20030616184149.GC25585@kroah.com>
References: <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private> <20030605194734.GA6238@kroah.com> <1055136870.5280.196.camel@workshop.saharacpt.lan> <20030610054107.GA22719@earth.solarsys.private> <1055401021.5280.3143.camel@workshop.saharacpt.lan> <20030613023651.GA1401@earth.solarsys.private> <1055571995.12868.5.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055571995.12868.5.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 08:26:35AM +0200, Martin Schlemmer wrote:
> On Fri, 2003-06-13 at 04:36, Mark M. Hoffman wrote:
> > > > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > > > (just tell it to that if the chip id is 0x72, its also of type
> > > > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > > > > it did not with 2.5.68 kernels when I still had the other board.  I will
> > > > > attach a oops tomorrow or such when I get home.
> > > > 
> 
> > My first patch was naive; the patch below solves the problem by
> > letting w83781d_detach_client remove the three clients (1 * primary
> > + 2 * subclients) independently.  It's a noisy patch because I had
> > to change the way the subclients were kmalloc'ed - sorry.  The meat
> > is around line 1422.  This patch works for me... comments?
> > 
> > Regards,
> > 
> > --- 
> > Mark M. Hoffman
> > mhoffman@lightlink.com
> 
> Greg, this patch from Mark fixes it, please include in your stuff
> to send to Linus.

Applied, thanks.

greg k-h
