Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWGCVtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWGCVtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGCVtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:49:39 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:26640 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750996AbWGCVti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:49:38 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 22:50:02 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <200607032136.55259.s0348365@sms.ed.ac.uk> <20060703135419.7c58f318.akpm@osdl.org>
In-Reply-To: <20060703135419.7c58f318.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032250.02054.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 21:54, Andrew Morton wrote:
> On Mon, 3 Jul 2006 21:36:55 +0100
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Monday 03 July 2006 21:17, Andrew Morton wrote:
> > > On Mon, 3 Jul 2006 20:56:28 +0100
> > > Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > > On Monday 03 July 2006 20:39, Andrew Morton wrote:
[snip]
> > > > > Try adding `pause_on_oops=100000' to the kernel boot command line.
> > > >
> > > > (Trimmed Nathan)
> > > >
> > > > Helped somewhat, but I'm still missing a bit at the top.
> > > >
> > > > http://devzero.co.uk/~alistair/oops-20060703/
> > >
> > > That is irritating.  This should get us more info:
> >
> > Indeed, thanks.
> >
> > Try the same URL again, I've uploaded 3,4,5 from a couple of reboots. I
> > still think I'm missing something at the top, but 3 is the earliest I
> > could snap.
>
> Getting better.
>
> It would kinda help if pause_on_oops() was actually implemented on x86_64..

Doesn't help (work?).

[alistair] 22:47 [~] strings /boot/vmlinuz-2.6.17-mm6 | grep 2.6.17-mm6
2.6.17-mm6 (alistair@damocles) #3 SMP PREEMPT Mon Jul 3 22:39:54 BST 2006

[alistair] 22:48 [~] cat /boot/grub/menu.lst | grep -C1 mm6
# testing
title Linux 2.6.17-mm6
root (hd0,0)
kernel /boot/vmlinuz-2.6.17-mm6 vga=extended root=/dev/sda1 
pause_on_oops=100000

I'm fairly sure I booted a kernel with your patch and that should be the right 
cmdline flag.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
