Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSEGXmO>; Tue, 7 May 2002 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSEGXmN>; Tue, 7 May 2002 19:42:13 -0400
Received: from pD952A78A.dip.t-dialin.net ([217.82.167.138]:23459 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315454AbSEGXmM>; Tue, 7 May 2002 19:42:12 -0400
Date: Tue, 7 May 2002 17:42:11 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HCIRESETSTAT, HCIGETINFO on sparc64, ppc64
Message-ID: <Pine.LNX.4.44.0205071703490.15559-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in arch/(spar|pp)c64/kernel/ioctl32.c, we have

COMPATIBLE_IOCTL(HCIRESETSTAT)
COMPATIBLE_IOCTL(HCIGETINFO)

But both HCIRESETSTAT and HCIGETINFO are never defined.
I think we'll kick them.

diff -Nur -x SCCA -x *.o -x .* -x *.rev linux-2.5/arch/ppc64/kernel/ioctl32.c thunder-2.5/arch/ppc64/kernel/ioctl32.c
--- linux-2.5/arch/ppc64/kernel/ioctl32.c	Tue May  7 14:27:07 2002
+++ thunder-2.5/arch/ppc64/kernel/ioctl32.c	Tue May  7 17:36:37 2002
@@ -4336,8 +4336,6 @@
 COMPATIBLE_IOCTL(HCIDEVUP),
 COMPATIBLE_IOCTL(HCIDEVDOWN),
 COMPATIBLE_IOCTL(HCIDEVRESET),
-COMPATIBLE_IOCTL(HCIRESETSTAT),
-COMPATIBLE_IOCTL(HCIGETINFO),
 COMPATIBLE_IOCTL(HCIGETDEVLIST),
 COMPATIBLE_IOCTL(HCISETRAW),
 COMPATIBLE_IOCTL(HCISETSCAN),
diff -Nur -x SCCA -x *.o -x .* -x *.rev linux-2.5/arch/sparc64/kernel/ioctl32.c thunder-2.5/arch/sparc64/kernel/ioctl32.c
--- linux-2.5/arch/sparc64/kernel/ioctl32.c	Tue May  7 14:27:14 2002
+++ thunder-2.5/arch/sparc64/kernel/ioctl32.c	Tue May  7 17:34:22 2002
@@ -4553,8 +4553,6 @@
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
 COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIRESETSTAT)
-COMPATIBLE_IOCTL(HCIGETINFO)
 COMPATIBLE_IOCTL(HCIGETDEVLIST)
 COMPATIBLE_IOCTL(HCISETRAW)
 COMPATIBLE_IOCTL(HCISETSCAN)

Regards,
Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");



