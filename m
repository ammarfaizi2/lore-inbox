Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSKTKDp>; Wed, 20 Nov 2002 05:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbSKTKDp>; Wed, 20 Nov 2002 05:03:45 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:41416 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264654AbSKTKDp>; Wed, 20 Nov 2002 05:03:45 -0500
Message-Id: <4.3.2.7.2.20021120110545.00b53a30@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 20 Nov 2002 11:11:02 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Patch 2.5.48 ALSA Cirrus Logic 4281
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- cs4281.c    2002-11-18 05:29:56.000000000 +0100
+++ /tmp/cs4281.c       2002-11-20 11:03:16.000000000 +0100
@@ -2109,7 +2109,7 @@
         snd_cs4281_pokeBA0(chip, BA0_HICR, BA0_HICR_CHGM);

         /* remember the status registers */
-       for (i = 0; number_of(saved_regs); i++)
+       for (i = 0; i < number_of(saved_regs); i++)
                 if (saved_regs[i])
                         chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, 
saved_regs[i]);

@@ -2153,7 +2153,7 @@
         snd_cs4281_chip_init(chip, 0);

         /* restore the status registers */
-       for (i = 0; number_of(saved_regs); i++)
+       for (i = 0; i < number_of(saved_regs); i++)
                 if (saved_regs[i])
                         snd_cs4281_pokeBA0(chip, saved_regs[i], 
chip->suspend_regs[i]);

