Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSKDRuy>; Mon, 4 Nov 2002 12:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbSKDRuy>; Mon, 4 Nov 2002 12:50:54 -0500
Received: from pasky.ji.cz ([62.44.12.54]:31728 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262381AbSKDRuv>;
	Mon, 4 Nov 2002 12:50:51 -0500
Date: Mon, 4 Nov 2002 18:57:23 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Update of Documentation/magic-number.txt
Message-ID: <20021104175723.GE2502@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.45) updates Documentation/magic-number.txt to the
current state of kernel. It was pretty abadonded in the last few years, so I
did my best, but it's possible (given the charge and intensity of the magical
field covering the whole kernel) that I still missed some of the magic numbers
- so, if you will notice your favourite magic number missing there, please
speak up.

  Also, since some of the subsystems introduce fairly large amount of magic
numbers, I placed simply references to the header files where the magic numbers
are defined to the end of the file. I also made few tidyups (removal of tabs
and reordering of few misplaced magics).

  I hope the patch is ok, there should be no problems with it. Please apply.

 magic-number.txt |   92 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 75 insertions(+), 17 deletions(-)

  Kind regards,
				Petr Baudis

--- linux/Documentation/magic-number.txt	Thu Aug  1 23:16:03 2002
+++ linux+pasky/Documentation/magic-number.txt	Mon Nov  4 18:47:29 2002
@@ -43,57 +43,115 @@
 					<mailto: kgb@knm.org.pl>
 					29 Jul 1998
 
+Updated the magic table to Linux 2.5.45. Right over the feature freeze,
+but it is possible that some new magic numbers will sneak into the
+kernel before 2.6.x yet.
+
+					Petr Baudis
+					<pasky@ucw.cz>
+					03 Nov 2002
+
 Magic Name            Number      Structure            File
 ===========================================================================
-PG_MAGIC	      'P'	  pg_{read,write}_hdr include/linux/pg.h
+PG_MAGIC              'P'         pg_{read,write}_hdr include/linux/pg.h
+CMAGIC                0x0111      user              include/linux/a.out.h
 MKISS_DRIVER_MAGIC    0x04bf      mkiss_channel     drivers/net/mkiss.h
 RISCOM8_MAGIC         0x0907      riscom_port       drivers/char/riscom8.h
+SPECIALIX_MAGIC       0x0907      specialix_port    drivers/char/specialix_io8.h
+AURORA_MAGIC          0x0A18      Aurora_port       drivers/sbus/char/aurora.h
+HDLC_MAGIC            0x239e      n_hdlc            drivers/char/n_hdlc.c
 APM_BIOS_MAGIC        0x4101      apm_user          arch/i386/kernel/apm.c
 CYCLADES_MAGIC        0x4359      cyclades_port     include/linux/cyclades.h
 FASYNC_MAGIC          0x4601      fasync_struct     include/linux/fs.h
-PTY_MAGIC	      0x5001	  (none at the moment)
-					            drivers/char/pty.c
-PPP_MAGIC             0x5002      ppp               include/linux/if_ppp.h
+ISICOM_MAGIC          0x4d54      isi_port          include/linux/isicom.h
+PTY_MAGIC             0x5001      (none at the moment)
+                                                    drivers/char/pty.c
+PPP_MAGIC             0x5002      ppp               include/linux/if_pppvar.h
 SERIAL_MAGIC          0x5301      async_struct      include/linux/serial.h
 SSTATE_MAGIC          0x5302      serial_state      include/linux/serial.h
 SLIP_MAGIC            0x5302      slip              drivers/net/slip.h
 STRIP_MAGIC           0x5303      strip             drivers/net/strip.c
 X25_ASY_MAGIC         0x5303      x25_asy           drivers/net/x25_asy.h
-SIXPACK_MAGIC	      0x5304      sixpack	    drivers/net/hamradio/6pack.h
+SIXPACK_MAGIC         0x5304      sixpack           drivers/net/hamradio/6pack.h
 AX25_MAGIC            0x5316      ax_disp           drivers/net/mkiss.h
 ESP_MAGIC             0x53ee      esp_struct        drivers/char/esp.h
 TTY_MAGIC             0x5401      tty_struct        include/linux/tty.h
