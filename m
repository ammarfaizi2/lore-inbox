Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWBJKir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWBJKir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWBJKir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:38:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751337AbWBJKir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:38:47 -0500
Date: Fri, 10 Feb 2006 02:38:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dan Faerch <dan@scannet.dk>
Cc: s-briggs@cecer.army.mil, linux-ns83820@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/ns83820.c: add paramter to disable auto
 negotiation
Message-Id: <20060210023800.630fa2a7.akpm@osdl.org>
In-Reply-To: <1139564963.15033.40.camel@dan>
References: <200602092203.28290.s-briggs@cecer.army.mil>
	<20060209201716.0c6d1fea.akpm@osdl.org>
	<1139564963.15033.40.camel@dan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Faerch <dan@scannet.dk> wrote:
>
> On Thu, 2006-02-09 at 20:17 -0800, Andrew Morton wrote: 
> > Steve Briggs <s-briggs@cecer.army.mil> wrote:
> > >
> > > This patch adds a module paramter, "auto_neg" which is
> > >  by default =1.  If it's set to zero, the auto negotiation
> > >  code in ns83820_init_one() is skipped and the interface is
> > >  set to 1000F.
> > 
> > Better to do this via `ethtool autoneg off'.
> 
> Actually I did somewhat the same patch about a year ago and got the same
> response:
> 
> "This functionality should likelz be done via ethtool..." - Benjamin
> LaHaise[1]
> 
> So i went back and spend about a week redoing the whole thing to enable
> ethtool support and reposted a patch[2], but didnt receive any response
> to this whatsoever. I even wrote the maintainer later on personally to
> ask if something was wrong with the patch, bad coding, anything, since
> there was no reply or reaction. I never received a reply.
> 
> So. There IS an ethtool patch and it works for me, though i dont know
> how well its made (there must be SOME reason i didnt get a response :)).

Well, sometimes one needs to persist.  Or copy me on the patch and I persist
for you ;)

> It supports autoneg, duplex and speed if i recall correctly.
> If you try it out, id love to hear comments (since this was/is the first
> time i messed around in kernel stuff).
> 

The patch you have here has all its tabs replaced with spaces and apart
from that doesn't apply to the current development tree.  And it seems
to have some very random whitespace usage as well, although I usually
fix those things up if the patch isn't enormous.

Could you fix all this up, generate a nice changelog, add a Signed-off-by:
as per section 11 of Documentation/SubmittingPatches and resend?

Thanks.

