Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268454AbTBZAu5>; Tue, 25 Feb 2003 19:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTBZAu5>; Tue, 25 Feb 2003 19:50:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268454AbTBZAup>;
	Tue, 25 Feb 2003 19:50:45 -0500
Subject: 2.5 porting items
From: John Cherry <cherry@osdl.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linstab@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1046221420.20288.17.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Feb 2003 17:03:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of indicators exist in the code that show that porting
activities are still outstanding on 2.5.  For instance, the module use
count changes are flagged by warnings (_MOD_INC_USE_COUNT and
_MOD_DEC_USE_COUNT).  This information is generated daily and kept at

 http://www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt

Summary of porting items identified as warnings...

	MCA legacy (move driver to new sysfs API): 27 places
	Misc porting reminders: 20 reminders
	__check_region deprecations: 91 files
	Module use count changes:
		_MOD_INC_USE_COUNT deprecations: 292 files
		_MOD_DEC_USE_COUNT deprecations: 252 files

==============================================================

Details....

=====================================================
MCA legacy (move driver to new sysfs API): 27 places
=====================================================
from arch/i386/kernel/i386_ksyms.c:6: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from arch/i386/kernel/mca.c:44: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from arch/i386/kernel/traps.c:34: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/block/ps2esdi.c:42: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/isdn/eicon/eicon_mod.c:31: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/mca/mca-bus.c:29: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/mca/mca-device.c:31: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/mca/mca-driver.c:28: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/mca/mca-legacy.c:31: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/mca/mca-proc.c:33: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/net/3c509.c:73: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/3c523.c:105: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/3c527.c:95: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/at1700.c:42: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/eexpress.c:116: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/net/ibmlana.c:86: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/ne2.c:74: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/sk_mca.c:92: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/net/smc-mca.c:39: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/scsi/aha1542.c:42: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/scsi/fd_mcs.c:88: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/scsi/ibmmca.c:38: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from drivers/scsi/mca_53c9x.c:36: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/scsi/NCR_D700.c:109: include/linux/mca-legacy.h:10:2:
warning: #warning "MCA legacy - please move your driver to the new sysfs
api"
from drivers/scsi/sim710.c:35: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
from sound/oss/sb_card.c:30: include/linux/mca-legacy.h:10:2: warning:
#warning "MCA legacy - please move your driver to the new sysfs api"
In file included from drivers/net/depca.c:255:
include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - please
move your driver to the new sysfs api"

=====================================
Misc porting reminders: 20 reminders
=====================================
kernel/suspend.c:293:2: warning: #warning This might be broken. We need
to somehow wait for data to reach the disk
drivers/char/applicom.c:270:2: warning: #warning "LEAK"
drivers/char/applicom.c:534:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/mtd/devices/doc1000.c:86:2: warning: #warning This is definitely
not SMP safe. Lock the paging mechanism.
drivers/scsi/pcmcia/aha152x_stub.c:354:2: warning: #warning This does
not protect you. You need some real fix for your races.
drivers/scsi/pcmcia/fdomain_stub.c:317:2: warning: #warning This does
not protect you. You need some real fix for your races.
drivers/scsi/pcmcia/qlogic_stub.c:333:2: warning: #warning This does not
protect you. You need some real fix for your races.
drivers/char/applicom.c:270:2: warning: #warning "LEAK"
drivers/char/applicom.c:534:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/mtd/devices/doc1000.c:86:2: warning: #warning This is definitely
not SMP safe. Lock the paging mechanism.
kernel/suspend.c:293:2: warning: #warning This might be broken. We need
to somehow wait for data to reach the disk
drivers/char/applicom.c:270:2: warning: #warning "LEAK"
drivers/char/applicom.c:534:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/mtd/devices/doc1000.c:86:2: warning: #warning This is definitely
not SMP safe. Lock the paging mechanism.
drivers/scsi/pcmcia/aha152x_stub.c:354:2: warning: #warning This does
not protect you. You need some real fix for your races.
drivers/scsi/pcmcia/fdomain_stub.c:317:2: warning: #warning This does
not protect you. You need some real fix for your races.
drivers/scsi/pcmcia/qlogic_stub.c:333:2: warning: #warning This does not
protect you. You need some real fix for your races.
drivers/char/applicom.c:270:2: warning: #warning "LEAK"
drivers/char/applicom.c:534:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/mtd/devices/doc1000.c:86:2: warning: #warning This is definitely
not SMP safe. Lock the paging mechanism.