+MGSL_MAGIC            0x5401      mgsl_info         drivers/char/synclink.c
 TTY_DRIVER_MAGIC      0x5402      tty_driver        include/linux/tty_driver.h
+MGSLPC_MAGIC          0x5402      mgslpc_info       drivers/char/pcmcia/synclink_cs.c
 TTY_LDISC_MAGIC       0x5403      tty_ldisc         include/linux/tty_ldisc.h
-SPECIALIX_MAGIC       0x0907      specialix_port    drivers/char/specialix_io8.h
-CG_MAGIC	      0x090255    ufs_cylinder_group include/linux/ufs_fs.h
-RPORT_MAGIC           0x525001    r_port            drivers/char/rocket_int.h
-GDTIOCTL_MAGIC	      0x06030f07  gdth_iowr_str     drivers/scsi/gdth_ioctl.h
+USB_SERIAL_MAGIC      0x6702      usb_serial        drivers/usb/serial/usb-serial.h
+USB_BLUETOOTH_MAGIC   0x6d02      usb_bluetooth     drivers/usb/class/bluetty.c
+RFCOMM_TTY_MAGIC      0x6d02      (note at the moment)
+                                                    net/bluetooth/rfcomm/tty.c
+USB_SERIAL_PORT_MAGIC 0x7301      usb_serial_port   drivers/usb/serial/usb-serial.h
+CG_MAGIC              0x00090255  ufs_cylinder_group include/linux/ufs_fs.h
+A2232_MAGIC           0x000a2232  gs_port           drivers/char/ser_a2232.h
+SOLARIS_SOCKET_MAGIC  0x000ADDED  sol_socket_struct arch/sparc64/solaris/socksys.h
+RPORT_MAGIC           0x00525001  r_port            drivers/char/rocket_int.h
+LSEMAGIC              0x05091998  lse               drivers/fc4/fc.c
+GDTIOCTL_MAGIC        0x06030f07  gdth_iowr_str     drivers/scsi/gdth_ioctl.h
+RIO_MAGIC             0x12345678  gs_port           drivers/char/rio/rio_linux.c
+SX_MAGIC              0x12345678  gs_port           drivers/char/sx.h
 NBD_REQUEST_MAGIC     0x12560953  nbd_request       include/linux/nbd.h
-SLAB_RED_MAGIC2       0x170fc2a5  (any)             mm/slab.c
+RED_MAGIC2            0x170fc2a5  (any)             mm/slab.c
 BAYCOM_MAGIC          0x19730510  baycom_state      drivers/net/baycom_epp.c
 ISDN_X25IFACE_MAGIC   0x1e75a2b9  isdn_x25iface_proto_data
                                                     drivers/isdn/isdn_x25iface.h
 ECP_MAGIC             0x21504345  cdkecpsig         include/linux/cdk.h
+LSOMAGIC              0x27091997  lso               drivers/fc4/fc.c
 LSMAGIC               0x2a3b4d2a  ls                drivers/fc4/fc.c
-LSOMAGIC              0x2a3c4e3c  lso               drivers/fc4/fc.c
 WANPIPE_MAGIC         0x414C4453  sdla_{dump,exec}  include/linux/wanpipe.h
-CODA_CNODE_MAGIC      0x47114711  coda_inode_info   include/linux/coda_fs_i.h
+CS_CARD_MAGIC         0x43525553  cs_card           sound/oss/cs46xx.c
+LABELCL_MAGIC         0x4857434c  labelcl_info_s    include/asm/ia64/sn/labelcl.h
 ISDN_ASYNC_MAGIC      0x49344C01  modem_info        include/linux/isdn.h
