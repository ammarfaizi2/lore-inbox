Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSKKWdu>; Mon, 11 Nov 2002 17:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKKWdu>; Mon, 11 Nov 2002 17:33:50 -0500
Received: from services.cam.org ([198.73.180.252]:11848 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261523AbSKKWdt>;
	Mon, 11 Nov 2002 17:33:49 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] cs46xx compile error 2.5.47
Date: Mon, 11 Nov 2002 17:40:18 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211111740.18312.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this compiling 2.5.47

  gcc -Wp,-MD,sound/pci/cs46xx/.cs46xx_lib.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wrigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iarch//mach-generic -fomit-frame-pointer 
-nostdinc -iwithprefix include -DMODULE -include include/linux/ersions.h   
-DKBUILD_BASENAME=cs46xx_lib   -c -o sound/pci/cs46xx/cs46xx_lib.o sound/pci/cs46xx/cs_lib.c
sound/pci/cs46xx/cs46xx_lib.c: In function `_cs46xx_adjust_sample_rate':
sound/pci/cs46xx/cs46xx_lib.c:1054: structure has no member named `spos_mutex'
sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_playback_hw_params':
sound/pci/cs46xx/cs46xx_lib.c:1071: warning: unused variable `chip'
sound/pci/cs46xx/cs46xx_lib.c:1072: warning: unused variable `sample_rate'
sound/pci/cs46xx/cs46xx_lib.c:1073: warning: unused variable `period_size'
sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_capture_hw_params':
sound/pci/cs46xx/cs46xx_lib.c:1251: warning: unused variable `period_size'
sound/pci/cs46xx/cs46xx_lib.h: At top level:
sound/pci/cs46xx/cs46xx_lib.c:1028: warning: `_cs46xx_adjust_sample_rate' defined but not used
sound/pci/cs46xx/cs46xx_lib.c:1445: warning: `hw_constraints_period_sizes' defined but not used
make[3]: *** [sound/pci/cs46xx/cs46xx_lib.o] Error 1
make[2]: *** [sound/pci/cs46xx] Error 2
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2

Anyone have any ideas?

Ed Tomlinson

