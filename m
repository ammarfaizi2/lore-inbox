Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSFTTS6>; Thu, 20 Jun 2002 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSFTTS5>; Thu, 20 Jun 2002 15:18:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43002 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315202AbSFTTSz>; Thu, 20 Jun 2002 15:18:55 -0400
Subject: [PATCH] updated preemptive kernel for 2.4-ac
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 12:18:56 -0700
Message-Id: <1024600737.921.241.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An updated preempt-kernel patch against 2.4.19-pre10-ac2 is available at

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-pre10-ac2-2.patch

and your favorite mirror.

The cause of this release is to make the pte_chain_lock and unlock
routines preempt-safe.  They basically are per-bit spinlocks and thus
require the standard spinlock treatment but do not receive it.

This patch also merges PPC support, to bring the supported architectures
to ARM, i386, MIPS, PPC, and SH.  This code is contributed by
MontaVista.

Finally, there is a critical fix and optimization in entry.S by George
Anzinger.

Full ChangeLog:

20020620

- i386 entry.S changes, no need to check the	(George Anzinger)
  the irq or bh_count but we do need to make
  sure interrupts are off
- preempt-safe pte_chain_lock and unlock	(Robert Love)
- merge PPC support				(Robert Love)
- fix typo in smp.c				(Robert Love)

20020608

- merge MIPS support				(Robert Love)

20020529

- preempt-safe in_interrupt and in_irq		(George Anzinger)
- preempt-safe arch/i386/kernel/smp.c		(George Anzinger)
- preempt-safe net/*				(George Anzinger)
- change the wording of the do_exit notice	(Robert Love)

Enjoy,

	Robert Love

