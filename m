Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUILIam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUILIam (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268189AbUILIam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:30:42 -0400
Received: from colin2.muc.de ([193.149.48.15]:51729 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268076AbUILIak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:30:40 -0400
Date: 12 Sep 2004 10:30:39 +0200
Date: Sun, 12 Sep 2004 10:30:39 +0200
From: Andi Kleen <ak@muc.de>
To: SashaK <sashak@smlink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 patch)
Message-ID: <20040912083039.GB87823@muc.de>
References: <2DdiX-6ye-17@gated-at.bofh.it> <2Dfup-7Zv-9@gated-at.bofh.it> <m3k6v0lwwq.fsf@averell.firstfloor.org> <20040911230753.1c1d73de@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911230753.1c1d73de@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 11:07:53PM +0300, SashaK wrote:
> On Sat, 11 Sep 2004 16:09:41 +0200
> Andi Kleen <ak@muc.de> wrote:
> 
> > SashaK <sashak@smlink.com> writes:
> > 
> > > You mean to GPL user-space program slmodemd?
> > > I think it is good idea, but unfortunately this code is not just my,
> > > and final decision was 'no'.
> > 
> > One way that would work is to make the binary parts of your driver run
> > in user space and let the kernel part just provide a kind of simple
> > sound card. 
> 
> It is done so - user space daemon (with binary part) interacts with ALSA
> drivers.

Ok, thanks for the correction. 

> 
> > The later should be much easier to free.
> 
> There was such approach, but seems it was wrong.

What's the problem exactly - your kernel part is still binary only? 

> 
> > The 64bit kernel can run 32bit programs without problems.
> 
> This should be possible (don't check yet). But the problem here was
> that AMD64 machines are usually based on non-Intel chipsets
> (VIA, NVidia), supports for those chipsets were added to ALSA just in
> last days. Now it may be tested with recent version of ALSA.

One small issue is that when you have custom ioctls there may 
be some need to add them to the compat layer, otherwise the user
space part cannot issue them. This could be even done in a separate 
module from your driver though.

-Andi
