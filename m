Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUJPMkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUJPMkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUJPMkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:40:22 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:1251 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268714AbUJPMkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:40:20 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 16 Oct 2004 14:21:57 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, KendallB@scitechsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041016122156.GA7968@bytesex>
References: <1ewKr-2Kh-41@gated-at.bofh.it> <CebL.O9.13@gated-at.bofh.it> <1bucs-57R-33@gated-at.bofh.it> <2PncW-6j9-23@gated-at.bofh.it> <20030423094012$4166@gated-at.bofh.it> <2PncW-6j9-17@gated-at.bofh.it> <2PAMY-7Ir-21@gated-at.bofh.it> <m3655cjc1r.fsf@averell.firstfloor.org> <87u0swouvu.fsf@bytesex.org> <20041016005544.GA75049@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016005544.GA75049@muc.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 02:55:44AM +0200, Andi Kleen wrote:
> On Fri, Oct 15, 2004 at 05:37:09PM +0200, Gerd Knorr wrote:
> > Andi Kleen <ak@muc.de> writes:
> > 
> > > The problem is that this would imply that the console would only
> > > work after user space is running. Even with initrd that's quite late.
> > 
> > klibc + initramfs + early userspace?
> 
> That's still quite late in my book (by my perspective may be skewed
> a bit from low level architecture hacking) 

Framebuffer console _is_ quite late compared vgacon or even
early_printk, all the basic stuff is already up+running at that point.

I think initialization in early userspace can be done in a way that
it wouldn't delay the initial console display compared to todays vesafb
(or any other framebuffer).  Of course you need some way to turn it off
and use vgacon instead ...

  Gerd

-- 
return -ENOSIG;
