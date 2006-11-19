Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933131AbWKSUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbWKSUGk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbWKSUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:06:40 -0500
Received: from hera.kernel.org ([140.211.167.34]:9122 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S933131AbWKSUGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:06:40 -0500
Date: Sun, 19 Nov 2006 20:06:37 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.33.4
Message-ID: <20061119200637.GA18968@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Here's linux-2.4.33.4, which adds a few fixes on top of 2.4.33.3.
All of those are pretty minimal. Nothing critical here, there is
no reason to hurry an upgrade for people running 2.4.33.3, unless
they're hit by one of those bugs of course. It also fixes two
vulnerabilities :

  - CVE-2006-5174 : copy_from_user information leak on s390
  - CVE-2006-4997 : do not refer freed skbuff in clip_mkip()

Location: ftp://ftp.kernel.org/pub/linux/kernel/v2.4/

Regards,
Willy
--

Summary of changes from v2.4.33.3 to v2.4.33.4
============================================

Akinobu Mita (1):
      WATCHDOG: sc1200wdt.c pnp unregister fix.

dann frazier (1):
      Backport fix for CVE-2006-4997 to 2.4 tree

Dick Streefland (1):
      incorrect timeout in mtd AMD driver of 2.4 kernel

Geert Uytterhoeven (1):
      fbdev: correct buffer size limit in fbmem_read_proc()

Herbert Xu (1):
      SCTP: Always linearise packet on input

Jeff Garzik (1):
      ISDN: fix drivers, by handling errors thrown by ->readstat()

Jurzitza, Dieter (1):
      really fix size display for sun partitions larger than 1TByte

Martin Schwidefsky (3):
      copy_from_user information leak on s390.
      s390 : fix typo in recent copy_from_user fix
      [S390] user readable uninitialised kernel memory (3rd version)

Michael Chen (1):
      i386: fix overflow in vmap on an x86 system which has more than 4GB memory.

mostrows@earthlink.net (1):
      Advertise PPPoE MTU

NeilBrown (1):
      knfsd: Fix race that can disable NFS server.

Patrick McHardy (1):
      [NETFILTER]: Fix deadlock on NAT helper unload

PaX Team (2):
      MIPS: fix long long cast in pte macro
      i386: fix long long cast in pte macro

Pete Zaitcev (2):
      USB: Little Rework for usbserial
      USB: unsigned long flags

Steffen Maier (1):
      block: fix negative bias of ios_in_flight (CONFIG_BLK_STATS) because of unbalanced I/O accounting

Stephen Hemminger (1):
      [BRIDGE]: netfilter deadlock

Toyo Abe (1):
      x86_64: Fix missing delay when the TSC counter just overflowed

Willy Tarreau (10):
      i386: remove unsigned long long cast in __pte() macro.
      2.4.x: i386/x86_64 bitops clobberings
      [PATCH-2.4] i2c-elv: fix erroneous '&&' operator
      fix "&& 0xffff" typo in gdth.c
      fix obvious "&& 0xFFFFFF" typo in cpqfcTSworker
      fix "&& 0xff" typo in qeth_qdio_input_handler
      fix two "&& 0x03" in usbnet
      EXT3: avoid crashing by not dividing by zero.
      EXT2: avoid crashing by not dividing by zero.
      Change VERSION to 2.4.33.4

