Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135980AbRA1MMG>; Sun, 28 Jan 2001 07:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRA1ML4>; Sun, 28 Jan 2001 07:11:56 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:4101 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135980AbRA1MLs>; Sun, 28 Jan 2001 07:11:48 -0500
Date: Sun, 28 Jan 2001 12:11:47 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8 losing pages
Message-ID: <20010128121147.A1877@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
In-Reply-To: <20010126194605.A923@colonel-panic.com> <200101261948.f0QJm6q09263@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101261948.f0QJm6q09263@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Jan 26, 2001 at 07:48:05PM +0000
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 07:48:05PM +0000, Russell King wrote:
> Peter Horton writes:
> > The corruption is dependent on having a swapped on swap partition. If I
> > "swapoff" the corruption goes away, but it comes back when I "swapon"
> > again. I feel this a kernel bug, but as I'm the only person out here who's
> > seeing it I'm at a loss ...
> 
> The reason I ask is that on an ARM box running plain 2.4.0 with swap
> enabled I get rather a lot of SEGVs.  Turn swap off, and I don't see
> any.
> 
> It sounds like it may be related.
> 

Okay, scratch that. It does still happen when there's no swap, but for
some reason it happens a lot less often. Looks like it's timing related,
it only fails when using 7200rpm drives, not older 5400rpm ones (even
though they too are using UDMA33). I've ruled out the filing system, the
IDE controller, the drives and the RAM, so that leaves the kernel or the
CPU - I'll try and beg/borrow/steal another CPU and try that. I can
compile kernels / run X whilst the test is running without a problem so it
looks like it's the bulk write that's the problem.

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
