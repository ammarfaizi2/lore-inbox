Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWDIW4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWDIW4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 18:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWDIW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 18:56:37 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:7486 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750963AbWDIW4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 18:56:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Wv50hp/LTx9bGZo253s9dp60/vM0vXgJ3v8hf0UWRHoTK9xT+8uBPXkZ4gE0sJUj3Sh5D20gSaooCas1R3JAfEFu+fqrcaCv7qwozG90ngXm2EfPA+DaACjJx1js42wIwzNsgNUFYurAW+36ctsc0Nw+Ic6YzlsZkYB4S940VIk=
Date: Mon, 10 Apr 2006 02:56:54 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc1-kj
Message-ID: <20060409225654.GA32151@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly off schedule, 2.6.17-rc1-kj patchset is out. Grab it from
http://coderock.org/kj/2.6.17-rc1-kj/ .

Right before release I've found

	arch-
	arch-a
	arch-s390-kzalloc.patch
	arch-ppc-kzalloc.patch
	arch-arm-kzalloc.patch
	ipz
	kzalloc-conversion-in-arch-ia64.patch
	drivers-net-kzalloc.patch
	sou

in series file, so quilt somehow managed to screwup its own file.
Because of that changelog is in funky form. Add the fact that I
successfully did a couple of git merges for another project, I'll try to
use git for kj stuff.

Changelog, actually:

