Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTFIFgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 01:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFIFgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 01:36:17 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:25593 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264201AbTFIFgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 01:36:15 -0400
Subject: Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
In-Reply-To: <20030605194734.GA6238@kroah.com>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055136870.5280.196.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 09 Jun 2003 07:34:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 21:47, Greg KH wrote:
> On Wed, Jun 04, 2003 at 10:39:22PM -0400, Mark M. Hoffman wrote:
> > * Greg KH <greg@kroah.com> [2003-06-02 10:20:40 -0700]:
> > > On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> > > > 
> > > > This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> > > > re-testing against an ISA adapter since my particular chip is SMBus only.
> > > 
> > > I've applied this and will send it off to Linus in a bit.
> > 
> > Thanks!
> > 
> > This patch fixes the various return values in the w83781d_detect()
> > error paths.  It also cleans up some formatting here and there.
> > It should be applied on top of the previous one.
> > 
> > It works for me; same caveat as above w.r.t. ISA.
> 
> Applied, thanks.
> 

Things have changed since I converted this driver to 2.5.  I no longer
have the 850E chipset mobo with w83781d sensor, but a 875p chipset
mobo, with W83627THF (basically the same as the W83627HF, just with
advance fan control .. prob the Q-Fan option in the Asus board?).

I sorda got the ICH5 talking, and can get the driver loaded for the
W83627THF (as W83627HF), but all the values seems borked.  Unfortunately
I cannot get a spec sheet on the  W83627THF.  Is anybody working on
ICH5/W83627THF support ?

Anyhow, Only change I have made to the w83781d driver, is one line
(just tell it to that if the chip id is 0x72, its also of type
w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
it did not with 2.5.68 kernels when I still had the other board.  I will
attach a oops tomorrow or such when I get home.


Regards,

-- 
Martin Schlemmer


