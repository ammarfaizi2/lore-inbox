Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSANVHo>; Mon, 14 Jan 2002 16:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSANVHd>; Mon, 14 Jan 2002 16:07:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289046AbSANVH1>; Mon, 14 Jan 2002 16:07:27 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: akpm@zip.com.au (Andrew Morton)
Date: Mon, 14 Jan 2002 21:19:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), zippel@linux-m68k.org (Roman Zippel),
        yodaiken@fsmlabs.com, phillips@bonn-fries.net (Daniel Phillips),
        arjan@fenrus.demon.nl (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <3C43394D.412C7ECC@zip.com.au> from "Andrew Morton" at Jan 14, 2002 12:02:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QEVS-0002yh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have all along assumed that a well-designed RT application would delegate
> all these operations to SCHED_OTHER worker processes, probably via shared
> memory/shared mappings.  So in the simplest case, you'd have a SCHED_FIFO
> task which talks to the hardware, and which has a helper task which reads
> and writes stuff from and to disk.  With sufficient buffering and readahead
> to cover the worst case IO latencies.

A real RT task has hard guarantees and to all intents and purposes you may
deem the system failed if it ever misses one (arguably if you cannot verify
it will never miss one).

The stuff we care about is things like DVD players which tangle with
sockets, pipes, X11, memory allocation, and synchronization between multiple
hardware devices all running at slightly incorrect clocks.

