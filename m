Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSKCUCb>; Sun, 3 Nov 2002 15:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSKCUCb>; Sun, 3 Nov 2002 15:02:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49294 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262397AbSKCUC3>; Sun, 3 Nov 2002 15:02:29 -0500
Subject: Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103143216.A27147@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu> 
	<20021103143216.A27147@neurosis.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 20:30:18 +0000
Message-Id: <1036355418.30679.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 19:32, Jim Paris wrote:
> After 180 days of uptime, it's not surprising that there would have
> been one read of the port that failed, triggering the problem, so I
> think the kernel should detect and fix this.  We could just check for
> it: if the returned count > LATCH, read an extra byte from port 0x40,
> as I did.  Or, use the method in do_slow_gettimeoffset, which
> basically resets the 8253's counter if count > LATCH.

We have locking that ought to get that all correct nowdays but I've seen
at least one bios generate half a read in SMM mode

> Any comments?

Have a play with it, if your idea works when you deliberately disturb it
then send in a patch

