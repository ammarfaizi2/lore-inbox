Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291684AbSBHSBY>; Fri, 8 Feb 2002 13:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291689AbSBHSBP>; Fri, 8 Feb 2002 13:01:15 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:51677 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S291684AbSBHSBE>;
	Fri, 8 Feb 2002 13:01:04 -0500
Message-ID: <3C641250.FB2D0977@canit.se>
Date: Fri, 08 Feb 2002 19:00:48 +0100
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
Subject: Re: Promise PDC20268 spurious interrupt
In-Reply-To: <20020208004954.GA19421@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see this problem but I have a PDC20262 ultra66 and have been running raid0
on that for 1.5 years but one disk broke down and I got a new one. This was a
newer model and thus faster.

The problem I see is that DD from the new disk hangs the system in interesting
ways from dd hangs in uninterruptible sleep to the whole system going down. This
happens on both channels but only on the new disk.

I get two errors in the log

hdg: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14


Mathieu Desnoyers wrote:

> I have a problem here since I plugged my second hard disk on my Promise
> Ultra 100 TX2 PDC20268 controller. It occurs all the time when I use software
> raid 0. I looked at the LKML archives, and this problem does not seems to be
> solved. There is a simpler way to generate the problem than to use raid.
>
> It occurs when I use dd for reading on my both hard disks in parallel.
> The disks are both masters of their channel.
>
> When I do this test, The message I get is
>
> spurious 8259A interrupt: IRQ7.
> spurious 8259A interrupt: IRQ15.
>
> And I can look at /proc/interrupts and see the ERR counter increment at
> a phenomenal speed.
>
> I wonder if this problem is due to the linux driver support or if it is
> a hardware bug.
>
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
>
>   ------------------------------------------------------------------------
>
>    Part 1.2    Type: application/pgp-signature
>            Encoding: 7bit

