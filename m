Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276766AbRJBWxo>; Tue, 2 Oct 2001 18:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276767AbRJBWxe>; Tue, 2 Oct 2001 18:53:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12557 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276766AbRJBWxN>; Tue, 2 Oct 2001 18:53:13 -0400
Subject: Re: Huge console switching lags
To: jsimmons@transvirtual.com (James Simmons)
Date: Tue, 2 Oct 2001 23:57:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jfbeam@bluetopia.net (Ricky Beam),
        akpm@zip.com.au (Andrew Morton),
        lenstra@tiscalinet.it (Lorenzo Allegrucci),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linuxconsole-dev@lists.sourceforge.net (Linux console project)
In-Reply-To: <Pine.LNX.4.10.10110021536080.30587-100000@transvirtual.com> from "James Simmons" at Oct 02, 2001 03:50:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oYUA-0006HG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    The software accel functions needed by the console layer (copyarea,
> fillrect, and drawimage) have been already written. Okay the drawimage one
> needs alot of work. I haven't benchmarked the new code versus the current

On x86 they'll probably make no difference at all, unless the old code
is really really crap. Your bottleneck is the PCI bus. All you can do is
avoid reads.

Alan