======================================
__check_region deprecations: 91 files
======================================
drivers/cdrom/cdu31a.c
drivers/cdrom/cm206.c
drivers/cdrom/isp16.c
drivers/cdrom/sbpcd.c
drivers/cdrom/sjcd.c
drivers/char/esp.c
drivers/char/ipmi/ipmi_kcs_intf.c
drivers/char/rocket.c
drivers/char/specialix.c
drivers/char/watchdog/mixcomwd.c
drivers/hotplug/acpiphp_pci.c
drivers/hotplug/cpqphp_pci.c
drivers/hotplug/ibmphp_core.c
drivers/i2c/i2c-proc.c
drivers/ide/ide-dma.c
drivers/ide/ide-probe.c
drivers/ide/legacy/ht6560b.c
drivers/ide/pci/trm290.c
drivers/input/gameport/ns558.c
drivers/isdn/act2000/act2000_isa.c
drivers/isdn/eicon/eicon_isa.c
drivers/isdn/eicon/lincfg.c
drivers/isdn/hardware/eicon/divasmain.c
drivers/isdn/hisax/elsa.c
drivers/isdn/icn/icn.c
drivers/isdn/pcbit/drv.c
drivers/isdn/sc/init.c
drivers/mtd/maps/octagon-5066.c
drivers/mtd/maps/sbc_gxx.c
drivers/net/3c509.c
drivers/net/3c515.c
drivers/net/arcnet/arc-rimi.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c
drivers/net/depca.c
drivers/net/eepro.c
drivers/net/ewrk3.c
drivers/net/hamradio/scc.c
drivers/net/hp100.c
drivers/net/irda/smc-ircc.c
drivers/net/ni5010.c
drivers/net/pcnet32.c
drivers/net/tulip/de4x5.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/sbni.c
drivers/net/wan/sdlamain.c
drivers/net/wireless/arlan.c
drivers/net/wireless/wavelan.c
drivers/parport/parport_pc.c
drivers/pcmcia/i82365.c
drivers/pcmcia/tcic.c
drivers/pnp/isapnp/core.c
drivers/pnp/resource.c
drivers/scsi/3w-xxxx.c
drivers/scsi/advansys.c
drivers/scsi/aha152x.c
drivers/scsi/atp870u.c
drivers/scsi/BusLogic.c
drivers/scsi/eata_pio.c
drivers/scsi/fdomain.c
drivers/scsi/g_NCR5380.c
drivers/scsi/psi240i.c
drivers/scsi/sym53c416.c
drivers/scsi/sym53c8xx_2/sym_glue.c
drivers/scsi/sym53c8xx.c
drivers/scsi/sym53c8xx_comm.h
drivers/scsi/tmscsim.c
drivers/serial/8250.c
drivers/telephony/ixj.c
kernel/ksyms.c
sound/isa/opti9xx/opti92x-ad1848.c
sound/oss/ad1848.c
sound/oss/cs4232.c
sound/oss/cs4232.c:110: 
drivers/char/esp.c
sound/oss/gus_card.c
sound/oss/mad16.c
sound/oss/maui.c
sound/oss/mpu401.c
sound/oss/msnd_pinnacle.c
sound/oss/opl3sa2.c
sound/oss/opl3sa.c
sound/oss/sb_common.c
sound/oss/sgalaxy.c
sound/oss/sscape.c
sound/oss/trix.c
sound/oss/wavfront.c
sound/oss/wf_midi.c
sound/pci/via82xx.c
sound/pci/ymfpci/ymfpci.c

