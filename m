Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSGVBky>; Sun, 21 Jul 2002 21:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSGVBky>; Sun, 21 Jul 2002 21:40:54 -0400
Received: from surf.viawest.net ([216.87.64.26]:21411 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315454AbSGVBkx>;
	Sun, 21 Jul 2002 21:40:53 -0400
Date: Sun, 21 Jul 2002 18:43:51 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.27-dj1
Message-ID: <20020722014351.GA9901@wizard.com>
References: <20020721215845.GA23019@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020721215845.GA23019@suse.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 6:40pm  up  1:36,  2 users,  load average: 0.00, 0.02, 0.09
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 10:58:45PM +0100, Dave Jones wrote:
> Mostly resyncing with the various trees that have sprouted in
> the last week, and applying obvious stuff that didn't take much thinking.
> Syncing with 4 new releases is no small feat, so this patchset is
> *mostly* just a standing still release.
> I'll start digging through the *huge* backlog of patches next time.
> 

        Just gave it a run:

  Generating /usr/src/linux-2.5.25/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.25/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4  -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=version   -c -o version.o version.c
   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.25/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o 
arch/i386/kernel/init_task.o init/init.o --start-group 
arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o 
ipc/ipc.o security/built-in.o /usr/src/linux-2.5.25/arch/i386/lib/lib.a 
lib/lib.a /usr/src/linux-2.5.25/arch/i386/lib/lib.a drivers/built-in.o 
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
fs/fs.o: In function `proc_pid_stat':
fs/fs.o(.text+0x2214b): undefined reference to `jiffies_64_to_clock_t'
fs/fs.o: In function `kstat_read_proc':
fs/fs.o(.text+0x232f3): undefined reference to `jiffies_64_to_clock_t'
fs/fs.o(.text+0x2335a): undefined reference to `jiffies_64_to_clock_t'


CONFIG_REISERFS_FS=m
CONFIG_HFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_ZISOFS_FS=m

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

