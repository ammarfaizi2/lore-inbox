Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTBRICR>; Tue, 18 Feb 2003 03:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBRICR>; Tue, 18 Feb 2003 03:02:17 -0500
Received: from 117.catv45.aar01.lan.ch ([212.60.45.117]:26897 "EHLO
	bolli.homeip.net") by vger.kernel.org with ESMTP id <S267034AbTBRICQ> convert rfc822-to-8bit;
	Tue, 18 Feb 2003 03:02:16 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Date: Tue, 18 Feb 2003 09:12:03 +0100
From: bbolli@ymail.ch (Beat Bolli)
Message-ID: <20030218081203.GA20989@bolli.homeip.net>
Mime-Version: 1.0
Subject: kbuild: error with parallel make and modules
To: linux-kernel@vger.kernel.org
User-Agent: Mutt/1.5.3i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.0.6
	 at gw.bolli.homeip.net has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is what I get since 2.6.61 when building with make -j2:

  Building modules, stage 2.
make -rR -f scripts/Makefile.modpost
echo '  Generating build number'
  Generating build number
. ./scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  Generating include/linux/compile.h (updated)
  gcc-3.2 -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i486 -falign-functions=0 -falign-jumps=0 -falign-loops=0 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
  scripts/modpost vmlinux drivers/net/3c59x.o drivers/i2c/chips/adm1021.o crypto/aes.o fs/binfmt_aout.o fs/binfmt_misc.o crypto/blowfish.o drivers/net/bsd_comp.o arch/i386/kernel/cpuid.o crypto/des.o fs/exportfs/exportfs.o drivers/i2c/i2c-algo-bit.o drivers/i2c/i2c-core.o drivers/i2c/i2c-dev.o drivers/i2c/i2c-proc.o drivers/i2c/busses/i2c-viapro.o net/ipv4/netfilter/ip_conntrack.o net/ipv4/netfilter/ip_conntrack_ftp.o net/ipv4/netfilter/ip_conntrack_irc.o net/ipv4/netfilter/ip_nat_ftp.o net/ipv4/netfilter/ip_nat_irc.o net/ipv4/netfilter/ip_tables.o net/ipv4/netfilter/ipt_LOG.o net/ipv4/netfilter/ipt_MASQUERADE.o net/ipv4/netfilter/ipt_MIRROR.o net/ipv4/netfilter/ipt_REDIRECT.o net/ipv4/netfilter/ipt_REJECT.o net/ipv4/netfilter/ipt_conntrack.o net/ipv4/netfilter/ipt_helper.o net/ipv4/netfilter/ipt_limit.o net/ipv4/netfilter/ipt_mac.o net/ipv4/netfilter/ipt_mark.o net/ipv4/netfilter/ipt_multiport.o net/ipv4/netfilter/ipt_pkttype.o net/ipv4/netfilter/ipt_state.o net/ipv4/netfilter/ipt_tos.o net/ipv4/netfilter/iptable_filter.o net/ipv4/netfilter/iptable_nat.o fs/isofs/isofs.o fs/jfs/jfs.o drivers/i2c/chips/lm75.o fs/lockd/lockd.o crypto/md4.o crypto/md5.o fs/nfs/nfs.o fs/nfsd/nfsd.o drivers/net/pcnet32.o drivers/net/ppp_async.o drivers/net/ppp_deflate.o drivers/net/ppp_generic.o fs/reiserfs/reiserfs.o drivers/scsi/scsi_mod.o drivers/scsi/sd_mod.o crypto/serpent.o crypto/sha1.o crypto/sha256.o crypto/sha512.o drivers/net/slhc.o fs/smbfs/smbfs.o sound/pci/ac97/snd-ac97-codec.o sound/drivers/mpu401/snd-mpu401-uart.o sound/core/snd-pcm.o sound/core/snd-rawmidi.o sound/core/snd-rtctimer.o sound/core/snd-timer.o sound/pci/snd-via82xx.o sound/core/snd.o sound/soundcore.o net/sunrpc/sunrpc.o drivers/net/tun.o crypto/twofish.o drivers/usb/host/uhci-hcd.o drivers/usb/storage/usb-storage.o drivers/usb/core/usbcore.o drivers/usb/misc/usblcd.o drivers/usb/net/usbnet.o lib/zlib_deflate/zlib_deflate.o lib/zlib_inflate/zlib_inflate.o
modpost: vmlinux is truncated.
make[1]: *** [__modpost] Error 134
make: *** [modules] Error 2
make: *** Waiting for unfinished jobs....
echo 'cmd_vmlinux :=    ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux' > ./.vmlinux.cmd
make: *** Waiting for unfinished jobs....
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make: *** Waiting for unfinished jobs....
Command exited with non-zero status 2

It seems like scripts/Makefile.modpost starts before vmlinux has finished linking.

Beat Bolli
-- 
mail: `echo '<bNObolli@ymaSPilAM.ch>' | sed -e 's/[A-S]//g'`
pgp:  0x506A903A; 49D5 794A EA77 F907 764F D89E 304B 93CF 506A 903A
icbm: 47° 02' 43.0" N, 07° 16' 17.5" E (WGS84)
