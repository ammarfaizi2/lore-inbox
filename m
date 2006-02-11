Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWBKEh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWBKEh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 23:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWBKEh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 23:37:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932231AbWBKEh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 23:37:58 -0500
Date: Fri, 10 Feb 2006 20:37:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at
 drivers/ieee1394/ohci1394.c:235/get_phy_reg()
Message-Id: <20060210203715.57b39b0d.akpm@osdl.org>
In-Reply-To: <1139624931.19342.46.camel@mindpipe>
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
	<20060210122131.4b98cfb4.akpm@osdl.org>
	<1139624931.19342.46.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Fri, 2006-02-10 at 12:21 -0800, Andrew Morton wrote:
> > Miles Lane <miles.lane@gmail.com> wrote:
> > >
> > > BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
> > 
> > That's a -mm-only warning telling you that get_phy_reg() is doing a
> > one-millisecond-or-more busywait while local interrupts are disabled.
> > 
> > That's the sort of thing which makes audio developers pursue 1394 developers
> > with sharp sticks.
> 
> Hmm, interesting, did -mm get a "lite" version of Ingo's latency tracer?
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/debug-warn-if-we-sleep-in-an-irq-for-a-long-time.patch