+arch/alpha/kernel/module.c
+arch/i386/kernel/cpu/mtrr/if.c
+arch/i386/kernel/cpu/mtrr/main.c
+arch/i386/kernel/io_apic.c
+arch/i386/kernel/mca.c
+arch/i386/kernel/pci-dma.c
+arch/i386/mach-voyager/voyager_cat.c
+arch/i386/pci/pcbios.c
+arch/ia64/hp/common/sba_iommu.c
+arch/ia64/hp/sim/simserial.c
+arch/ia64/kernel/cpufreq/acpi-cpufreq.c
+arch/ia64/kernel/perfmon.c
+arch/ia64/pci/pci.c
+arch/m68k/amiga/chipram.c
+arch/m68k/atari/hades-pci.c
+arch/powerpc/kernel/ibmebus.c
+arch/powerpc/kernel/pci_64.c
+arch/powerpc/kernel/smp-tbsync.c
+arch/powerpc/platforms/iseries/iommu.c
+arch/powerpc/platforms/iseries/pci.c
+arch/powerpc/platforms/iseries/vio.c
+arch/powerpc/platforms/pseries/reconfig.c
+arch/powerpc/platforms/pseries/vio.c
+arch/sparc/kernel/sun4d_irq.c
+arch/sparc/mm/io-unit.c
+arch/x86_64/kernel/io_apic.c
+arch/x86_64/kernel/mce_amd.c
+Documentation/connector/cn_test.c
+Documentation/filesystems/configfs/configfs_example.c
+drivers/acorn/char/pcf8583.c
+drivers/char/consolemap.c
+drivers/char/drm/ffb_drv.c
+drivers/char/drm/via_dmablit.c
+drivers/char/ftape/lowlevel/ftape-buffer.c
+drivers/char/ftape/zftape/zftape-buffers.c
+drivers/char/hvc_console.c
+drivers/char/hvcs.c
+drivers/char/n_hdlc.c
+drivers/char/random.c
+drivers/char/rio/rio_linux.c
+drivers/char/vt.c
+drivers/char/watchdog/mpcore_wdt.c
+drivers/char/watchdog/pcwd_usb.c
+drivers/macintosh/macio_asic.c
+drivers/macintosh/smu.c
+drivers/macintosh/therm_adt746x.c
+drivers/macintosh/therm_pm72.c
+drivers/macintosh/therm_windtunnel.c
+drivers/macintosh/windfarm_lm75_sensor.c
+drivers/mca/mca-bus.c
+drivers/md/dm-emc.c
+drivers/md/dm-mpath.c
+drivers/media/dvb/cinergyT2/cinergyT2.c
+drivers/media/video/cx88/cx88-alsa.c
+drivers/media/video/msp3400-driver.c
+drivers/media/video/planb.c
+drivers/message/fusion/mptctl.c
+drivers/mfd/mcp-core.c
+drivers/mfd/ucb1x00-core.c
+drivers/misc/ibmasm/command.c
+drivers/misc/ibmasm/ibmasmfs.c
+drivers/misc/ibmasm/module.c
+drivers/mtd/afs.c
+drivers/mtd/chips/amd_flash.c
+drivers/mtd/chips/cfi_cmdset_0001.c
+drivers/mtd/chips/cfi_cmdset_0002.c
+drivers/mtd/chips/gen_probe.c
+drivers/mtd/chips/jedec.c
+drivers/mtd/chips/map_ram.c
+drivers/mtd/chips/map_rom.c
+drivers/mtd/devices/block2mtd.c
+drivers/mtd/devices/ms02-nv.c
+drivers/mtd/devices/phram.c
+drivers/mtd/devices/pmc551.c
+drivers/mtd/devices/slram.c
+drivers/mtd/maps/ceiva.c
+drivers/mtd/maps/omap_nor.c
+drivers/mtd/maps/tqm834x.c
+drivers/mtd/maps/tqm8xxl.c
+drivers/mtd/mtdblock.c
+drivers/mtd/mtdblock_ro.c
+drivers/mtd/nand/diskonchip.c
+drivers/mtd/onenand/generic.c
+drivers/net/bonding/bond_main.c
+drivers/net/chelsio/mv88x201x.c
+drivers/net/e1000/e1000_ethtool.c
+drivers/net/fs_enet/fs_enet-mii.c
+drivers/net/irda/irda-usb.c
+drivers/net/irda/irtty-sir.c
+drivers/net/iseries_veth.c
+drivers/net/lance.c
+drivers/net/loopback.c
+drivers/net/mipsnet.c
+drivers/net/pcmcia/ibmtr_cs.c
+drivers/net/ppp_deflate.c
+drivers/net/ppp_generic.c
+drivers/net/ppp_synctty.c
+drivers/net/sb1250-mac.c
+drivers/net/slhc.c
+drivers/net/wan/c101.c
+drivers/net/wan/cosa.c
+drivers/net/wan/cycx_main.c
+drivers/net/wan/cycx_x25.c
+drivers/net/wan/hdlc_fr.c
+drivers/net/wan/hostess_sv11.c
+drivers/net/wan/n2.c
+drivers/net/wan/sdla.c
+drivers/net/wan/sdla_chdlc.c
+drivers/net/wan/sdla_fr.c
+drivers/net/wan/sdlamain.c
+drivers/net/wan/sdla_ppp.c
+drivers/net/wan/sdla_x25.c
+drivers/net/wan/sealevel.c
+drivers/net/wan/wanpipe_multppp.c
+drivers/nubus/nubus.c
+drivers/parport/parport_cs.c
+drivers/parport/parport_serial.c
+drivers/rapidio/rio-scan.c
+drivers/sbus/char/bbc_envctrl.c
+drivers/sbus/char/openprom.c
+drivers/sbus/char/vfc_dev.c
+drivers/serial/8250_acorn.c
+drivers/serial/ioc4_serial.c
+drivers/serial/ip22zilog.c
+drivers/serial/jsm/jsm_tty.c
+drivers/serial/serial_cs.c
+drivers/serial/sunsu.c
+drivers/serial/sunzilog.c
+drivers/sh/superhyway/superhyway.c
+drivers/telephony/ixj_pcmcia.c
+fs/affs/bitmap.c
+fs/affs/super.c
+fs/afs/vlocation.c
+fs/afs/volume.c
+fs/ext2/super.c
+fs/ext2/xattr.c
+fs/ext3/dir.c
+fs/ext3/super.c
+fs/ext3/xattr.c
+fs/hfs/super.c
+fs/lockd/host.c
+fs/lockd/svcsubs.c
+fs/partitions/check.c
+fs/partitions/efi.c
+fs/proc/kcore.c
+fs/proc/vmcore.c
+fs/udf/ialloc.c
+kernel/kexec.c
+sound/core/seq/seq_device.c
+sound/core/sgbuf.c
+sound/ppc/awacs.c
+sound/ppc/daca.c
+sound/ppc/keywest.c
+sound/ppc/tumbler.c
+sound/usb/usbaudio.c

	kcalloc/kzalloc conversion.