-ISDN_NET_MAGIC        0x49344C02  isdn_net_local_s  include/linux/isdn.h
+CTC_ASYNC_MAGIC       0x49344C01  ctc_tty_info      drivers/s390/net/ctctty.c
+ISDN_NET_MAGIC        0x49344C02  isdn_net_local_s  drivers/isdn/i4l/isdn_net_lib.h
+SAVEKMSG_MAGIC2       0x4B4D5347  savekmsg          arch/*/amiga/config.c
 STLI_BOARDMAGIC       0x4bc6c825  stlibrd           include/linux/istallion.h
+CS_STATE_MAGIC        0x4c4f4749  cs_state          sound/oss/cs46xx.c
 SLAB_C_MAGIC          0x4f17a36d  kmem_cache_s      mm/slab.c
+COW_MAGIC             0x4f4f4f4d  cow_header_v1     arch/um/drivers/ubd_user.c
+I810_CARD_MAGIC       0x5072696E  i810_card         sound/oss/i810_audio.c
+TRIDENT_CARD_MAGIC    0x5072696E  trident_card      sound/oss/trident.c
 ROUTER_MAGIC          0x524d4157  wan_device        include/linux/wanrouter.h
-SLAB_RED_MAGIC1       0x5a2cf071  (any)             mm/slab.c
+SCC_MAGIC             0x52696368  gs_port           drivers/char/scc.h
+SAVEKMSG_MAGIC1       0x53415645  savekmsg          arch/*/amiga/config.c
+GDA_MAGIC             0x58464552  gda               include/asm-mips64/sn/gda.h
+RED_MAGIC1            0x5a2cf071  (any)             mm/slab.c
 STL_PORTMAGIC         0x5a7182c9  stlport           include/linux/stallion.h
 HDLCDRV_MAGIC         0x5ac6e778  hdlcdrv_state     include/linux/hdlcdrv.h
-EPCA_MAGIC     	      0x5c6df104  channel           include/linux/epca.h
+EPCA_MAGIC            0x5c6df104  channel           include/linux/epca.h
 PCXX_MAGIC            0x5c6df104  channel           drivers/char/pcxx.h
+KV_MAGIC              0x5f4b565f  kernel_vars_s     include/asm-mips64/sn/klkernvars.h
+I810_STATE_MAGIC      0x63657373  i810_state        sound/oss/i810_audio.c
+TRIDENT_STATE_MAGIC   0x63657373  trient_state      sound/oss/trident.c
+M3_CARD_MAGIC         0x646e6f50  m3_card           sound/oss/maestro3.c
+SLOT_MAGIC            0x67267321  slot              drivers/hotplug/cpqphp.h
+SLOT_MAGIC            0x67267322  slot              drivers/hotplug/acpiphp.h
 LO_MAGIC              0x68797548  nbd_device        include/linux/nbd.h
+M3_STATE_MAGIC        0x734d724d  m3_state          sound/oss/maestro3.c
 STL_PANELMAGIC        0x7ef621a1  stlpanel          include/linux/stallion.h
+VMALLOC_MAGIC         0x87654320  snd_alloc_track   sound/core/memory.c
+KMALLOC_MAGIC         0x87654321  snd_alloc_track   sound/core/memory.c
+PWC_MAGIC             0x89DC10AB  pwc_device        drivers/usb/media/pwc.h
 NBD_REPLY_MAGIC       0x96744668  nbd_reply         include/linux/nbd.h
 STL_BOARDMAGIC        0xa2267f52  stlbrd            include/linux/stallion.h
-SLAB_MAGIC_ALLOC      0xa5c32f2b  kmem_slab_s       mm/slab.c
-SLAB_MAGIC_DESTROYED  0xb2f23c5a  kmem_slab_s       mm/slab.c
+SCI_MAGIC             0xbabeface  gs_port           drivers/char/sh-sci.h
+CODA_MAGIC            0xC0DAC0DA  coda_file_info    include/linux/coda_fs_i.h
 STLI_PORTMAGIC        0xe671c7a1  stliport          include/linux/istallion.h
+YAM_MAGIC             0xF10A7654  yam_port          drivers/net/hamradio/yam.c
 CCB_MAGIC             0xf2691ad2  ccb               drivers/scsi/ncr53c8xx.c
+HTB_CMAGIC            0xFEFAFEF1  htb_class         net/sched/sch_htb.c
+NMI_MAGIC             0x48414d4d455201 nmi_s        include/asm-mips64/sn/nmi.h
+
+Note that there are also defined special per-driver magic numbers in sound
+memory managment. See include/sound/sndmagic.h for complete list of them. Many
+OSS sound drivers have their magic numbers constructed from the soundcard PCI
+ID - these are not listed here as well.
+
+IrDA subsystem also uses large number of own magic numbers, see
+include/net/irda/irda.h for a complete list of them.
+
+HFS is another larger user of magic numbers - you can find them in
+fs/hfs/hfs.h.
