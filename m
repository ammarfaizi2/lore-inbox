Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSJLV4G>; Sat, 12 Oct 2002 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJLV4G>; Sat, 12 Oct 2002 17:56:06 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:32386 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261361AbSJLV4E> convert rfc822-to-8bit; Sat, 12 Oct 2002 17:56:04 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.42 (-mm): AIC7XXX_BUILD_FIRMWARE=y NO go.
Date: Sun, 13 Oct 2002 00:01:47 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210130001.47484.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f drivers/scsi/aic7xxx/Makefile
drivers/scsi/aic7xxx/aicasm/aicasm -I. -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
                         -o drivers/scsi/aic7xxx/aic7xxx_seq.h 
drivers/scsi/aic7xxx/aic7xxx.seq
aic7xxx.reg: No such file or directory
drivers/scsi/aic7xxx/aicasm/aicasm: Stopped at file 
drivers/scsi/aic7xxx/aic7xxx.seq, line 89 - Unable to open input file
drivers/scsi/aic7xxx/aicasm/aicasm: Removing 
drivers/scsi/aic7xxx/aic7xxx_seq.h due to error
drivers/scsi/aic7xxx/aicasm/aicasm: Removing 
drivers/scsi/aic7xxx/aic7xxx_reg.h due to error
make[3]: *** [drivers/scsi/aic7xxx/aic7xxx_seq.h] Error 70
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

With "# CONFIG_AIC7XXX_BUILD_FIRMWARE" in the first place and then 
recompilation with "AIC7XXX_BUILD_FIRMWARE=y" it works OK.

SunWave1 src/linux# find -name aic7xxx.reg
./drivers/scsi/aic7xxx_old/aic7xxx.reg
./drivers/scsi/aic7xxx/aic7xxx.reg

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