-arch/cris/arch-v10/kernel/kgdb.c
-arch/cris/arch-v32/kernel/kgdb.c
-arch/frv/kernel/gdb-stub.c
-arch/mips/galileo-boards/ev96100/puts.c
-arch/mips/ite-boards/generic/puts.c
-arch/mips/jmr3927/common/puts.c
-arch/mips/jmr3927/rbhma3100/kgdb_io.c
-arch/mips/kernel/gdb-stub.c
-arch/ppc/boot/common/misc-common.c
-arch/ppc/kernel/ppc-stub.c
-arch/ppc/platforms/apus_setup.c
-arch/ppc/platforms/residual.c
-arch/ppc/syslib/btext.c
-arch/sh/kernel/kgdb_stub.c
-arch/sparc/kernel/sparc-stub.c
-drivers/isdn/isdnloop/isdnloop.c
-drivers/net/irda/ma600.c
-drivers/net/sk98lin/skge.c
-drivers/net/skfp/smt.c
-drivers/pnp/pnpbios/rsparser.c
-drivers/scsi/ultrastor.c
-drivers/serial/sh-sci.c
-fs/udf/unicode.c
-lib/vsprintf.c

	"0123456789abcdef" consolidation should be done another way.

-arch/ppc/8xx_io/cs4218_tdm.c
-drivers/net/atari_bionet.c
-drivers/net/atarilance.c
-drivers/net/cassini.c
-drivers/net/fs_enet/fs_enet-main.c
-drivers/net/lasi_82596.c
-drivers/net/mac89x0.c
-drivers/net/mace.c
-drivers/net/meth.c
-drivers/net/ni5010.c
-drivers/net/sun3lance.c
-kernel/rcutorture.c

	conversion to module_param() merged.

-arch/ppc/syslib/ppc4xx_pm.c

	merged

-block/elevator.c
-drivers/block/cciss_scsi.c
-drivers/input/serio/hil_mlc.c
-drivers/input/serio/hp_sdc_mlc.c
-drivers/isdn/hisax/hisax_isac.c
-drivers/isdn/hisax/st5481_b.c
-drivers/isdn/hisax/st5481_d.c
-drivers/isdn/i4l/isdn_ppp.c
-drivers/md/bitmap.c
-drivers/md/raid10.c
-drivers/md/raid1.c
-drivers/md/raid5.c
-drivers/md/raid6main.c
-drivers/media/common/saa7146_core.c
-drivers/media/common/saa7146_fops.c
-drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
-drivers/media/video/bttv-risc.c
-drivers/media/video/cx88/cx88-video.c
-drivers/media/video/saa7134/saa7134-alsa.c
-drivers/media/video/saa7134/saa7134-oss.c
-drivers/media/video/saa7134/saa7134-video.c
-drivers/media/video/video-buf.c
-drivers/mtd/maps/dilnetpc.c
-drivers/mtd/mtdconcat.c
-drivers/net/eql.c
-drivers/net/irda/sa1100_ir.c
-drivers/net/tokenring/abyss.c
-drivers/net/tokenring/madgemc.c
-drivers/parisc/sba_iommu.c
-drivers/parisc/superio.c
-drivers/s390/block/dasd.c
-drivers/s390/block/dasd_devmap.c
-drivers/s390/block/dasd_erp.c
-drivers/s390/char/tape_block.c
-fs/binfmt_elf_fdpic.c
-fs/buffer.c
-fs/coda/cache.c
-fs/coda/cnode.c
-fs/compat.c
-fs/dcache.c
-fs/direct-io.c
-fs/dquot.c
-fs/exec.c
-fs/ext2/dir.c
-fs/fcntl.c
-fs/freevxfs/vxfs_olt.c
-fs/inode.c
-fs/jffs2/background.c
-fs/smbfs/file.c
-fs/sysfs/inode.c
-fs/sysv/dir.c
-fs/udf/inode.c
-ipc/msg.c
-ipc/shm.c
-ipc/util.c
-kernel/cpu.c
-kernel/fork.c
-kernel/printk.c
-kernel/ptrace.c
-kernel/signal.c
-kernel/timer.c
-lib/swiotlb.c
-mm/highmem.c
-mm/memory.c
-mm/mempool.c
-mm/mmap.c
-mm/swap_state.c
-mm/vmalloc.c
-sound/sparc/cs4231.c

	BUG_ON conversion merged. Thanks to Adrian Bunk for sending upstream.

+Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+sound/oss/emu10k1/main.c
+sound/pci/als300.c

	new DMA_*BIT_MASK constants

+drivers/acpi/asus_acpi.c

	signed/unsigned fixup

