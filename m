Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268132AbTBMUDh>; Thu, 13 Feb 2003 15:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTBMUDh>; Thu, 13 Feb 2003 15:03:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33440 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268132AbTBMUDa>; Thu, 13 Feb 2003 15:03:30 -0500
Date: Thu, 13 Feb 2003 12:13:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 352] New: Unneccessary includes of linux/version.h 
Message-ID: <23800000.1045167188@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=352

           Summary: Unneccessary includes of linux/version.h
    Kernel Version: 2.5.60-bk3
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86
Software Environment:
Problem Description:

There appears to be a large number of kernel files (267) that #include 
<linux/version.h>, but do not use any of the three things defined in it.
This  causes these files to be needlessly(I think) recompiled during a
kernel rebuild  if only the version.h file changes. Would a patch to remove
these extra  includes be accepted? 

Here is the list (generated with a script, so it could be wrong..)

/drivers/video/pm3fb.c
/drivers/video/sstfb.c
/drivers/net/tulip/de4x5.c
/drivers/net/tulip/dmfe.c
/drivers/net/wan/lmc/lmc_debug.c
/drivers/net/wan/comx-proto-lapb.c
/drivers/net/wan/comx-hw-comx.c
/drivers/net/wan/sdla_ft1.c
/drivers/net/wan/cycx_x25.c
/drivers/net/wan/sdladrv.c
/drivers/net/wan/dscc4.c
/drivers/net/wan/comx-proto-fr.c
/drivers/net/wan/comx.c
/drivers/net/wan/comx-hw-locomx.c
/drivers/net/wan/sdla_x25.c
/drivers/net/wan/sdlamain.c
/drivers/net/wan/pc300_drv.c
/drivers/net/wan/comx-hw-mixcom.c
/drivers/net/wan/sdla_fr.c
/drivers/net/wan/comx-proto-ppp.c
/drivers/net/tokenring/smctr.c
/drivers/net/tokenring/tms380tr.c
/drivers/net/hamradio/baycom_ser_hdx.c
/drivers/net/hamradio/baycom_ser_fdx.c
/drivers/net/hamradio/hdlcdrv.c
/drivers/net/hamradio/yam.c
/drivers/net/hamradio/baycom_par.c
/drivers/net/sb1000.c
/drivers/net/wireless/airo.c
/drivers/net/aironet4500_proc.c
/drivers/net/3c515.c
/drivers/net/ibmlana.c
/drivers/net/rrunner.c
/drivers/net/ni65.c
/drivers/net/mace.c
/drivers/net/sis900.c
/drivers/net/arlan-proc.c
/drivers/net/aironet4500_card.c
/drivers/net/strip.c
/drivers/net/smc9194.c
/drivers/net/cs89x0.c
/drivers/net/ne2.c
/drivers/acpi/toshiba_acpi.c
/drivers/s390/cio/qdio.c
/drivers/s390/char/tape_std.c
/drivers/s390/char/sclp_tty.c
/drivers/s390/char/tape_core.c
/drivers/s390/char/tape_34xx.c
/drivers/s390/char/tape_proc.c
/drivers/s390/char/sclp_rw.c
/drivers/s390/char/sclp_con.c
/drivers/s390/char/sclp.c
/drivers/s390/char/tape_block.c
/drivers/s390/char/tape_char.c
/drivers/s390/block/dasd_erp.c
/drivers/s390/block/dasd_proc.c
/drivers/s390/block/dasd.c
/drivers/s390/block/dasd_devmap.c
/drivers/s390/block/dasd_ioctl.c
/drivers/s390/block/xpram.c
/drivers/s390/block/dasd_genhd.c
/drivers/s390/net/iucv.c
/drivers/s390/net/lcs.c
/drivers/s390/net/ctcmain.c
/drivers/s390/net/fsm.c
/drivers/s390/net/netiucv.c
/drivers/media/radio/radio-gemtek-pci.c
/drivers/media/video/bt856.c
/drivers/media/video/cpia_pp.c
/drivers/media/video/saa7185.c
/drivers/media/video/bttv-if.c
/drivers/media/video/videodev.c
/drivers/media/video/saa7111.c
/drivers/media/video/tuner-3036.c
/drivers/media/video/c-qcam.c
/drivers/media/video/bttv-risc.c
/drivers/media/video/v4l1-compat.c
/drivers/media/video/bttv-vbi.c
/drivers/media/video/cpia.c
/drivers/media/video/bttv-driver.c
/drivers/media/video/pms.c
/drivers/media/video/stradis.c
/drivers/media/video/adv7175.c
/drivers/media/video/v4l2-common.c
/drivers/media/video/zr36067.c
/drivers/media/video/zr36120_i2c.c
/drivers/media/dvb/dvb-core/dvb_demux.c
/drivers/media/dvb/dvb-core/dvbdev.c
/drivers/isdn/i4l/isdn_common.c
/drivers/isdn/hisax/hisax_fcclassic.c
/drivers/isdn/hisax/hisax_hfcpci.c
/drivers/isdn/hisax/hisax_fcpcipnp.c
/drivers/isdn/hisax/st5481_init.c
/drivers/isdn/hysdn/hysdn_net.c
/drivers/isdn/hysdn/hycapi.c
/drivers/isdn/hysdn/hysdn_proclog.c
/drivers/isdn/hysdn/hysdn_init.c
/drivers/isdn/hysdn/hysdn_procconf.c
/drivers/isdn/capi/capifs.c
/drivers/isdn/divert/isdn_divert.c
/drivers/isdn/divert/divert_init.c
/drivers/isdn/divert/divert_procfs.c
/drivers/serial/mcfserial.c
/drivers/char/rio/rio_linux.c
/drivers/char/ftape/lowlevel/fdc-io.c
/drivers/char/mwave/3780i.c
/drivers/char/mwave/smapi.c
/drivers/char/vme_scc.c
/drivers/char/isicom.c
/drivers/char/synclinkmp.c
/drivers/char/cyclades.c
/drivers/char/i8k.c
/drivers/char/n_hdlc.c
/drivers/char/pcmcia/synclink_cs.c
/drivers/char/synclink.c
/drivers/char/sx.c
/drivers/char/dtlk.c
/drivers/char/serial167.c
/drivers/char/dsp56k.c
/drivers/char/istallion.c
/drivers/char/mxser.c
/drivers/char/rocket.c
/drivers/char/stallion.c
/drivers/char/vt.c
/drivers/char/toshiba.c
/drivers/char/moxa.c
/drivers/char/amiserial.c
/drivers/i2c/i2c-frodo.c
/drivers/i2c/chips/lm75.c
/drivers/i2c/chips/adm1021.c
/drivers/i2c/i2c-elektor.c
/drivers/i2c/busses/i2c-amd8111.c
/drivers/i2c/busses/i2c-amd756.c
/drivers/i2c/i2c-core.c
/drivers/i2c/i2c-adap-ite.c
/drivers/i2c/i2c-algo-bit.c
/drivers/i2c/i2c-algo-ibm_ocp.c
/drivers/i2c/i2c-dev.c
/drivers/i2c/i2c-algo-pcf.c
/drivers/i2c/i2c-elv.c
/drivers/i2c/i2c-algo-ite.c
/drivers/scsi/aic7xxx/aiclib.c
/drivers/scsi/53c700.c
/drivers/scsi/aha152x.c
/drivers/scsi/lasi700.c
/drivers/scsi/bvme6000.c
/drivers/scsi/NCR_D700.c
/drivers/scsi/sym53c416.c
/drivers/scsi/i60uscsi.c
/drivers/scsi/mvme147.c
/drivers/scsi/u14-34f.c
/drivers/scsi/amiga7xx.c
/drivers/scsi/osst.c
/drivers/scsi/BusLogic.c
/drivers/scsi/eata.c
/drivers/scsi/a2091.c
/drivers/scsi/dmx3191d.c
/drivers/scsi/zalon.c
/drivers/scsi/wd33c93.c
/drivers/scsi/a3000.c
/drivers/scsi/mvme16x.c
/drivers/scsi/gvp11.c
/drivers/scsi/sgiwd93.c
/drivers/scsi/wd7000.c
/drivers/mtd/maps/sun_uflash.c
/drivers/mtd/devices/lart.c
/drivers/mtd/chips/sharp.c
/drivers/mtd/chips/map_rom.c
/drivers/usb/media/ov511.c
/drivers/usb/media/stv680.c
/drivers/usb/image/mdc800.c
/drivers/usb/class/audio.c
/drivers/usb/core/usb-debug.c
/drivers/usb/core/buffer.c
/drivers/usb/host/ohci-hcd.c
/drivers/block/amiflop.c
/drivers/block/DAC960.c
/drivers/block/cciss.c
/drivers/pcmcia/sa1100_generic.c
/drivers/pnp/isapnp/proc.c
/drivers/pnp/isapnp/core.c
/drivers/pnp/isapnp/compat.c
/drivers/atm/iphase.c
/drivers/atm/fore200e.c
/drivers/ieee1394/raw1394.c
/drivers/cdrom/sbpcd.c
/drivers/message/fusion/mptbase.c
/drivers/sbus/char/bpp.c
/drivers/sbus/char/display7seg.c
/drivers/sbus/char/cpwatchdog.c
/drivers/bluetooth/hci_h4.c
/drivers/bluetooth/hci_ldisc.c
/drivers/bluetooth/hci_bcsp.c
/drivers/bluetooth/hci_usb.c
/drivers/telephony/phonedev.c
/arch/ppc/syslib/prom.c
/arch/ppc/syslib/prom_init.c
/arch/cris/drivers/usb-host.c
/arch/mips/gt64120/momenco_ocelot/setup.c
/arch/mips/gt64120/momenco_ocelot/pci.c
/arch/mips/gt64120/common/pci.c
/arch/ppc64/kernel/prom.c
/arch/parisc/kernel/asm-offsets.c
/arch/parisc/kernel/signal.c
/arch/parisc/kernel/process.c
/arch/s390x/kernel/debug.c
/arch/s390/kernel/debug.c
/fs/afs/cmservice.c
/fs/afs/kafstimod.c
/fs/afs/kafsasyncd.c
/fs/cifs/file.c
/fs/cifs/transport.c
/fs/cifs/cifsfs.c
/fs/nls/nls_base.c
/fs/jffs2/super.c
/fs/coda/coda_linux.c
/fs/adfs/super.c
/fs/adfs/dir_fplus.c
/fs/adfs/inode.c
/fs/adfs/map.c
/fs/adfs/dir_f.c
/fs/adfs/dir.c
/fs/adfs/file.c
/fs/udf/super.c
/fs/befs/datastream.c
/fs/lockd/svc.c
/fs/devfs/base.c
/fs/jffs/intrep.c
/net/ipv4/netfilter/ip_conntrack_core.c
/net/ipv4/netfilter/ip_nat_core.c
/net/ipv4/netfilter/ip_nat_helper.c
/net/ipv4/netfilter/ipt_ULOG.c
/net/ipv4/netfilter/ip_nat_rule.c
/net/ipv4/netfilter/ip_conntrack_standalone.c
/net/ipv4/netfilter/ip_nat_standalone.c
/net/ipv4/netfilter/ip_fw_compat_masq.c
/net/sunrpc/sysctl.c
/net/sunrpc/svcsock.c
/net/sunrpc/rpc_pipe.c
/net/sunrpc/xprt.c
/net/sunrpc/timer.c
/net/rxrpc/krxiod.c
/net/rxrpc/krxtimod.c
/net/rxrpc/krxsecd.c
/net/sched/sch_htb.c
/net/wanrouter/wanproc.c
/net/wanrouter/wanmain.c
/sound/oss/cs46xx.c
/sound/oss/emu10k1/audio.c
/sound/oss/emu10k1/passthrough.c
/sound/oss/emu10k1/mixer.c
/sound/oss/emu10k1/main.c
/sound/oss/emu10k1/midi.c
/sound/oss/cs4281/cs4281m.c
/sound/oss/esssolo1.c
/sound/oss/ac97_codec.c
/sound/oss/ite8172.c
/sound/oss/btaudio.c
/sound/oss/sonicvibes.c
/sound/oss/cmpci.c
/sound/oss/msnd_pinnacle.c
/sound/oss/nec_vrc5477.c
/sound/oss/es1371.c
/sound/oss/i810_audio.c
/sound/oss/trident.c
/sound/oss/maestro.c
/sound/oss/es1370.c




Steps to reproduce:


