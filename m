Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTLHAgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLHAgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:36:43 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27832 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264796AbTLHAgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:36:38 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6.0-test11-bart1
Date: Mon, 8 Dec 2003 01:38:32 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312080138.32388.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lets start the ball rolling...

If you have problems ide-tape.c, siimage.c or cmd640.c (in PCI mode)
you should try this patch.

It also contains untested fixes for Promise IDE driver (pdc202xx_old.c),
they should be safe but better backup your data first :-), feedback needed.

Workarounds for nForce2 chipset are also included.

Get it from:
ftp://ftp.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/

If you have some patches you think are worth merging just mail me
(cleanups are also welcomed).

--bart

Merged:

linux-2.6.0-test11-bk5.patch
  -bk snapshot (patch-2.6.0-test11-bk5)

extraversion.patch
  add -bartX to EXTRAVERSION

ide-tape-update.patch
  [IDE] ide-tape.c update

ide-tape-rq-special.patch
  [IDE] ide-tape.c: stop abusing rq->flags

ide-siimage-seagate.patch
  [IDE] siimage.c: limit requests to 15kB only for Seagate SATA drives

ide-siimage-stack-fix.patch
  [IDE] siimage.c: fix PIO settings programming

ide-siimage-sil3114.patch
  [IDE] siimage.c: add very basic support for Silicon Image 3114 SATA

ide-cmd640-pci1.patch
  [IDE] cmd640.c: fix PCI type1 access

ide-pdc_old-pio-fix.patch
  [IDE] pdc202xx_old.c: fix PIO autotuning

ide-pdc_old-udma66-fix.patch
  [IDE] pdc202xx_old.c: fix enabling 66MHz clock for modes > UDMA2

ide-pdc_old-66mhz_clock-fix.patch
  [IDE] pdc202xx_old.c: sanitize 66MHz clock use

nforce2-disconnect-quirk.patch
  [x86] fix lockups with APIC support on nForce2

nforce2-apic.patch
  [x86] do not wrongly override mp_ExtINT IRQ

ide-recovery-time.patch
  [IDE] remove dead and broken DISK_RECOVERY_TIME support

ide-pdc_new-proc.patch
  [IDE] pdc202xx_new.c: remove useless /proc/ide/pdcnew

