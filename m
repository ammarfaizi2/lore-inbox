Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRDGVz7>; Sat, 7 Apr 2001 17:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRDGVzt>; Sat, 7 Apr 2001 17:55:49 -0400
Received: from cogent.ecohler.net ([216.135.202.106]:40379 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S131985AbRDGVzg>; Sat, 7 Apr 2001 17:55:36 -0400
From: lists@sapience.com
Date: Sat, 7 Apr 2001 17:55:05 -0400
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aic7xxx 6.1.10 and 2.4.4-pre1
Message-ID: <20010407175505.A25801@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I had tried 6.1.8 + 2.4.3 and had problems which included messages like 
   'aic7xxx_abort returns 8194' and machine froze up shortly after X started.
   This on redhat 7.0. Sorry but since I was unable to even boot back the
   prev kernel (2.4.0) I cant provide any more detailed information. I have
   been following to see a few other folks have had some issues with scsi as well.

   I have 2 lvd scsi disks and one ide, AH 2940U2 - top of lilo included below -
   and bios boot order is scsi first.

   So I started again - installed redhat 7.0.9.
   took 2.4.4-pre1  and patched it with 
   linux-aic7xxx-6.1.10-2.4.3.patch

   Patch applied cleanly but when I compile it complains a little:

   In file included from aic7xxx_linux.c:131:
   aic7xxx_osm.h: In function `ahc_pci_read_config':
   aic7xxx_osm.h:862: warning: control reaches end of non-void function
   
   (for several .c files but always refers to 'ahc_pci_read_config')

   In file included from ... include/linux/raid/md.h:50,
   from init/main.c:24: ..include/linux/raid/md_k.h: In function `pers_to_level':
   raid/md_k.h:39: warning: control reaches end of non-void function

   Do I need to be concerned here?  I dont whether the presumed missing return is
   a bad thing or not. 

   I have not yet tried to boot this kernel.

   Also


# lilo.conf
boot=/dev/sda
disk=/dev/sda
     bios=0x80
disk=/dev/sdb
     bios=0x81
disk=/dev/hda
     bios=0x82
map=/boot/map
install=/boot/boot.b
prompt
timeout=50
message=/boot/message
lba32
default=linux

...

