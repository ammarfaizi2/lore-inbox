Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269475AbUIZB5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269475AbUIZB5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUIZB5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:57:40 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:31701 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269475AbUIZB5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:57:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [sched.h 6/8] move aio include to mm.h
Date: Sun, 26 Sep 2004 03:56:27 +0200
User-Agent: KMail/1.6.2
References: <20040925024513.GL9106@holomorphy.com> <20040925032419.GQ9106@holomorphy.com> <20040925032616.GR9106@holomorphy.com>
In-Reply-To: <20040925032616.GR9106@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_LHiVBW4LZdajM2R";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409260356.27499.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_LHiVBW4LZdajM2R
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Samstag, 25. September 2004 05:26, William Lee Irwin III wrote:
> This patch moves the aio inclusion from sched.h to mm.h, while leaving
> workqueue.h directly included by sched.h; a large sweep is required to
> clean up drivers including workqueue.h indirectly via sched.h

FYI: the checkheaders.pl script I recently posted here gives me
the following 175 results about potentially incorrect use of
workqueue.h.

	Arnd <><

arch/cris/arch-v10/drivers/serial.c:4947: need linux/workqueue.h: INIT_WORK
arch/cris/arch-v10/drivers/serial.h:95: need linux/workqueue.h: struct work_struct
arch/ia64/hp/sim/simserial.c:749: need linux/workqueue.h: INIT_WORK
arch/ia64/kernel/smpboot.c:388: need linux/workqueue.h: DECLARE_WORK
arch/ppc64/kernel/spu_softirq.c:53: need linux/workqueue.h: create_workqueue
arch/ppc64/kernel/spu_traps.c:988: need linux/workqueue.h: INIT_WORK
arch/s390/mm/cmm.c:44: need linux/workqueue.h: struct work_struct
arch/um/drivers/chan_kern.c:460: need linux/workqueue.h: struct work_struct
arch/um/drivers/line.c:239: need linux/workqueue.h: INIT_WORK
arch/um/drivers/port_kern.c:139: need linux/workqueue.h: DECLARE_WORK
arch/um/include/chan_kern.h:26: need linux/workqueue.h: struct work_struct
arch/x86_64/kernel/mce.c:239: need linux/workqueue.h: DECLARE_WORK
drivers/atm/ambassador.c:2244: need linux/workqueue.h: INIT_WORK
drivers/atm/ambassador.h:635: need linux/workqueue.h: struct work_struct
drivers/atm/idt77252.c:3704: need linux/workqueue.h: INIT_WORK
drivers/base/firmware_class.c:477: need linux/workqueue.h: struct work_struct
drivers/block/as-iosched.c:124: need linux/workqueue.h: struct work_struct
drivers/block/ll_rw_blk.c:250: need linux/workqueue.h: INIT_WORK
drivers/char/drm/drm_irq.h:131: need linux/workqueue.h: INIT_WORK
drivers/char/cyclades.c:5503: need linux/workqueue.h: INIT_WORK
drivers/char/epca.c:1934: need linux/workqueue.h: INIT_WORK
drivers/char/epca.h:140: need linux/workqueue.h: struct work_struct
drivers/char/esp.c:2547: need linux/workqueue.h: INIT_WORK
drivers/char/ip2main.c:933: need linux/workqueue.h: INIT_WORK
drivers/char/isicom.c:1779: need linux/workqueue.h: INIT_WORK
drivers/char/istallion.c:3333: need linux/workqueue.h: INIT_WORK
drivers/char/moxa.c:159: need linux/workqueue.h: struct work_struct
drivers/char/mxser.c:270: need linux/workqueue.h: struct work_struct
drivers/char/pcxx.c:1447: need linux/workqueue.h: INIT_WORK
drivers/char/pcxx.h:91: need linux/workqueue.h: struct work_struct
drivers/char/riscom8.c:1711: need linux/workqueue.h: INIT_WORK
drivers/char/riscom8.h:84: need linux/workqueue.h: struct work_struct
drivers/char/specialix.c:2132: need linux/workqueue.h: INIT_WORK
drivers/char/specialix_io8.h:123: need linux/workqueue.h: struct work_struct
drivers/char/stallion.c:2296: need linux/workqueue.h: INIT_WORK
drivers/char/tty_io.c:1288: need linux/workqueue.h: cancel_delayed_work
drivers/char/ip2/i2ellis.h:404: need linux/workqueue.h: struct work_struct
drivers/char/ip2/i2lib.c:334: need linux/workqueue.h: INIT_WORK
drivers/cpufreq/cpufreq.c:394: need linux/workqueue.h: INIT_WORK
drivers/ieee1394/hosts.c:140: need linux/workqueue.h: INIT_WORK
drivers/ieee1394/hosts.h:69: need linux/workqueue.h: struct work_struct
drivers/input/power.c:52: need linux/workqueue.h: DECLARE_WORK
drivers/input/keyboard/atkbd.c:28: linux/workqueue.h not needed.
drivers/isdn/act2000/module.c:582: need linux/workqueue.h: INIT_WORK
drivers/isdn/hardware/eicon/divasmain.c:21: linux/workqueue.h not needed.
drivers/isdn/hisax/amd7930_fn.c:792: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/hfc_2bds0.c:1081: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/hfc_pci.c:1724: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/hfc_sx.c:1504: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/hisax.h:458: need linux/workqueue.h: struct work_struct
drivers/isdn/hisax/icc.c:681: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/ipacx.c:998: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/isac.c:680: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/isar.c:1581: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/isdnl1.c:364: need linux/workqueue.h: INIT_WORK
drivers/isdn/hisax/w6692.c:1078: need linux/workqueue.h: INIT_WORK
drivers/isdn/hysdn/boardergo.c:451: need linux/workqueue.h: INIT_WORK
drivers/isdn/i4l/isdn_net.c:2602: need linux/workqueue.h: INIT_WORK
drivers/isdn/pcbit/drv.c:132: need linux/workqueue.h: INIT_WORK
drivers/isdn/pcbit/layer2.c:33: linux/workqueue.h not needed.
drivers/isdn/tpam/tpam_main.c:180: need linux/workqueue.h: INIT_WORK
drivers/isdn/tpam/tpam_queues.c:16: linux/workqueue.h not needed.
drivers/macintosh/adb.c:277: need linux/workqueue.h: DECLARE_WORK
drivers/macintosh/macserial.h:163: need linux/workqueue.h: struct work_struct
drivers/media/dvb/dvb-core/dvb_net.c:112: need linux/workqueue.h: struct work_struct
drivers/media/video/ir-kbd-gpio.c:169: need linux/workqueue.h: struct work_struct
drivers/message/fusion/linux_compat.h:192: need linux/workqueue.h: INIT_WORK
drivers/message/fusion/mptlan.h:24: linux/workqueue.h not needed.
drivers/message/fusion/mptscsih.h:125: linux/workqueue.h not needed.
drivers/message/i2o/i2o_core.c:50: linux/workqueue.h not needed.
drivers/message/i2o/i2o_lan.h:139: need linux/workqueue.h: struct work_struct
drivers/message/i2o/i2o_proc.c:51: linux/workqueue.h not needed.
drivers/net/ibmveth.c:558: need linux/workqueue.h: cancel_delayed_work
drivers/net/ibmveth.h:118: need linux/workqueue.h: struct work_struct
drivers/net/iseries_veth.c:126: need linux/workqueue.h: struct work_struct
drivers/net/s2io.h:723: need linux/workqueue.h: struct work_struct
drivers/net/sungem.h:963: need linux/workqueue.h: struct work_struct
drivers/net/tg3.h:2121: need linux/workqueue.h: struct work_struct
drivers/net/tlan.h:211: need linux/workqueue.h: struct work_struct
drivers/net/e1000/e1000_main.c:525: need linux/workqueue.h: INIT_WORK
drivers/net/ixgb/ixgb.h:151: need linux/workqueue.h: struct work_struct
drivers/net/ixgb/ixgb_main.c:405: need linux/workqueue.h: INIT_WORK
drivers/net/wan/lmc/lmc_proto.c:37: linux/workqueue.h not needed.
drivers/net/wan/pc300_tty.c:107: need linux/workqueue.h: struct work_struct
drivers/net/wan/sdla_chdlc.c:161: need linux/workqueue.h: struct work_struct
drivers/net/wan/sdla_ppp.c:215: need linux/workqueue.h: struct work_struct
drivers/net/wan/sdlamain.c:217: need linux/workqueue.h: DECLARE_WORK
drivers/net/wireless/prism54/islpci_dev.c:744: need linux/workqueue.h: INIT_WORK
drivers/net/wireless/prism54/islpci_mgt.c:388: need linux/workqueue.h: INIT_WORK
drivers/net/wireless/orinoco.c:4163: need linux/workqueue.h: INIT_WORK
drivers/pci/hotplug/cpqphp.h:318: need linux/workqueue.h: struct work_struct
drivers/pci/hotplug/cpqphp_core.c:39: linux/workqueue.h not needed.
drivers/pci/hotplug/cpqphp_ctrl.c:34: linux/workqueue.h not needed.
drivers/pci/hotplug/cpqphp_nvram.c:35: linux/workqueue.h not needed.
drivers/pci/hotplug/cpqphp_pci.c:34: linux/workqueue.h not needed.
drivers/pci/hotplug/cpqphp_sysfs.c:34: linux/workqueue.h not needed.
drivers/pci/hotplug/pciehp_core.c:38: linux/workqueue.h not needed.
drivers/pci/hotplug/pciehp_ctrl.c:35: linux/workqueue.h not needed.
drivers/pci/hotplug/pciehp_pci.c:35: linux/workqueue.h not needed.
drivers/pci/hotplug/pciehp_sysfs.c:34: linux/workqueue.h not needed.
drivers/pci/hotplug/shpchp_core.c:38: linux/workqueue.h not needed.
drivers/pci/hotplug/shpchp_ctrl.c:35: linux/workqueue.h not needed.
drivers/pci/hotplug/shpchp_pci.c:35: linux/workqueue.h not needed.
drivers/pci/hotplug/shpchp_sysfs.c:34: linux/workqueue.h not needed.
drivers/pcmcia/i82092.c:17: linux/workqueue.h not needed.
drivers/pcmcia/i82365.c:48: linux/workqueue.h not needed.
drivers/pcmcia/tcic.c:46: linux/workqueue.h not needed.
drivers/pcmcia/yenta_socket.c:16: linux/workqueue.h not needed.
drivers/s390/block/dasd.c:105: need linux/workqueue.h: INIT_WORK
drivers/s390/char/ctrlchar.c:27: need linux/workqueue.h: DECLARE_WORK
drivers/s390/char/tape_block.c:261: need linux/workqueue.h: INIT_WORK
drivers/s390/cio/css.c:312: need linux/workqueue.h: DECLARE_WORK
drivers/s390/cio/device_fsm.c:162: need linux/workqueue.h: PREPARE_WORK
drivers/s390/cio/qdio.c:1756: need linux/workqueue.h: PREPARE_WORK
drivers/s390/net/lcs.c:337: need linux/workqueue.h: INIT_WORK
drivers/s390/net/qeth.h:702: need linux/workqueue.h: struct work_struct
drivers/s390/scsi/zfcp_erp.c:1733: need linux/workqueue.h: struct work_struct
drivers/scsi/NCR5380.c:1004: need linux/workqueue.h: INIT_WORK
drivers/scsi/NCR5380.h:276: need linux/workqueue.h: struct work_struct
drivers/scsi/ipr.c:5618: need linux/workqueue.h: INIT_WORK
drivers/scsi/ipr.h:900: need linux/workqueue.h: struct work_struct
drivers/serial/68328serial.c:1484: need linux/workqueue.h: INIT_WORK
drivers/serial/68328serial.h:162: need linux/workqueue.h: struct work_struct
drivers/serial/68360serial.c:252: need linux/workqueue.h: struct work_struct
drivers/serial/mcfserial.c:1722: need linux/workqueue.h: INIT_WORK
drivers/serial/mcfserial.h:66: need linux/workqueue.h: struct work_struct
drivers/usb/class/bluetty.c:197: need linux/workqueue.h: struct work_struct
drivers/usb/class/cdc-acm.c:151: need linux/workqueue.h: struct work_struct
drivers/usb/core/hcd.c:1597: need linux/workqueue.h: INIT_WORK
drivers/usb/core/hcd.h:70: need linux/workqueue.h: struct work_struct
drivers/usb/core/hub.c:499: need linux/workqueue.h: INIT_WORK
drivers/usb/host/ohci-mem.c:36: need linux/workqueue.h: INIT_WORK
drivers/usb/host/ohci.h:378: need linux/workqueue.h: struct work_struct
drivers/usb/gadget/ether.c:117: need linux/workqueue.h: struct work_struct
drivers/usb/net/kaweth.c:224: need linux/workqueue.h: struct work_struct
drivers/usb/serial/usb-serial.c:1075: need linux/workqueue.h: INIT_WORK
drivers/usb/serial/usb-serial.h:112: need linux/workqueue.h: struct work_struct
drivers/usb/serial/whiteheat.c:231: need linux/workqueue.h: struct work_struct
drivers/video/pxafb.c:1072: need linux/workqueue.h: INIT_WORK
drivers/video/pxafb.h:90: need linux/workqueue.h: struct work_struct
drivers/video/sa1100fb.c:1723: need linux/workqueue.h: INIT_WORK
drivers/video/sa1100fb.h:105: need linux/workqueue.h: struct work_struct
drivers/video/console/fbcon.c:587: need linux/workqueue.h: INIT_WORK
fs/ncpfs/inode.c:583: need linux/workqueue.h: INIT_WORK
fs/nfs/idmap.c:46: linux/workqueue.h not needed.
fs/nfs/nfs4renewd.c:90: need linux/workqueue.h: cancel_delayed_work
fs/smbfs/sock.c:22: linux/workqueue.h not needed.
fs/xfs/linux-2.6/xfs_buf.h:147: need linux/workqueue.h: struct work_struct
include/linux/cyclades.h:606: need linux/workqueue.h: struct work_struct
include/linux/hayesesp.h:103: need linux/workqueue.h: struct work_struct
include/linux/if_wanpipe_common.h:35: need linux/workqueue.h: struct work_struct
include/linux/isdn.h:383: need linux/workqueue.h: struct work_struct
include/linux/isicom.h:154: need linux/workqueue.h: struct work_struct
include/linux/istallion.h:76: need linux/workqueue.h: struct work_struct
include/linux/jffs2_fs_sb.h:8: linux/workqueue.h not needed.
include/linux/kernelcapi.h:67: need linux/workqueue.h: struct work_struct
include/linux/reiserfs_fs.h:19: linux/workqueue.h not needed.
include/linux/serial167.h:52: need linux/workqueue.h: struct work_struct
include/linux/stallion.h:100: need linux/workqueue.h: struct work_struct
include/linux/workqueue.h:5: need linux/workqueue.h: _LINUX_WORKQUEUE_H
include/linux/sunrpc/debug.h:15: linux/workqueue.h not needed.
include/linux/sunrpc/rpc_pipe_fs.h:33: need linux/workqueue.h: struct work_struct
include/linux/sunrpc/types.h:13: linux/workqueue.h not needed.
include/linux/sunrpc/xprt.h:173: need linux/workqueue.h: struct work_struct
include/net/irda/ircomm_tty.h:103: need linux/workqueue.h: struct work_struct
init/main.c:49: linux/workqueue.h not needed.
kernel/kthread.c:123: need linux/workqueue.h: DECLARE_WORK
net/bluetooth/hci_sock.c:40: linux/workqueue.h not needed.
net/irda/ircomm/ircomm_param.c:32: linux/workqueue.h not needed.
net/irda/ircomm/ircomm_tty.c:392: need linux/workqueue.h: INIT_WORK
net/sctp/inqueue.c:57: need linux/workqueue.h: INIT_WORK
net/sunrpc/auth_gss/auth_gss.c:53: linux/workqueue.h not needed.
net/sunrpc/clnt.c:33: linux/workqueue.h not needed.
net/sunrpc/sunrpc_syms.c:24: linux/workqueue.h not needed.
sound/core/init.c:121: need linux/workqueue.h: INIT_WORK

--Boundary-02=_LHiVBW4LZdajM2R
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBViHL5t5GS2LDRf4RArZWAJ9tm3aRsXtgdHcoH2x4HxoZyyai0QCeKaeR
+tcBLN8EzJXGxDx51QWO1yI=
=2EFp
-----END PGP SIGNATURE-----

--Boundary-02=_LHiVBW4LZdajM2R--