-drivers/atm/lanai.c
-drivers/block/umem.c
-drivers/net/ioc3-eth.c
-drivers/net/wireless/prism54/islpci_hotplug.c
-drivers/scsi/a100u2w.c
-drivers/scsi/atp870u.c
-drivers/scsi/BusLogic.c
-drivers/scsi/dpt_i2o.c
-drivers/scsi/eata.c
-drivers/scsi/gdth.c
-drivers/scsi/initio.c
-drivers/scsi/ips.c
-drivers/scsi/nsp32.c
-drivers/scsi/ppa.c
-drivers/scsi/qla1280.c
-drivers/scsi/qlogicfc.c
-sound/oss/esssolo1.c
-sound/oss/sonicvibes.c
-sound/pci/ad1889.c
-sound/pci/ali5451/ali5451.c
-sound/pci/als4000.c
-sound/pci/azt3328.c
-sound/pci/emu10k1/emu10k1x.c
-sound/pci/es1938.c
-sound/pci/es1968.c
-sound/pci/ice1712/ice1712.c
-sound/pci/maestro3.c
-sound/pci/mixart/mixart.c
-sound/pci/pcxhr/pcxhr.c
-sound/pci/sonicvibes.c
-sound/pci/trident/trident_main.c

	DMA_*BIT_MASK merged

-drivers/block/floppy.c

	NWGROUP removal and BUG cleanups

-drivers/net/3c523.c
-drivers/net/apne.c
-drivers/net/arcnet/arcnet.c
-drivers/net/arm/etherh.c
-drivers/net/eth16i.c
-drivers/net/hamradio/baycom_epp.c
-drivers/char/agp/nvidia-agp.c
-drivers/net/ne2.c
-drivers/net/ne.c
-drivers/net/ne-h8300.c
-drivers/net/oaknet.c
-drivers/net/pcmcia/3c589_cs.c
-drivers/net/seeq8005.c
-drivers/net/tulip/pnic.c
-drivers/net/wireless/strip.c
-drivers/net/zorro8390.c
-drivers/scsi/qlogicpti.c

	time_before(), time_after conversion merged

-drivers/char/Makefile

	indenting merged

-drivers/hwmon/adm1026.c
-drivers/hwmon/fscpos.c
-drivers/hwmon/it87.c

	Standard conformance merged

+drivers/isdn/hardware/eicon/platform.h
+drivers/net/wireless/airo.c

	Standard conformance

+drivers/isdn/hisax/isdnhdlc.h
+drivers/media/dvb/frontends/l64781.c

	bitfields sanity

-drivers/media/video/msp3400.h

	-ENOFILE

+drivers/net/3c515.c

	Likely a typo in loop logic.

-drivers/net/irda/donauboe.c

	pci_register_driver conversion

-drivers/net/irda/ep7211_ir.c

	cli/sti removal merged

+drivers/net/pcmcia/pcnet_cs.c

	request_irq check

+drivers/pcmcia/i82365.c

	Lindent

-drivers/scsi/FlashPoint.c

	Plethora of cleanups merged.

+drivers/sn/ioc3.c

	DMA_64_BITMASK

+drivers/telephony/ixj.c

	request_region check

-drivers/usb/media/pwc/pwc-kiara.h
-drivers/usb/media/pwc/pwc-timon.h

	extern const. merged

+drivers/video/pm2fb.c
+drivers/video/savage/savagefb_driver.c
+sound/pci/au88x0/au88x0_core.c
+sound/pci/au88x0/au88x0_eq.c

	section fixes

-drivers/video/radeonfb.c

	file removed

-fs/devpts/inode.c

	fs parser conversion merged

-fs/nfs/nfs4proc.c

	static const merged

-fs/select.c

	wrapper removal merged

+net/8021q/vlan_dev.c
+net/802/fc.c
+net/802/fddi.c
+net/802/hippi.c
+net/802/tr.c
+net/atm/lec.c
+net/atm/mpc.c
+net/atm/mpoa_caches.c
+net/atm/mpoa_proc.c
+net/bridge/br_netfilter.c
+net/bridge/netfilter/ebtables.c
+net/bridge/netfilter/ebt_limit.c
+net/bridge/netfilter/ebt_log.c
-net/ipv4/arp.c
-net/ipv4/netfilter/ipt_CLUSTERIP.c
+net/ipv4/netfilter/ip_nat_standalone.c

	KERN_* additions. I wonder how much bloat three bytes here and there
	add.

-README

	typo fix merged

+security/selinux/xfrm.c

	compile fix. Looks like it sneaked into mainline.

+sound/oss/gus_wave.c

	array overrun

+sound/oss/msnd_pinnacle.c

	request_region checks

+sound/pci/au88x0/au88x0.h

	section markers only in code not prototypes

+sound/pci/cs46xx/dsp_spos_scb_lib.c

	array overrun

