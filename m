Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271776AbTGROAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGRNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:55:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12421
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271724AbTGRNv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:51:56 -0400
Date: Fri, 18 Jul 2003 15:06:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181406.h6IE6FH9017670@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: updated magic number tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Fabian Frederick)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/Documentation/magic-number.txt linux-2.6.0-test1-ac2/Documentation/magic-number.txt
--- linux-2.6.0-test1/Documentation/magic-number.txt	2003-07-10 21:10:55.000000000 +0100
+++ linux-2.6.0-test1-ac2/Documentation/magic-number.txt	2003-07-14 14:51:16.000000000 +0100
@@ -51,6 +51,13 @@
 					<pasky@ucw.cz>
 					03 Nov 2002
 
+Updated the magic table to Linux 2.5.74.
+
+					Fabian Frederick
+					<ffrederick@users.sourceforge.net>
+					09 Jul 2003
+
+
 Magic Name            Number      Structure            File
 ===========================================================================
 PG_MAGIC              'P'         pg_{read,write}_hdr include/linux/pg.h
@@ -62,10 +69,12 @@
 HDLC_MAGIC            0x239e      n_hdlc            drivers/char/n_hdlc.c
 APM_BIOS_MAGIC        0x4101      apm_user          arch/i386/kernel/apm.c
 CYCLADES_MAGIC        0x4359      cyclades_port     include/linux/cyclades.h
+DB_MAGIC              0x4442      fc_info           drivers/net/iph5526_novram.c	
+DL_MAGIC              0x444d      fc_info           drivers/net/iph5526_novram.c
 FASYNC_MAGIC          0x4601      fasync_struct     include/linux/fs.h
+FF_MAGIC              0x4646      fc_info           drivers/net/iph5526_novram.c
 ISICOM_MAGIC          0x4d54      isi_port          include/linux/isicom.h
-PTY_MAGIC             0x5001      (none at the moment)
-                                                    drivers/char/pty.c
+PTY_MAGIC             0x5001                        drivers/char/pty.c   	
 PPP_MAGIC             0x5002      ppp               include/linux/if_pppvar.h
 SERIAL_MAGIC          0x5301      async_struct      include/linux/serial.h
 SSTATE_MAGIC          0x5302      serial_state      include/linux/serial.h
@@ -81,9 +90,9 @@
 MGSLPC_MAGIC          0x5402      mgslpc_info       drivers/char/pcmcia/synclink_cs.c
 TTY_LDISC_MAGIC       0x5403      tty_ldisc         include/linux/tty_ldisc.h
 USB_SERIAL_MAGIC      0x6702      usb_serial        drivers/usb/serial/usb-serial.h
+FULL_DUPLEX_MAGIC     0x6969                        drivers/net/tulip/de2104x.c
 USB_BLUETOOTH_MAGIC   0x6d02      usb_bluetooth     drivers/usb/class/bluetty.c
-RFCOMM_TTY_MAGIC      0x6d02      (note at the moment)
-                                                    net/bluetooth/rfcomm/tty.c
+RFCOMM_TTY_MAGIC      0x6d02                        net/bluetooth/rfcomm/tty.c      
 USB_SERIAL_PORT_MAGIC 0x7301      usb_serial_port   drivers/usb/serial/usb-serial.h
 CG_MAGIC              0x00090255  ufs_cylinder_group include/linux/ufs_fs.h
 A2232_MAGIC           0x000a2232  gs_port           drivers/char/ser_a2232.h
@@ -91,6 +100,7 @@
 RPORT_MAGIC           0x00525001  r_port            drivers/char/rocket_int.h
 LSEMAGIC              0x05091998  lse               drivers/fc4/fc.c
 GDTIOCTL_MAGIC        0x06030f07  gdth_iowr_str     drivers/scsi/gdth_ioctl.h
+RIEBL_MAGIC           0x09051990                    drivers/net/atarilance.c
 RIO_MAGIC             0x12345678  gs_port           drivers/char/rio/rio_linux.c
 SX_MAGIC              0x12345678  gs_port           drivers/char/sx.h
 NBD_REQUEST_MAGIC     0x12560953  nbd_request       include/linux/nbd.h
@@ -120,6 +130,7 @@
 GDA_MAGIC             0x58464552  gda               include/asm-mips64/sn/gda.h
 RED_MAGIC1            0x5a2cf071  (any)             mm/slab.c
 STL_PORTMAGIC         0x5a7182c9  stlport           include/linux/stallion.h
+EEPROM_MAGIC_VALUE    0X5ab478d2  lanai_dev         drivers/atm/lanai.c					
 HDLCDRV_MAGIC         0x5ac6e778  hdlcdrv_state     include/linux/hdlcdrv.h
 EPCA_MAGIC            0x5c6df104  channel           include/linux/epca.h
 PCXX_MAGIC            0x5c6df104  channel           drivers/char/pcxx.h
@@ -127,9 +138,11 @@
 I810_STATE_MAGIC      0x63657373  i810_state        sound/oss/i810_audio.c
 TRIDENT_STATE_MAGIC   0x63657373  trient_state      sound/oss/trident.c
 M3_CARD_MAGIC         0x646e6f50  m3_card           sound/oss/maestro3.c
+FW_HEADER_MAGIC       0x65726F66  fw_header         drivers/atm/fore200e.h
 SLOT_MAGIC            0x67267321  slot              drivers/hotplug/cpqphp.h
 SLOT_MAGIC            0x67267322  slot              drivers/hotplug/acpiphp.h
 LO_MAGIC              0x68797548  nbd_device        include/linux/nbd.h
+OPROFILE_MAGIC        0x6f70726f  super_block       drivers/oprofile/oprofilefs.h
 M3_STATE_MAGIC        0x734d724d  m3_state          sound/oss/maestro3.c
 STL_PANELMAGIC        0x7ef621a1  stlpanel          include/linux/stallion.h
 VMALLOC_MAGIC         0x87654320  snd_alloc_track   sound/core/memory.c
@@ -137,11 +150,15 @@
 PWC_MAGIC             0x89DC10AB  pwc_device        drivers/usb/media/pwc.h
 NBD_REPLY_MAGIC       0x96744668  nbd_reply         include/linux/nbd.h
 STL_BOARDMAGIC        0xa2267f52  stlbrd            include/linux/stallion.h
+ENI155_MAGIC          0xa54b872d  midway_eprom	    drivers/atm/eni.h		
 SCI_MAGIC             0xbabeface  gs_port           drivers/char/sh-sci.h
 CODA_MAGIC            0xC0DAC0DA  coda_file_info    include/linux/coda_fs_i.h
+DPMEM_MAGIC           0xc0ffee11  gdt_pci_sram      drivers/scsi/gdth.h
 STLI_PORTMAGIC        0xe671c7a1  stliport          include/linux/istallion.h
 YAM_MAGIC             0xF10A7654  yam_port          drivers/net/hamradio/yam.c
 CCB_MAGIC             0xf2691ad2  ccb               drivers/scsi/ncr53c8xx.c
+QUEUE_MAGIC_FREE      0xf7e1c9a3  queue_entry       drivers/scsi/arm/queue.c
+QUEUE_MAGIC_USED      0xf7e1cc33  queue_entry       drivers/scsi/arm/queue.c
 HTB_CMAGIC            0xFEFAFEF1  htb_class         net/sched/sch_htb.c
 NMI_MAGIC             0x48414d4d455201 nmi_s        include/asm-mips64/sn/nmi.h
 
