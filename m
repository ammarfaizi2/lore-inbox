Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267764AbUHJV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267764AbUHJV6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUHJV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:58:38 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27146 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267764AbUHJV5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:57:38 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Script which generates whitespace removal patches
Date: Wed, 11 Aug 2004 00:57:08 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0SUGBEK3y0Ojfy3"
Message-Id: <200408110057.09188.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0SUGBEK3y0Ojfy3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus, Andrew, folks

This is a shell script which scans given kernel tree and generates
patches which remove trailing whitespcase from [vsn]*print[fk]*
function calls, one patch per file.

Less than one minute of work, 186 cute little patches for you :)

Script is in attachment, to prevent it from being mangled by MUA.

I have resulting patch tarball made from my kernel tree, too,
but it's 49Kb. A bit too big for the list. Whoever interested
in it can easily generate his/her own one.

Please add this script into script/ subdirectory.

It patched these files in my tree:

linux-2.6.7-bk20.src/arch/alpha/kernel/sys_dp264.c
linux-2.6.7-bk20.src/arch/alpha/kernel/sys_titan.c
linux-2.6.7-bk20.src/arch/arm/mach-pxa/pxa27x.c
linux-2.6.7-bk20.src/arch/arm/mach-sa1100/simpad.c
linux-2.6.7-bk20.src/arch/arm26/kernel/setup.c
linux-2.6.7-bk20.src/arch/i386/kernel/apm.c
linux-2.6.7-bk20.src/arch/i386/kernel/efi.c
linux-2.6.7-bk20.src/arch/i386/kernel/microcode.c
linux-2.6.7-bk20.src/arch/i386/kernel/mpparse.c
linux-2.6.7-bk20.src/arch/i386/kernel/timers/timer_tsc.c
linux-2.6.7-bk20.src/arch/i386/mach-es7000/es7000plat.c
linux-2.6.7-bk20.src/arch/ia64/sn/io/drivers/ioconfig_bus.c
linux-2.6.7-bk20.src/arch/m68k/kernel/traps.c
linux-2.6.7-bk20.src/arch/m68k/mac/config.c
linux-2.6.7-bk20.src/arch/m68k/q40/q40ints.c
linux-2.6.7-bk20.src/arch/mips/au1000/common/dbdma.c
linux-2.6.7-bk20.src/arch/mips/ddb5xxx/ddb5477/setup.c
linux-2.6.7-bk20.src/arch/mips/ite-boards/generic/irq.c
linux-2.6.7-bk20.src/arch/mips/pci/pci-ip27.c
linux-2.6.7-bk20.src/arch/mips/pmc-sierra/yosemite/atmel_read_eeprom.c
linux-2.6.7-bk20.src/arch/mips/pmc-sierra/yosemite/irq.c
linux-2.6.7-bk20.src/arch/mips/pmc-sierra/yosemite/smp.c
linux-2.6.7-bk20.src/arch/parisc/kernel/cache.c
linux-2.6.7-bk20.src/arch/ppc/boot/utils/mkprep.c
linux-2.6.7-bk20.src/arch/ppc/platforms/4xx/ash.c
linux-2.6.7-bk20.src/arch/ppc/platforms/4xx/bubinga.c
linux-2.6.7-bk20.src/arch/ppc/platforms/4xx/sycamore.c
linux-2.6.7-bk20.src/arch/ppc/platforms/4xx/walnut.c
linux-2.6.7-bk20.src/arch/ppc/syslib/ppc4xx_kgdb.c
linux-2.6.7-bk20.src/arch/ppc/xmon/xmon.c
linux-2.6.7-bk20.src/arch/ppc64/boot/addRamDisk.c
linux-2.6.7-bk20.src/arch/ppc64/boot/addSystemMap.c
linux-2.6.7-bk20.src/arch/ppc64/boot/piggyback.c
linux-2.6.7-bk20.src/arch/ppc64/kernel/iSeries_proc.c
linux-2.6.7-bk20.src/arch/ppc64/kernel/iSeries_setup.c
linux-2.6.7-bk20.src/arch/ppc64/kernel/setup.c
linux-2.6.7-bk20.src/arch/ppc64/xmon/xmon.c
linux-2.6.7-bk20.src/arch/s390/kernel/debug.c
linux-2.6.7-bk20.src/arch/sh/boards/overdrive/fpga.c
linux-2.6.7-bk20.src/arch/x86_64/mm/fault.c
linux-2.6.7-bk20.src/crypto/tcrypt.c
linux-2.6.7-bk20.src/drivers/acpi/executer/exdump.c
linux-2.6.7-bk20.src/drivers/atm/firestream.c
linux-2.6.7-bk20.src/drivers/atm/iphase.c
linux-2.6.7-bk20.src/drivers/atm/nicstar.c
linux-2.6.7-bk20.src/drivers/block/cciss.c
linux-2.6.7-bk20.src/drivers/block/cpqarray.c
linux-2.6.7-bk20.src/drivers/block/paride/pt.c
linux-2.6.7-bk20.src/drivers/cdrom/aztcd.c
linux-2.6.7-bk20.src/drivers/char/h8.c
linux-2.6.7-bk20.src/drivers/char/ip2main.c
linux-2.6.7-bk20.src/drivers/char/ipmi/ipmi_bt_sm.c
linux-2.6.7-bk20.src/drivers/char/isicom.c
linux-2.6.7-bk20.src/drivers/char/rio/rioboot.c
linux-2.6.7-bk20.src/drivers/char/rio/rioinit.c
linux-2.6.7-bk20.src/drivers/char/rio/riointr.c
linux-2.6.7-bk20.src/drivers/char/rio/riotty.c
linux-2.6.7-bk20.src/drivers/char/rocket.c
linux-2.6.7-bk20.src/drivers/char/specialix.c
linux-2.6.7-bk20.src/drivers/char/sx.c
linux-2.6.7-bk20.src/drivers/i2c/algos/i2c-algo-ite.c
linux-2.6.7-bk20.src/drivers/ide/ide-cd.c
linux-2.6.7-bk20.src/drivers/ide/pci/cs5520.c
linux-2.6.7-bk20.src/drivers/ide/pci/sc1200.c
linux-2.6.7-bk20.src/drivers/ide/pci/sis5513.c
linux-2.6.7-bk20.src/drivers/isdn/divert/divert_init.c
linux-2.6.7-bk20.src/drivers/isdn/hardware/eicon/divamnt.c
linux-2.6.7-bk20.src/drivers/isdn/hisax/hfc_usb.c
linux-2.6.7-bk20.src/drivers/isdn/hisax/q931.c
linux-2.6.7-bk20.src/drivers/isdn/hysdn/hysdn_init.c
linux-2.6.7-bk20.src/drivers/isdn/hysdn/hysdn_sched.c
linux-2.6.7-bk20.src/drivers/isdn/i4l/isdn_tty.c
linux-2.6.7-bk20.src/drivers/isdn/i4l/isdn_ttyfax.c
linux-2.6.7-bk20.src/drivers/md/md.c
linux-2.6.7-bk20.src/drivers/md/raid1.c
linux-2.6.7-bk20.src/drivers/media/dvb/b2c2/skystar2.c
linux-2.6.7-bk20.src/drivers/media/dvb/bt8xx/bt878.c
linux-2.6.7-bk20.src/drivers/media/dvb/frontends/dst.c
linux-2.6.7-bk20.src/drivers/media/video/bttv-cards.c
linux-2.6.7-bk20.src/drivers/message/fusion/mptbase.c
linux-2.6.7-bk20.src/drivers/message/fusion/mptscsih.c
linux-2.6.7-bk20.src/drivers/message/i2o/i2o_block.c
linux-2.6.7-bk20.src/drivers/message/i2o/i2o_proc.c
linux-2.6.7-bk20.src/drivers/mtd/maps/tqm8xxl.c
linux-2.6.7-bk20.src/drivers/mtd/nand/nand.c
linux-2.6.7-bk20.src/drivers/net/3c505.c
linux-2.6.7-bk20.src/drivers/net/b44.c
linux-2.6.7-bk20.src/drivers/net/bonding/bond_main.c
linux-2.6.7-bk20.src/drivers/net/eepro.c
linux-2.6.7-bk20.src/drivers/net/hamradio/baycom_ser_fdx.c
linux-2.6.7-bk20.src/drivers/net/ibm_emac/ibm_emac_debug.c
linux-2.6.7-bk20.src/drivers/net/sis900.c
linux-2.6.7-bk20.src/drivers/net/sk_g16.c
linux-2.6.7-bk20.src/drivers/net/smc9194.c
linux-2.6.7-bk20.src/drivers/net/tlan.c
linux-2.6.7-bk20.src/drivers/net/tokenring/3c359.c
linux-2.6.7-bk20.src/drivers/net/tokenring/lanstreamer.c
linux-2.6.7-bk20.src/drivers/net/tokenring/olympic.c
linux-2.6.7-bk20.src/drivers/net/tokenring/tms380tr.c
linux-2.6.7-bk20.src/drivers/net/tulip/de4x5.c
linux-2.6.7-bk20.src/drivers/net/tulip/xircom_cb.c
linux-2.6.7-bk20.src/drivers/net/wan/pc300_drv.c
linux-2.6.7-bk20.src/drivers/net/wan/sdla.c
linux-2.6.7-bk20.src/drivers/net/wan/sdla_chdlc.c
linux-2.6.7-bk20.src/drivers/net/wan/sdla_fr.c
linux-2.6.7-bk20.src/drivers/net/wan/sdla_x25.c
linux-2.6.7-bk20.src/drivers/net/wan/sdladrv.c
linux-2.6.7-bk20.src/drivers/net/wan/wanpipe_multppp.c
linux-2.6.7-bk20.src/drivers/net/wireless/airo.c
linux-2.6.7-bk20.src/drivers/net/wireless/arlan-main.c
linux-2.6.7-bk20.src/drivers/net/wireless/arlan-proc.c
linux-2.6.7-bk20.src/drivers/net/wireless/prism54/islpci_dev.c
linux-2.6.7-bk20.src/drivers/net/wireless/ray_cs.c
linux-2.6.7-bk20.src/drivers/parisc/eisa_enumerator.c
linux-2.6.7-bk20.src/drivers/parisc/superio.c
linux-2.6.7-bk20.src/drivers/pci/hotplug/rpaphp_pci.c
linux-2.6.7-bk20.src/drivers/pcmcia/au1000_generic.c
linux-2.6.7-bk20.src/drivers/pcmcia/i82092.c
linux-2.6.7-bk20.src/drivers/s390/block/dasd_proc.c
linux-2.6.7-bk20.src/drivers/s390/cio/blacklist.c
linux-2.6.7-bk20.src/drivers/s390/net/ctctty.c
linux-2.6.7-bk20.src/drivers/scsi/53c7xx.c
linux-2.6.7-bk20.src/drivers/scsi/NCR5380.c
linux-2.6.7-bk20.src/drivers/scsi/NCR53C9x.c
linux-2.6.7-bk20.src/drivers/scsi/aha1542.c
linux-2.6.7-bk20.src/drivers/scsi/aha1740.c
linux-2.6.7-bk20.src/drivers/scsi/atari_NCR5380.c
linux-2.6.7-bk20.src/drivers/scsi/atp870u.c
linux-2.6.7-bk20.src/drivers/scsi/cpqfcTSinit.c
linux-2.6.7-bk20.src/drivers/scsi/cpqfcTSworker.c
linux-2.6.7-bk20.src/drivers/scsi/dpt_i2o.c
linux-2.6.7-bk20.src/drivers/scsi/eata_pio.c
linux-2.6.7-bk20.src/drivers/scsi/gdth.c
linux-2.6.7-bk20.src/drivers/scsi/i91uscsi.c
linux-2.6.7-bk20.src/drivers/scsi/ips.c
linux-2.6.7-bk20.src/drivers/scsi/mac_esp.c
linux-2.6.7-bk20.src/drivers/scsi/ncr53c8xx.c
linux-2.6.7-bk20.src/drivers/scsi/qla1280.c
linux-2.6.7-bk20.src/drivers/scsi/qla2xxx/qla_dbg.c
linux-2.6.7-bk20.src/drivers/scsi/qla2xxx/qla_init.c
linux-2.6.7-bk20.src/drivers/scsi/qla2xxx/qla_os.c
linux-2.6.7-bk20.src/drivers/scsi/qlogicfc.c
linux-2.6.7-bk20.src/drivers/scsi/qlogicisp.c
linux-2.6.7-bk20.src/drivers/scsi/script_asm.pl
linux-2.6.7-bk20.src/drivers/scsi/scsicam.c
linux-2.6.7-bk20.src/drivers/scsi/scsiiom.c
linux-2.6.7-bk20.src/drivers/scsi/sd.c
linux-2.6.7-bk20.src/drivers/scsi/seagate.c
linux-2.6.7-bk20.src/drivers/scsi/sg.c
linux-2.6.7-bk20.src/drivers/scsi/sun3_NCR5380.c
linux-2.6.7-bk20.src/drivers/telephony/ixj.c
linux-2.6.7-bk20.src/drivers/video/aty/atyfb_base.c
linux-2.6.7-bk20.src/drivers/video/hgafb.c
linux-2.6.7-bk20.src/drivers/video/sstfb.c
linux-2.6.7-bk20.src/fs/cifs/cifs_debug.c
linux-2.6.7-bk20.src/fs/cifs/connect.c
linux-2.6.7-bk20.src/fs/jffs2/erase.c
linux-2.6.7-bk20.src/fs/jffs2/nodelist.c
linux-2.6.7-bk20.src/fs/lockd/svclock.c
linux-2.6.7-bk20.src/fs/nfs/nfs4renewd.c
linux-2.6.7-bk20.src/fs/nfsd/nfsproc.c
linux-2.6.7-bk20.src/fs/umsdos/mangle.c
linux-2.6.7-bk20.src/include/asm-ppc/ppc405_dma.h
linux-2.6.7-bk20.src/net/8021q/vlan.c
linux-2.6.7-bk20.src/net/sched/act_api.c
linux-2.6.7-bk20.src/net/sched/sch_ingress.c
linux-2.6.7-bk20.src/net/sunrpc/auth_gss/auth_gss.c
linux-2.6.7-bk20.src/net/sunrpc/auth_gss/gss_krb5_seal.c
linux-2.6.7-bk20.src/net/wanrouter/af_wanpipe.c
linux-2.6.7-bk20.src/scripts/conmakehash.c
linux-2.6.7-bk20.src/scripts/kernel-doc
linux-2.6.7-bk20.src/sound/core/info_oss.c
linux-2.6.7-bk20.src/sound/core/seq/seq_fifo.c
linux-2.6.7-bk20.src/sound/core/seq/seq_timer.c
linux-2.6.7-bk20.src/sound/drivers/mtpav.c
linux-2.6.7-bk20.src/sound/drivers/vx/vx_pcm.c
linux-2.6.7-bk20.src/sound/isa/gus/gus_mem.c
linux-2.6.7-bk20.src/sound/oss/ali5455.c
linux-2.6.7-bk20.src/sound/oss/cs4281/cs4281m.c
linux-2.6.7-bk20.src/sound/oss/cs46xx.c
linux-2.6.7-bk20.src/sound/oss/dmasound/dac3550a.c
linux-2.6.7-bk20.src/sound/oss/dmasound/tas_common.h
linux-2.6.7-bk20.src/sound/oss/forte.c
linux-2.6.7-bk20.src/sound/oss/swarm_cs4297a.c
linux-2.6.7-bk20.src/sound/pci/ali5451/ali5451.c
linux-2.6.7-bk20.src/sound/pci/au88x0/au88x0_eq.c
linux-2.6.7-bk20.src/sound/pci/cs46xx/dsp_spos.c
linux-2.6.7-bk20.src/sound/ppc/daca.c
linux-2.6.7-bk20.src/sound/ppc/tumbler.c

I have applied all of them and am recompiling the tree.
I wonder, will there be some breakage?...
--
vda

--Boundary-00=_0SUGBEK3y0Ojfy3
Content-Type: application/x-shellscript;
  name="trailing_ws_autopatcher.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trailing_ws_autopatcher.sh"

#!/bin/sh

tree=linux-2.6.7-bk20.src

mkdir -p "tmp.$tree"
>"tmp.$tree/filelist"

grep -r 'print.* \\n' "$tree" \
| cut -d: -f1 \
| sort | uniq \
| while read -r file; do
    base=`basename "$file"`
    file2="tmp.$file"

    echo "$file" >>"tmp.$tree/filelist"
    echo "* $file"

    mkdir -p `dirname "$file2"`

    # Multiple seds handle stuff like:
    # printk(KERN_WARNING "ISILoad:Card%d rejected load header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n"
    # (multiple ' \n' occurences)
    # s/.../.../g would not help here
    cat "$file" \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    | sed 's/\(print.*[^ ]\)  *\\n/\1\\n/' \
    > "$file2"

    diff -up "$file" "$file2" >"tmp.$tree/$base.patch"
done

--Boundary-00=_0SUGBEK3y0Ojfy3--

