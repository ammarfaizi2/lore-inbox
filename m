Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317218AbSFBSsj>; Sun, 2 Jun 2002 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317219AbSFBSsi>; Sun, 2 Jun 2002 14:48:38 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:39629 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317218AbSFBSsh>; Sun, 2 Jun 2002 14:48:37 -0400
Date: Sun, 2 Jun 2002 12:48:30 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kbuild-2.5: make drivers/scsi/script_asm.pl hide its directory
Message-ID: <Pine.LNX.4.44.0206021246250.14017-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5: drivers/scsi/script_asm.pl won't expose its directory any more 
            in the generated files

This is more or less a beautifying patch, but rather supportive.

diff -Nur kbuild-2.5/drivers/scsi/script_asm.pl kbuild-2.5/drivers/scsi/script_asm.pl
--- kbuild-2.5/drivers/scsi/script_asm.pl Sat Jun  1 16:19:36 2002
+++ kbuild-2.5/drivers/scsi/script_asm.pl Sat Jun  1 16:19:36 2002 +0000 thunder (thunder-2.5/drivers/scsi/script_asm.pl 1.1 0644)
@@ -896,7 +896,8 @@
 open (OUTPUT, ">$output") || die "$0 : can't open $output for writing\n";
 open (OUTPUTU, ">$outputu") || die "$0 : can't open $outputu for writing\n";
 
-print OUTPUT "/* DO NOT EDIT - Generated automatically by ".$0." */\n";
+($_ = $0) =~ s:.*/::;
+print OUTPUT "/* DO NOT EDIT - Generated automatically by ".$_." */\n";
 print OUTPUT "static u32 ".$prefix."SCRIPT[] = {\n";
 $instructions = 0;
 for ($i = 0; $i < $#code; ) {
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