===========================================
_MOD_INC_USE_COUNT deprecations: 292 files
===========================================
drivers/atm/eni.c
drivers/atm/idt77105.c
drivers/atm/idt77252.c
drivers/atm/lanai.c
drivers/atm/nicstar.c
drivers/atm/suni.c
drivers/atm/uPD98402.c
drivers/atm/zatm.c
drivers/block/floppy.c
drivers/block/loop.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/ftape/compressor/zftape-compress.c
drivers/char/genrtc.c
drivers/char/ip2.c
drivers/char/ip2main.c
drivers/char/isicom.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/n_hdlc.c
drivers/char/n_r3964.c
drivers/char/pcmcia/synclink_cs.c
drivers/char/raw.c
drivers/char/rio/rio_linux.c
drivers/char/riscom8.c
drivers/char/rocket.c
drivers/char/specialix.c
drivers/char/stallion.c
drivers/char/sx.c
drivers/char/synclink.c
drivers/char/synclinkmp.c
drivers/char/watchdog/acquirewdt.c
drivers/char/watchdog/ib700wdt.c
drivers/char/watchdog/machzwd.c
drivers/char/watchdog/mixcomwd.c
drivers/char/watchdog/pcwd.c
drivers/char/watchdog/sbc60xxwdt.c
drivers/char/watchdog/sc520_wdt.c
drivers/char/watchdog/softdog.c
drivers/char/watchdog/wdt_pci.c
drivers/ide/ide-probe.c
drivers/ide/legacy/ide-cs.c
drivers/ide/pci/aec62xx.c
drivers/ide/pci/alim15x3.c
drivers/ide/pci/amd74xx.c
drivers/ide/pci/cmd64x.c
drivers/ide/pci/cy82c693.c
drivers/ide/pci/hpt34x.c
drivers/ide/pci/hpt366.c
drivers/ide/pci/ns87415.c
drivers/ide/pci/opti621.c
drivers/ide/pci/pdc202xx_new.c
drivers/ide/pci/pdc202xx_old.c
drivers/ide/pci/piix.c
drivers/ide/pci/rz1000.c
drivers/ide/pci/sc1200.c
drivers/ide/pci/serverworks.c
drivers/ide/pci/siimage.c
drivers/ide/pci/sis5513.c
drivers/ide/pci/slc90e66.c
drivers/ide/pci/triflex.c
drivers/ide/pci/trm290.c
drivers/ide/pci/via82cxxx.c
drivers/input/serio/serport.c
drivers/isdn/capi/capi.c
drivers/isdn/capi/capidrv.c
drivers/isdn/capi/capifs.c
drivers/isdn/capi/kcapi.c
drivers/isdn/eicon/linchr.c
drivers/isdn/hardware/eicon/capifunc.c
drivers/isdn/hardware/eicon/capimain.c
drivers/isdn/hardware/eicon/diva_didd.c
drivers/isdn/hardware/eicon/divamnt.c
drivers/isdn/hardware/eicon/divasi.c
drivers/isdn/hardware/eicon/divasmain.c
drivers/isdn/hysdn/hysdn_net.c
drivers/isdn/i4l/isdn_bsdcomp.c
drivers/isdn/i4l/isdn_common.c
drivers/isdn/i4l/isdn_tty.c
drivers/md/linear.c
drivers/md/md.c
drivers/md/multipath.c
drivers/md/raid0.c
drivers/md/raid1.c
drivers/md/raid5.c
drivers/media/dvb/av7110/av7110.c
drivers/media/dvb/av7110/saa7146_v4l.c
drivers/media/dvb/dvb-core/dmxdev.c
drivers/media/dvb/dvb-core/dvb_demux.c
drivers/media/dvb/dvb-core/dvbdev.c
drivers/media/dvb/dvb-core/dvb_net.c
drivers/media/video/bt819.c
drivers/media/video/bt856.c
drivers/media/video/msp3400.c
drivers/media/video/saa5249.c
drivers/media/video/saa7110.c
drivers/media/video/saa7111.c
drivers/media/video/saa7185.c
drivers/media/video/tda7432.c
drivers/media/video/tda9875.c
drivers/media/video/tda9887.c
drivers/media/video/tuner-3036.c
drivers/media/video/tuner.c
drivers/media/video/tvaudio.c
drivers/media/video/zr36067.c
drivers/message/i2o/i2o_pci.c
drivers/mtd/chips/amd_flash.c
drivers/mtd/chips/cfi_cmdset_0001.c
drivers/mtd/chips/cfi_cmdset_0002.c
drivers/mtd/chips/jedec.c
drivers/mtd/chips/map_absent.c
drivers/mtd/chips/map_ram.c
drivers/mtd/chips/map_rom.c
drivers/mtd/chips/sharp.c
drivers/mtd/devices/blkmtd.c
drivers/mtd/devices/docprobe.c
drivers/mtd/maps/pcmciamtd.c
drivers/mtd/mtdcore.c
drivers/net/82596.c
drivers/net/arcnet/arc-rimi.c
drivers/net/arcnet/com20020.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c
drivers/net/bonding.c
drivers/net/bsd_comp.c
drivers/net/eepro.c
drivers/net/fc/iph5526.c
drivers/net/hamradio/baycom_epp.c
drivers/net/hamradio/baycom_par.c
drivers/net/hamradio/baycom_ser_fdx.c
drivers/net/hamradio/baycom_ser_hdx.c
drivers/net/hamradio/bpqether.c
drivers/net/hamradio/dmascc.c
drivers/net/hamradio/hdlcdrv.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/act200l.c
drivers/net/irda/girbil.c
drivers/net/irda/irport.c
drivers/net/irda/irtty.c
drivers/net/irda/irtty-sir.c
drivers/net/irda/litelink.c
drivers/net/irda/ma600.c
drivers/net/irda/mcp2120.c
drivers/net/irda/old_belkin.c
drivers/net/irda/smc-ircc.c
drivers/net/irda/toshoboe.c
drivers/net/ni65.c
drivers/net/pcmcia/3c574_cs.c
drivers/net/pcmcia/3c589_cs.c
drivers/net/pcmcia/axnet_cs.c
drivers/net/pcmcia/com20020_cs.c
drivers/net/pcmcia/fmvj18x_cs.c
drivers/net/pcmcia/nmclan_cs.c
drivers/net/pcmcia/pcnet_cs.c
drivers/net/pcmcia/smc91c92_cs.c
drivers/net/pcmcia/xirc2ps_cs.c
drivers/net/pcnet32.c
drivers/net/ppp_async.c
drivers/net/ppp_deflate.c
drivers/net/pppoe.c
drivers/net/ppp_synctty.c
drivers/net/rcpci45.c
drivers/net/rrunner.c
drivers/net/sk98lin/skge.c
drivers/net/skfp/skfddi.c
drivers/net/slip.c
drivers/net/tulip/de4x5.c
drivers/net/tulip/tulip_core.c
drivers/net/tun.c
drivers/net/wan/c101.c
drivers/net/wan/comx.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx-hw-munich.c
drivers/net/wan/comx-proto-fr.c
drivers/net/wan/comx-proto-lapb.c
drivers/net/wan/comx-proto-ppp.c
drivers/net/wan/cosa.c
drivers/net/wan/cycx_main.c
drivers/net/wan/dlci.c
drivers/net/wan/dscc4.c
drivers/net/wan/farsync.c
drivers/net/wan/hdlc_generic.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/n2.c
drivers/net/wan/pc300_drv.c
drivers/net/wan/sdla.c
drivers/net/wan/sdlamain.c
drivers/net/wan/sealevel.c
drivers/net/wan/x25_asy.c
drivers/net/wireless/airo.c
drivers/net/wireless/netwave_cs.c
drivers/net/wireless/ray_cs.c
drivers/net/wireless/strip.c
drivers/net/wireless/wavelan_cs.c
drivers/parport/init.c
drivers/parport/parport_pc.c
drivers/telephony/ixj.c
drivers/telephony/phonedev.c
drivers/usb/class/usb-midi.c
drivers/usb/media/dabusb.c
drivers/usb/media/ibmcam.c
drivers/usb/media/konicawc.c
drivers/usb/media/ov511.c
drivers/usb/media/ultracam.c
drivers/usb/misc/speedtouch.c
drivers/usb/misc/uss720.c
drivers/video/console/mdacon.c
drivers/video/cyber2000fb.c
drivers/video/pm2fb.c
fs/lockd/clntlock.c
fs/lockd/svc.c
fs/nfsd/nfssvc.c
fs/smbfs/smbiod.c
net/8021q/vlan.c
net/appletalk/ddp.c
net/atm/lec.c
net/atm/mpc.c
net/atm/pppoatm.c
net/ax25/af_ax25.c
net/bluetooth/bnep/core.c
net/bluetooth/bnep/sock.c
net/bluetooth/hci_sock.c
net/bluetooth/l2cap.c
net/bluetooth/rfcomm/core.c
net/bluetooth/rfcomm/sock.c
net/bluetooth/rfcomm/tty.c
net/bluetooth/sco.c
net/core/pktgen.c
net/decnet/af_decnet.c
net/econet/af_econet.c
net/ipv4/ip_gre.c
net/ipv4/ipip.c
net/ipv4/netfilter/arp_tables.c
net/ipv4/netfilter/ipchains_core.c
net/ipv4/netfilter/ip_conntrack_core.c
net/ipv4/netfilter/ip_conntrack_standalone.c
net/ipv4/netfilter/ipfwadm_core.c
net/ipv4/netfilter/ip_nat_helper.c
net/ipv4/netfilter/ip_nat_standalone.c
net/ipv4/netfilter/ip_tables.c
net/ipv4/netfilter/ipt_conntrack.c
net/ipv4/netfilter/ipt_helper.c
net/ipv4/netfilter/ipt_state.c
net/ipv6/af_inet6.c
net/ipv6/netfilter/ip6_tables.c
net/ipv6/sit.c
net/ipv6/tcp_ipv6.c
net/ipx/af_ipx.c
net/irda/af_irda.c
net/irda/ircomm/ircomm_tty.c
net/irda/irlan/irlan_common.c
net/irda/irnet/irnet_ppp.c
net/key/af_key.c
net/lapb/lapb_iface.c
net/llc/llc_if.c
net/llc/llc_main.c
net/netrom/af_netrom.c
net/netrom/nr_dev.c
net/packet/af_packet.c
net/rose/af_rose.c
net/rose/rose_dev.c
net/sched/cls_fw.c
net/sched/cls_route.c
net/sched/cls_rsvp.h
net/sched/cls_tcindex.c
net/sched/cls_u32.c
net/sched/sch_cbq.c
net/sched/sch_csz.c
net/sched/sch_dsmark.c
net/sched/sch_gred.c
net/sched/sch_htb.c
net/sched/sch_ingress.c
net/sched/sch_prio.c
net/sched/sch_red.c
net/sched/sch_sfq.c
net/sched/sch_tbf.c
net/sched/sch_teql.c
net/sunrpc/sched.c
net/unix/af_unix.c
net/wanrouter/wanmain.c
net/x25/af_x25.c
sound/oss/cs4232.c
drivers/char/esp.c
sound/oss/cs4281/cs4281m.c
sound/oss/cs46xx.c
sound/oss/msnd.c

