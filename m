Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274298AbRJJCrF>; Tue, 9 Oct 2001 22:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJJCq4>; Tue, 9 Oct 2001 22:46:56 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:40064 "EHLO
	c0mailgw01.prontomail.com") by vger.kernel.org with ESMTP
	id <S274298AbRJJCqp>; Tue, 9 Oct 2001 22:46:45 -0400
Message-ID: <3BC3B6A8.4021B2AC@starband.net>
Date: Tue, 09 Oct 2001 22:47:04 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7XXX_OLD compile error.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By just commenting it out, SCSI has about 40 nice errors upon startup.

The error is again posted below the differences of 2.4.7 and 2.4.11

In 2.4.7:

  11964
  11965 /* Eventually this will go into an include file, but this will
be later
        */
  11966 static Scsi_Host_Template driver_template = AIC7XXX;
  11967
  11968 #include "scsi_module.c"
  11969
  11970 /*

In 2.4.11:

  11964 #include "aic7xxx_old/aic7xxx_proc.c"
  11965
  11966 MODULE_LICENSE("Dual BSD/GPL");
  11967
  11968
  11969 /* Eventually this will go into an include file, but this will
be later
        */
  11970 static Scsi_Host_Template driver_template = AIC7XXX;
  11971
  11972 #include "scsi_module.c"
  11973

make[3]: Entering directory `/usr/src/linux-2.4.11/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o
scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o
scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage
class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.11/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.11/drivers'
make: *** [_dir_drivers] Error 2
[root@war linux]#


