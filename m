Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTBDQ7e>; Tue, 4 Feb 2003 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTBDQ7e>; Tue, 4 Feb 2003 11:59:34 -0500
Received: from pasky.ji.cz ([62.44.12.54]:10750 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S266686AbTBDQ7b>;
	Tue, 4 Feb 2003 11:59:31 -0500
Date: Tue, 4 Feb 2003 18:09:03 +0100
From: Petr Baudis <pasky@ucw.cz>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Update of Documentation/magic-number.txt
Message-ID: <20030204170903.GH10207@pasky.ji.cz>
Mail-Followup-To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.59) updates Documentation/magic-number.txt to the
current state of kernel. It includes changes both before 2.5.50 (which were
included in few previous versions of this patch, which were unfortunately
ignored) and the changes after (those I noticed), until 2.5.59. Note that I
will probably make another update after few further kernel releases.

  I hope the patch is ok, there should be no problems with it. Please apply.

 magic-number.txt |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

  Kind regards,
				Petr Baudis

--- linux/Documentation/magic-number.txt	Tue Feb  4 15:36:01 2003
+++ linux+pasky/Documentation/magic-number.txt	Tue Feb  4 17:42:52 2003
@@ -43,13 +43,13 @@
 					<mailto: kgb@knm.org.pl>
 					29 Jul 1998
 
-Updated the magic table to Linux 2.5.45. Right over the feature freeze,
-but it is possible that some new magic numbers will sneak into the
-kernel before 2.6.x yet.
+Updated the magic table to Linux 2.5.59. It is after the feature freeze,
+but it is possible that some new magic numbers will sneak into the
+kernel before 2.6.x yet.
 
 					Petr Baudis
 					<pasky@ucw.cz>
-					03 Nov 2002
+					04 Feb 2003
 
 Magic Name            Number      Structure            File
 ===========================================================================
@@ -91,10 +91,11 @@
 RPORT_MAGIC           0x00525001  r_port            drivers/char/rocket_int.h
 LSEMAGIC              0x05091998  lse               drivers/fc4/fc.c
 GDTIOCTL_MAGIC        0x06030f07  gdth_iowr_str     drivers/scsi/gdth_ioctl.h
+RPCAUTH_CRED_MAGIC    0x0f4aa4f0  rpc_cred          include/linux/sunrpc/auth.h
 RIO_MAGIC             0x12345678  gs_port           drivers/char/rio/rio_linux.c
 SX_MAGIC              0x12345678  gs_port           drivers/char/sx.h
 NBD_REQUEST_MAGIC     0x12560953  nbd_request       include/linux/nbd.h
-RED_MAGIC2            0x170fc2a5  (any)             mm/slab.c
+RED_ACTIVE            0x170fc2a5  (any)             mm/slab.c
 BAYCOM_MAGIC          0x19730510  baycom_state      drivers/net/baycom_epp.c
 ISDN_X25IFACE_MAGIC   0x1e75a2b9  isdn_x25iface_proto_data
                                                     drivers/isdn/isdn_x25iface.h
@@ -108,6 +109,7 @@
 CTC_ASYNC_MAGIC       0x49344C01  ctc_tty_info      drivers/s390/net/ctctty.c
 ISDN_NET_MAGIC        0x49344C02  isdn_net_local_s  drivers/isdn/i4l/isdn_net_lib.h
 SAVEKMSG_MAGIC2       0x4B4D5347  savekmsg          arch/*/amiga/config.c
+TIMER_MAGIC           0x4b87ad6e  timer_list        include/linux/timer.h
 STLI_BOARDMAGIC       0x4bc6c825  stlibrd           include/linux/istallion.h
 CS_STATE_MAGIC        0x4c4f4749  cs_state          sound/oss/cs46xx.c
 SLAB_C_MAGIC          0x4f17a36d  kmem_cache_s      mm/slab.c
@@ -118,7 +120,8 @@
 SCC_MAGIC             0x52696368  gs_port           drivers/char/scc.h
 SAVEKMSG_MAGIC1       0x53415645  savekmsg          arch/*/amiga/config.c
 GDA_MAGIC             0x58464552  gda               include/asm-mips64/sn/gda.h
-RED_MAGIC1            0x5a2cf071  (any)             mm/slab.c
+GCT_NODE_MAGIC        0x59584c47  gct6_node         include/asm-alpha/gct.h
+RED_INACTIVE          0x5a2cf071  (any)             mm/slab.c
 STL_PORTMAGIC         0x5a7182c9  stlport           include/linux/stallion.h
 HDLCDRV_MAGIC         0x5ac6e778  hdlcdrv_state     include/linux/hdlcdrv.h
 EPCA_MAGIC            0x5c6df104  channel           include/linux/epca.h
@@ -129,6 +132,7 @@
 M3_CARD_MAGIC         0x646e6f50  m3_card           sound/oss/maestro3.c
 SLOT_MAGIC            0x67267321  slot              drivers/hotplug/cpqphp.h
 SLOT_MAGIC            0x67267322  slot              drivers/hotplug/acpiphp.h
+SLOT_MAGIC            0x67267322  slot              drivers/hotplug/cpci_hotplug.h
 LO_MAGIC              0x68797548  nbd_device        include/linux/nbd.h
 M3_STATE_MAGIC        0x734d724d  m3_state          sound/oss/maestro3.c
 STL_PANELMAGIC        0x7ef621a1  stlpanel          include/linux/stallion.h