===========================================
_MOD_DEC_USE_COUNT deprecations: 252 files
===========================================
drivers/atm/eni.c
drivers/atm/idt77105.c
drivers/atm/idt77252.c
drivers/atm/lanai.c
drivers/atm/suni.c
drivers/block/floppy.c
drivers/block/loop.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/genrtc.c
drivers/char/ip2.c
drivers/char/ip2main.c
drivers/char/isicom.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/n_hdlc.c
drivers/char/n_r3964.c
drivers/char/pcmcia/synclink_cs.c
drivers/char/raw.c
drivers/char/rio/rio_linux.c
drivers/char/riscom8.c
drivers/char/rocket.c
drivers/char/specialix.c
drivers/char/stallion.c
drivers/char/sx.c
drivers/char/synclink.c
drivers/char/synclinkmp.c
drivers/hotplug/ibmphp_core.c
drivers/ide/ide-probe.c
drivers/ide/legacy/ide-cs.c
drivers/input/serio/serport.c
drivers/isdn/capi/capi.c
drivers/isdn/capi/capidrv.c
drivers/isdn/capi/capifs.c
drivers/isdn/capi/kcapi.c
drivers/isdn/eicon/linchr.c
drivers/isdn/hardware/eicon/capifunc.c
drivers/isdn/hardware/eicon/capimain.c
drivers/isdn/hardware/eicon/diva_didd.c
drivers/isdn/hardware/eicon/divamnt.c
drivers/isdn/hardware/eicon/divasi.c
drivers/isdn/hardware/eicon/divasmain.c
drivers/isdn/hysdn/hysdn_net.c
drivers/isdn/i4l/isdn_bsdcomp.c
drivers/isdn/i4l/isdn_common.c
drivers/isdn/i4l/isdn_tty.c
drivers/md/linear.c
drivers/md/md.c
drivers/md/multipath.c
drivers/md/raid0.c
drivers/md/raid1.c
drivers/md/raid5.c
drivers/media/dvb/av7110/av7110.c
drivers/media/dvb/av7110/saa7146_v4l.c
drivers/media/dvb/dvb-core/dmxdev.c
drivers/media/dvb/dvb-core/dvb_demux.c
drivers/media/dvb/dvb-core/dvbdev.c
drivers/media/dvb/dvb-core/dvb_net.c
drivers/media/video/bt819.c
drivers/media/video/bt856.c
drivers/media/video/msp3400.c
drivers/media/video/saa5249.c
drivers/media/video/saa7110.c
drivers/media/video/saa7111.c
drivers/media/video/saa7185.c
drivers/media/video/tda7432.c
drivers/media/video/tda9875.c
drivers/media/video/tda9887.c
drivers/media/video/tuner-3036.c
drivers/media/video/tuner.c
drivers/media/video/tvaudio.c
drivers/media/video/zr36067.c
drivers/message/i2o/i2o_block.c
drivers/message/i2o/i2o_pci.c
drivers/mtd/devices/blkmtd.c
drivers/mtd/devices/docprobe.c
drivers/mtd/maps/pcmciamtd.c
drivers/mtd/mtdcore.c
drivers/net/82596.c
drivers/net/arcnet/arc-rimi.c
drivers/net/arcnet/com20020.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c
drivers/net/bonding.c
drivers/net/bsd_comp.c
drivers/net/eepro.c
drivers/net/fc/iph5526.c
drivers/net/hamradio/baycom_epp.c
drivers/net/hamradio/baycom_par.c
drivers/net/hamradio/baycom_ser_fdx.c
drivers/net/hamradio/baycom_ser_hdx.c
drivers/net/hamradio/bpqether.c
drivers/net/hamradio/dmascc.c
drivers/net/hamradio/hdlcdrv.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/act200l.c
drivers/net/irda/girbil.c
drivers/net/irda/irport.c
drivers/net/irda/irtty.c
drivers/net/irda/irtty-sir.c
drivers/net/irda/litelink.c
drivers/net/irda/ma600.c
drivers/net/irda/mcp2120.c
drivers/net/irda/old_belkin.c
drivers/net/irda/smc-ircc.c
drivers/net/irda/toshoboe.c
drivers/net/ni65.c
drivers/net/pcmcia/3c574_cs.c
drivers/net/pcmcia/3c589_cs.c
drivers/net/pcmcia/axnet_cs.c
drivers/net/pcmcia/com20020_cs.c
drivers/net/pcmcia/fmvj18x_cs.c
drivers/net/pcmcia/nmclan_cs.c
drivers/net/pcmcia/pcnet_cs.c
drivers/net/pcmcia/smc91c92_cs.c
drivers/net/pcmcia/xirc2ps_cs.c
drivers/net/pcnet32.c
drivers/net/ppp_async.c
drivers/net/ppp_deflate.c
drivers/net/pppoe.c
drivers/net/ppp_synctty.c
drivers/net/rcpci45.c
drivers/net/rrunner.c
drivers/net/sk98lin/skge.c
drivers/net/skfp/skfddi.c
drivers/net/slip.c
drivers/net/tulip/de4x5.c
drivers/net/tulip/tulip_core.c
drivers/net/tun.c
drivers/net/wan/c101.c
drivers/net/wan/comx.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx-hw-munich.c
drivers/net/wan/comx-proto-fr.c
drivers/net/wan/comx-proto-lapb.c
drivers/net/wan/comx-proto-ppp.c
drivers/net/wan/cosa.c
drivers/net/wan/cycx_main.c
drivers/net/wan/dlci.c
drivers/net/wan/dscc4.c
drivers/net/wan/farsync.c
drivers/net/wan/hdlc_generic.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/n2.c
drivers/net/wan/pc300_drv.c
drivers/net/wan/sdla.c
drivers/net/wan/sdlamain.c
drivers/net/wan/sealevel.c
drivers/net/wan/x25_asy.c
drivers/net/wireless/airo.c
drivers/net/wireless/netwave_cs.c
drivers/net/wireless/ray_cs.c
drivers/net/wireless/strip.c
drivers/net/wireless/wavelan_cs.c
drivers/parport/init.c
drivers/parport/parport_pc.c
drivers/telephony/ixj.c
drivers/telephony/phonedev.c
drivers/usb/class/usb-midi.c
drivers/usb/media/dabusb.c
drivers/usb/media/ibmcam.c
drivers/usb/media/konicawc.c
drivers/usb/media/ov511.c
drivers/usb/media/ultracam.c
drivers/usb/misc/speedtouch.c
drivers/usb/misc/uss720.c
drivers/video/console/mdacon.c
drivers/video/cyber2000fb.c
drivers/video/pm2fb.c
fs/intermezzo/inode.c
fs/lockd/clntlock.c
fs/lockd/svc.c
fs/nfsd/nfssvc.c
fs/smbfs/smbiod.c
net/8021q/vlan.c
net/appletalk/ddp.c
net/atm/lec.c
net/atm/mpc.c
net/atm/pppoatm.c
net/ax25/af_ax25.c
net/bluetooth/bnep/core.c
net/bluetooth/bnep/sock.c
net/bluetooth/hci_sock.c
net/bluetooth/l2cap.c
net/bluetooth/rfcomm/core.c
net/bluetooth/rfcomm/sock.c
net/bluetooth/rfcomm/tty.c
net/bluetooth/sco.c
net/core/pktgen.c
net/decnet/af_decnet.c
net/econet/af_econet.c
net/ipv4/ip_gre.c
net/ipv4/ipip.c
net/ipv4/netfilter/arp_tables.c
net/ipv4/netfilter/ipchains_core.c
net/ipv4/netfilter/ip_conntrack_core.c
net/ipv4/netfilter/ip_conntrack_standalone.c
net/ipv4/netfilter/ipfwadm_core.c
net/ipv4/netfilter/ip_nat_helper.c
net/ipv4/netfilter/ip_nat_standalone.c
net/ipv4/netfilter/ip_tables.c
net/ipv4/netfilter/ipt_conntrack.c
net/ipv4/netfilter/ipt_helper.c
net/ipv4/netfilter/ipt_state.c
net/ipv6/af_inet6.c
net/ipv6/ipv6_sockglue.c
net/ipv6/netfilter/ip6_tables.c
net/ipv6/sit.c
net/ipx/af_ipx.c
net/irda/af_irda.c
net/irda/ircomm/ircomm_tty.c
net/irda/irlan/irlan_common.c
net/irda/irnet/irnet_ppp.c
net/key/af_key.c
net/lapb/lapb_iface.c
net/llc/llc_if.c
net/llc/llc_main.c
net/netrom/af_netrom.c
net/netrom/nr_dev.c
net/packet/af_packet.c
net/rose/af_rose.c
net/rose/rose_dev.c
net/sched/cls_fw.c
net/sched/cls_route.c
net/sched/cls_rsvp.h
net/sched/cls_tcindex.c
net/sched/cls_u32.c
net/sched/sch_cbq.c
net/sched/sch_csz.c
net/sched/sch_dsmark.c
net/sched/sch_gred.c
net/sched/sch_htb.c
net/sched/sch_ingress.c
net/sched/sch_prio.c
net/sched/sch_red.c
net/sched/sch_sfq.c
net/sched/sch_tbf.c
net/sched/sch_teql.c
net/sunrpc/sched.c
net/unix/af_unix.c
net/wanrouter/wanmain.c
net/x25/af_x25.c
sound/oss/cs4281/cs4281m.c
sound/oss/cs46xx.c
sound/oss/msnd.c

John

