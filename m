Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276227AbRI1S2I>; Fri, 28 Sep 2001 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276225AbRI1S16>; Fri, 28 Sep 2001 14:27:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276224AbRI1S1y>; Fri, 28 Sep 2001 14:27:54 -0400
Subject: Re: mm: critical shortage of bounce buffers
To: sp@scali.no (Steffen Persvold)
Date: Fri, 28 Sep 2001 19:33:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3BB4BF1F.B333625B@scali.no> from "Steffen Persvold" at Sep 28, 2001 08:19:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n2Rf-0007xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've recently encountered the following message on a machine running RedHat's
> 2.4.3-12 kernel :
> 
> "mm: critical shortage of bounce buffers"
> 
> I've searched through the kernel sources, but my 'find' just can't locate this
> string anywhere.

Its in the high mem handling routines. It means the machine stalled for
a moment doing I/O because it had no memory below 1Gb to use.

> Why does this message appear (apparently during high network load with the intel
> eepro100 driver or e1000 driver). Is bounce buffers really in use on a x86
> machine with 2GB of RAM (normal smp RedHat kernel, not enterprise)??

The answer is yes. You can actually build yourself a custom none bounce
buffer 1.8GB kernel with about 2Gb of user virtual space per app. For some
applications it will perform better.
