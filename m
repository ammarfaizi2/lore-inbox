Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbTGKA2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbTGKA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:28:25 -0400
Received: from smtp1.libero.it ([193.70.192.51]:36047 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S266562AbTGKA2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:28:02 -0400
From: Federico Briata <federicobriata@tiscali.it>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.21 on Sparc32_SMP
Date: Fri, 11 Jul 2003 02:42:37 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307110242.38015.federicobriata@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is Oops on 2.4.21 when during the boot the sys crashes this happens =
70% of times (more details below):

<OOPS>
# ksymoops -V /boot/vmlinux -m /boot/System.map < /messages_oops.out > =
ksymoops.txt

ksymoops 2.4.5 on sparc 2.4.21.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map (specified)

spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlock%s[%d]: scall<%d> (could be %d)
Aieee: sun4m NMI received!
Aieee: sun4d NMI received!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
Caller[%08lx]
irq:  %d [ %u ]
bh:   %d [ ]
PC =3D %08lx NPC =3D %08lx FP=3D%08lx
Expecting: [%s:%d:0x%x] AIEEE
kernel BUG at %s:%d!
kernel BUG at %s:%d!
kernel BUG at %s:%d!
i0: %08lx i1: %08lx i2: %08lx i3: %08lx i4: %08lx i5: %08lx fp: %08lx =
i7: %08lx
CPU[%d]: ARGS[%08lx,%08lx,%08lx,%08lx,%08lx,%08lx] FP[%08lx] =
CALLER[%08lx]
PSR: %08lx PC: %08lx NPC: %08lx Y: %08lx    %s
g0: %08lx g1: %08lx g2: %08lx g3: %08lx g4: %08lx g5: %08lx g6: %08lx =
g7: %08lx
o0: %08lx o1: %08lx o2: %08lx o3: %08lx o4: %08lx o5: %08lx sp: %08lx =
o7: %08lx
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlocksparc_dvmasparc_iomapphys_%08xfree_io/iounmap: cannot free %lx
kernel BUG at %s:%d!
io_mapdvma_mapspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlock%s[%d]: Unimplemented SPARC =
system call %d
spin_lockwrite_lockread_lockread_unlock0123456789abcdefOKE03E01E02spin_lo=
ckwrite_lockread_lockread_unlockCLOCK: Clock was stopped. Kick start .
spin_lockwrite_lockread_lockread_unlockFujitsu or Weitek on-chip =
FPUMatsushita MN10501TI MicroSparc on chip FPUSuperSparc on-chip FPUBIT =
B5010 or B5110/20 or B5210Cypress CY7C602 FPUTexas Instruments =
TMS390-C602ALsi Logic L64814ROSS HyperSparc combined IU/FPUNo =
FPUreservedLsi Logic/Meiko L64804 or compatibleWeitek WTL3170/2LSI Logic =
L64802 or Texas Instruments ACT8847Fujitsu MB86911 or Weitek WTL1164/5 =
or LSI L64831Fujitsu MB86910 or Weitek WTL1164/5UNKNOWN =
CPU-VENDOR/TYPEFujitsu or Weitek Power-UPSystems and Processes =
Engineering Corporation (SPEC)Harvest VLSI Design Center, Inc. - =
unknownPhilips Corporation - unknownMatsushita - MN10501Texas =
Instruments, Inc. - unknownTexas Instruments, Inc. - SuperSparc 61Texas =
Instruments, Inc. - SuperSparc 51Texas Instruments, Inc. - MicroSparc =
IITexas Instruments, Inc. - MicroSparcTexas Instruments, Inc. - =
SuperSparc-(II)LSI Logic Corporation - unknown-typeBipolar Integrated =
Technology - B5010ROSS HyperSparc RT625 or RT626ROSS HyperSparc =
RT620Cypress/ROSS CY7C611Cypress/ROSS CY7C601LSI Logic Corporation - =
L64811Fujitsu TurboSparc MB86907Fujitsu  MB86904Fujitsu  MB86900/1A or =
LSI L64831 SparcKIT-40DEBUG: psr.impl =3D 0x%x   psr.vers =3D 0x%x
spin_lockwrite_lockread_lockread_unlocknameTadpoleobioclk-ctrlClock =
Stopping h/w detected... addressenabled (S3)
spin_lockwrite_lockread_lockread_unlockcounter14spin_lockwrite_lockread_l=
ockread_unlock%s [%d]: Wants to read user offset %ld
spin_lockwrite_lockread_lockread_unlockNo solaris handler
spin_lockwrite_lockread_lockread_unlockImpossible unaligned trap. =
insn=3D%08x
Byte sized unaligned access?!?!<1>Unable to handle kernel NULL pointer =
dereference in mna handler<1>Unable to handle kernel paging request in =
mna handler<1> at virtual address %08lx
Impossible user unaligned =
trap.spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockr=
ead_unlockspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_=
lockread_unlockkernel BUG at %s:%d!
CPU[%d]: Returns from cpu_idle!
spin_lockwrite_lockread_lockread_unlockEntering SMP Mode...
spin_lockwrite_lockread_lockread_unlocknoidleapcpower-management<3>%s: =
unable to map registers
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockThe machine has more banks than =
this kernel can support
FAULT: NMI received
<1>Unable to handle kernel NULL pointer dereference
<1>Unable to handle kernel paging request at virtual address %08lx
<1>tsk->{mm,active_mm}->context =3D %08lx
<1>tsk->{mm,active_mm}->pgd =3D %08lx
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockload_mmu: %d unsupported
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lock=
read_lockread_unlockspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockregXPTCannot map External Page =
Table.iounit_get_area: Couldn't find free iopte slots for (%08lx,%d)
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
kernel BUG at %s:%d!
WTZDSR%-13.13s   current   %08lX %5lu %5d %6d %5d       %7d        %5d =
(L-TLB)
Using defaults from ksymoops -t elf32-sparc -a sparc
 (NOTLB)
spin_lockcascade%2d: %s
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  WTZDSR%-13.13s

>>PC;  00000000 Before first symbol

Tainted: %c%cNot taintedkernel BUG in header file at line %d
kernel BUG at %s:%d!
panic.cspin_lockwrite_lockread_lockread_unlockttySttyattyS0ttybttyS1kerne=
l BUG at %s:%d!
printk.c<0>%sspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h<3>Aiee, inter_module_register: cannot kmalloc entry for =
'%s'
spin_lockwrite_lockread_lockread_unlocktask releasing itself
kernel BUG at %s:%d!
exit.cAiee, killing interrupt handler!Attempted to kill the idle =
task!Attempted to kill =
init!spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockr=
ead_unlockspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_=
lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockPCI IOPCI mem<BAD>        =
%08lx-%08lx : %s
%d%luspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockr=
ead_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockuid_cacheCannot create uid =
taskcount SLAB cache
spin_lockwrite_lockread_lockread_unlocksigqueuesignals_init(): cannot =
create sigqueue SLAB =
cachespin_lockwrite_lockread_lockread_unlock<0>Restarting system.
spin_lockwrite_lockread_lockread_unlockPATH=3D/sbin:/usr/sbin:/bin:/usr/b=
inTERM=3DlinuxHOME=3D/-s-k--<3>kmod: failed to exec %s -s -k %s, errno =
=3D %d
spin_lockwrite_lockread_lockread_unlock<3>%s(): keventd has not started
current_is_keventdschedule_taskkeventdspin_lockwrite_lockread_lockread_un=
lockspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/linux/blkdev.hcdroms/cdrom%d/usr/src/linux-=
2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/linux/highmem.h=
Using_Versionsspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
mmap.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
mprotect.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
mremap.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
broken%-17s %6lu %6lu %6u %4lu %4lu %4u : %4u =
%4uspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Out of memoryspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hswap.cspin_lockwrite_lockread_lockread_unlockkernel BUG =
at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
page_io.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
swap_state.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlock<3>Out of Memory: Killed process %d (%s).
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
dev/zerospin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockCharacter devices:
spin_lockwrite_lockread_lockread_unlock<4>VFS: filp allocation failed
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
%9s: BUG -> found %d, reported %d
bdflushkupdatedspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
unknown-block%s(%d,%d)spin_lockwrite_lockread_lockread_unlockcdev_cacheCa=
nnot create cdev_cache SLAB =
cachespin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockr=
ead_unlockkernel BUG at %s:%d!
exec.cbinfmt-%04x%d%ld%s.%dspin_lockwrite_lockread_lockread_unlockkernel =
BUG at %s:%d!
pipe.c[%lu]pipe:=C3=B0=17=C3=8D=05pipefsspin_lockwrite_lockread_lockread_=
unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.husr/gnemul/sunos/usr/gnemul/solaris/=04=02=06spin_lockwrit=
e_lockread_lockread_unlockkernel BUG at %s:%d!
fasync_cachecannot create fasync slab =
cachespin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockr=
ead_unlock...spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockre=
ad_lockread_unlockspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
 ->file_lock_cachecannot create file lock slab =
cachespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
buffer_headCannot create buffer head SLAB cachenames_cacheCannot create =
names SLAB cachefilpCannot create filp SLAB =
cachespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
inode_cachecannot create inode slab =
cachespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
attr.cspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lock=
read_unlockkernel BUG at %s:%d!
free_fd_arrayfree_fdsetspin_lockwrite_lockread_lockread_unlockkernel BUG =
at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockprocnetsysvipcsyssys/fssys/fs/binf=
mt_miscfsdriveropenprombus/procspin_lockwrite_lockread_lockread_unlockmou=
ntsexerootcwdmemmapscpustatmstatcmdlinestatusenvironfd...procfs: =
impossible type =
(%d)%dselfspin_lockwrite_lockread_lockread_unlock...remove_proc_entry: =
%s/%s busy, count=3D%d
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Pid:    %d
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlock%d-%d%dsystem:/dev/ttysystem:consolesystem:vtmastersystemconsoleseri=
al:calloutserialpty:masterpty:slaveptytype:%d.%d%-20s /dev/%-8s %3d %7s =
%s
???ttytty/ldisctty/drivertty/ldiscstty/driversspin_lockwrite_lockread_loc=
kread_unlockkernel BUG at %s:%d!
execdomainsiomemswapslockscmdlineioportsdmafilesystemsinterruptsdevicesst=
atmodulesversionmeminfouptimeloadavgmountsself/mountskmsgcpuinfopartition=
sslabinfoksymskcoreprofilespin_lockwrite_lockread_lockread_unlockkernel =
BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h=7FELFCOREvmlinuxspin_lockwrite_lockread_lockread_unlockke=
rnel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hext2_get_group_descblock_group >=3D groups_count - =
block_group =3D %d, groups_count =3D %luGroup descriptor not loaded - =
block_group =3D %d, group_desc =3D %lu, desc =3D =
%luread_block_bitmapCannot read block bitmap - block_group =3D %d, =
block_bitmap =3D %luload_block_bitmap__load_block_bitmapblock_group !=3D =
block_bitmap_numberext2_free_blocks: nonexistent =
deviceext2_free_blocksFreeing blocks not in datazone - block =3D %lu, =
count =3D %luFreeing block in system zone - block =3D %lubit already =
cleared for block %luext2_new_block: nonexistent =
deviceext2_new_blockFree blocks count corrupted for block group =
%dAllocating block in system zone - block =3D %ubit already set for =
block %dblock(%d) >=3D blocks count(%d) - block_group =3D %d, es =3D=3D =
%p spin_lockspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hext2_check_pagesize of directory #%lu is not a multiple =
of chunk sizerec_len is smaller than minimalunaligned directory =
entryrec_len is too small for name_lendirectory entry across blocksinode =
out of boundsbad entry in directory #%lu: %s - offset=3D%lu, =
inode=3D%lu, rec_len=3D%d, name_len=3D%dentry in directory #%lu spans =
the page boundaryoffset=3D%lu, =
inode=3D%ludir.c...spin_lockwrite_lockread_lockread_unlockspin_lockwrite_=
lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hread_inode_bitmapCannot read inode bitmap - block_group =
=3D %lu, inode_bitmap =3D %luload_inode_bitmapblock_group >=3D =
groups_count - block_group =3D %d, groups_count =3D %lublock_group !=3D =
inode_bitmap_numberext2_free_inodereserved or nonexistent inode %lubit =
already cleared for inode %luext2_new_inodereserved inode or inode > =
inodes count - block_group =3D %d,inode=3D%ldFree inodes count corrupted =
in group %dspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
ext2spin_lockspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hramfsrootfsspin_lockwrite_lockread_lockread_unlockunknownk=
ernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
kernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Aiee.. nfs swap-in of page failed!
spin_lockwrite_lockread_lockread_unlockunknownkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hspin_lockwrite_lockread_lockread_unlockunknownkernel BUG =
at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hnfs_delete_queuespin_lockwrite_lockread_lockread_unlockker=
nel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
NLM: reclaiming locks for host =
%s%s-reclaimspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockunknown%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockunknownwrite_lockread_lockread_unlock%d: %08x %08x %08x %08x =
%08x %08x<3>fh_copy: copying %s/%s, already verified!
spin_lockwrite_lockread_lockread_unlockUnable to load NLS charset %s: =
name too long
defaultiso8859-1spin_lock...%dspin_lockwrite_lockread_lockread_unlockkern=
el BUG at %s:%d!
devptsspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
util.cspin_lockwrite_lockread_lockread_unlocksysvipc/msgkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlocksysvipc/semkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlocksysvipc/shmkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockNULL tty<4>Warning: bad magic =
number for tty struct (%s) in %s
<4>Warning: null TTY for (%s) in %s
<4>Warning: dev (%s) tty->count(%d) !=3D #fd's(%d) in %s
spin_lockwrite_lockread_lockread_unlock        %s: %d input overrun(s)
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlock;n =
=C3=88v=C3=9CA=C2=90M=C2=B2aX=C3=AD=C2=B8=C6=92 =
=C3=96=C3=96=C2=A3=C3=A8=E2=80=BAd=C3=82=C2=B0=20
spin_lockwrite_lockread_lockread_unlock<4>selection: kmalloc() failed
spin_lockwrite_lockread_lockread_unlock<3>busmouse: trying to allocate =
mouse on minor %d
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/linux/blkdev.h/usr/src/linux-2.4.21/include=
/asm/highmem.h/usr/src/linux-2.4.21/include/linux/highmem.hspin_lockwrite=
_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
floppy: Giving up...floppyobioSUNW,fdtwofdstatusdisabledregkernel BUG at =
%s:%d!
warning: usage count=3D0, CURRENT=3D%p exiting
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlock=C3=AD=C2=B8=C6=92 =
=04=C3=81=1D=C2=B7kernel BUG at %s:%d!
leledmaspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
eth%dspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Device already registeredspin_lockwrite_lockread_lockread_unlockkernel =
BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
        command =3D =
DID_SOFT_ERRORDID_PASSTHROUGHDID_BAD_INTRDID_RESETDID_ERRORDID_PARITYDID_=
ABORTDID_BAD_TARGETDID_TIME_OUTDID_BUS_BUSYDID_NO_CONNECTDID_OKHostbyte=3D=
0x%02xis invalid (%s) =
DRIVER_HARDDRIVER_TIMEOUTDRIVER_INVALIDDRIVER_ERRORDRIVER_MEDIADRIVER_SOF=
TDRIVER_BUSYDRIVER_OKSUGGEST_SENSESUGGEST_DIESUGGEST_REMAPSUGGEST_ABORTSU=
GGEST_RETRYSUGGEST_OKDriverbyte=3D0x%02x(%s,%s) =
invalidspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/linux/blkdev.h/usr/src/linux-2.4.21/include=
/asm/highmem.h/usr/src/linux-2.4.21/include/linux/highmem.hspin_lockwrite=
_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
scsi_eh_%dspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
Internal error %s %d=20
Internal error %s %d=20
Internal error in file %s, line %d.
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/linux/blkdev.h/usr/src/linux-2.4.21/include=
/asm/highmem.h/usr/src/linux-2.4.21/include/linux/highmem.h$Header: =
/mnt/ide/home/eric/CVSROOT/linux/drivers/scsi/scsi_queue.c,v 1.1 =
1997/10/21 11:16:38 eric Exp =
$spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/linux/blkdev.h/usr/src/linux-2.4.21/include=
/asm/highmem.h/usr/src/linux-2.4.21/include/linux/highmem.hspin_lockwrite=
_lockread_lockread_unlockkernel BUG at %s:%d!
esp%d: AIEEE wide msg received and not HME.
esp%d: AIEEE wide transfer for %d size not supported.
esp%d: Aieee, wide nego of %d size.
esp%d: AIEEE we have been selected by another initiator!
Sun ESP 100/100a/200spin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockcdroms/cdrom%dkernel BUG at =
%s:%d!
sr%dcdspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockcdroms/cdrom%d<6>cdrom: entering =
register_cdrom
spin_lockwrite_lockread_lockread_unlocknameaddressregfill_sbus_device: =
proplen for regs of %s  was %d, need multiple of %d
spin_lockwrite_lockread_lockread_unlock<6>sunmouse: Successfully =
adjusted to %d baud.
spin_lockwrite_lockread_lockread_unlockOops: %s called
spin_lockwrite_lockread_lockread_unlockzs_stopzs_start
spin_lockwrite_lockread_lockread_unlockrtc<3>rtc: unable to get misc =
minor for Mostek
spin_lockdummy =
device=C3=B0=0F{=C3=B0=C3=B0=0F{=C3=BC=C3=B0=0F|D=C3=B0=0F|D=C3=B0=0F|D=C3=
=B0=0F|D=C3=B0=0F|D=C3=B0=0F|D=C3=B0=0F|D=C3=B0=0F|D=C3=B0=0F|D=C3=B0=0F|=
D=C3=B0=0F|D=C3=B0=0F|Dspin_lockwrite_lockread_lockread_unlock%*.*s=08=1B=
[7m%c=08=1B[@%c=1B[m=08=1B[7m%c=1B[m=08=1B[@%c=08%c=08=1B[@=1B[7m%c=1B[m=08=
%c=08=1B[@%c=1B[7m%c=1B[m=08%c=08=1B[%d;%dHPROMoptionsscreen-#columnsscre=
en-#rows=1B[H=1B[J=1B[7m=1B[m=1B[7m%c=1B[m%c=08=1B[@%c=08=1B[@%c=1B[%dH=1B=
[J=1B[%dH=1B[K
fbcon_redraw_bmove width sy !=3D dy=C3=B0=0F=C2=A8 =
=C3=B0=0F=C2=A8x=C3=B0=0F=C2=A9@=C3=B0=0F=C2=B3=C2=90=C3=B0=0F=C2=B5<=C3=B0=
=0F=C2=B6,=C3=B0=0F=C2=B70=C3=B0=0F=C3=80=C3=B4=C3=B0=0F=C3=8B=14=C3=B0=0F=
=C3=8Dx=C3=B0=0F=C3=8F=C3=90=C3=B0=0F=C3=97=C2=B4=C3=B0=0F=C3=9B=C2=A4=C3=
=B0=0F=C3=9F=C5=93=C3=B0=0F=C3=A2=C3=8C=C3=B0=0F=C3=9E=C3=94=C3=B0=0F=C3=9C=
=C3=8C=C3=B0=0F=C3=9Dpspin_lockwrite_lockread_lockread_unlockkernel BUG =
at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.hdblbufcgsix ramcgsix fbccgsix teccgsix thccgsix daccgsix =
fhcsparc68020i386TGXTGX+GXGX+cgsix at %x.%08lx TEC Rev %x CPU %s Rev %x =
[%s]CGsix [%s]spin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
cgsixcgthree+cgthreecgRDIcgfourteenleobwtwotcxp9100emulationspin_lockwrit=
e_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
sock<2>sk_init: Cannot create sock SLAB =
cache!spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
<4>Warning: kfree_skb passed an skb still on a list (from %p).
<4>Warning: kfree_skb on hard IRQ %p
skbuff_head_cachecannot create skbuff =
cachespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockhot_list_lengthoptmem_maxmessage_burstmessage=
_costmod_conglo_congno_congno_cong_threshnetdev_max_backlogdev_weightrmem=
_defaultwmem_defaultrmem_maxwmem_maxspin_lockwrite_lockread_lockread_unlo=
ckkernel BUG at %s:%d!
<2>Dead loop on virtual device %s, fix it urgently!
 face |bytes    packets errs drop fifo frame compressed multicast|bytes  =
  packets errs drop fifo colls carrier compressed
devnet/softnet_statnet/driversspin_lockwrite_lockread_lockread_unlockkern=
el BUG at %s:%d!
net/dev_mcastspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockkernel BUG at %s:%d!
netneighdefaultgc_thresh3gc_thresh2gc_thresh1gc_intervallocktimeproxy_del=
ayanycast_delayproxy_qlenunres_qlengc_stale_timedelay_first_probe_timebas=
e_reachable_timeretrans_timeapp_solicitucast_solicitmcast_solicitspin_loc=
kwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlock<4>NET: %d messages suppressed.
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_u=
nlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.h802.3spin_l=
ockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread_unlockk=
ernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
net/netlinkspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
routeskipusersockfwmonitortcpdiagarpdroute6ip6_fwdnrtmsgtap%uspin_lockwri=
te_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
?<2>Bug in ip_route_input_slow(). Please, report
rt_cachert_cache_statspin_lockwrite_lockread_lockread_unlockinet_peer_cac=
hekernel BUG at %s:%d!
inetpeer.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
TcpExt:spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
TCPUDPICMPspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
ip_output.cspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
tcp_diag.ctcpdiag_init: Cannot create netlink =
socket.spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when =
retrnsmt   uid  timeout =
inodespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when =
retrnsmt   uid  timeout =
inodespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
0123456789ABCDEFIP address       HW type     Flags       HW address      =
      Mask     Device
00:00:00:00:00:00*arpipv4spin_lockwrite_lockread_lockread_unlockkernel =
BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
netconfallarp_filtertaglog_martiansbootp_relaymedium_idproxy_arpaccept_so=
urce_routesend_redirectsrp_filtershared_mediasecure_redirectsaccept_redir=
ectsmc_forwardingforwardingdefaultspin_lockwrite_lockread_lockread_unlock=
kernel BUG at %s:%d!
rawnetstatsnmpsockstattcpudpspin_lockwrite_lockread_lockread_unlockkernel=
 BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
ipfrag_secret_intervaltcp_low_latencytcp_frtotcp_tw_reuseicmp_ratemaskicm=
p_ratelimittcp_adv_win_scaletcp_app_wintcp_rmemtcp_wmemtcp_memtcp_dsacktc=
p_ecntcp_reorderingtcp_facktcp_orphan_retriesinet_peer_gc_maxtimeinet_pee=
r_gc_mintimeinet_peer_maxttlinet_peer_minttlinet_peer_thresholdrouteicmp_=
ignore_bogus_error_responsesicmp_echo_ignore_broadcastsicmp_echo_ignore_a=
llip_local_port_rangetcp_max_syn_backlogtcp_rfc1337tcp_stdurgtcp_abort_on=
_overflowtcp_tw_recycletcp_fin_timeouttcp_retries2tcp_retries1tcp_keepali=
ve_intvltcp_keepalive_probestcp_keepalive_timeipfrag_timeip_dynaddripfrag=
_low_threshipfrag_high_threshtcp_max_tw_bucketstcp_max_orphanstcp_synack_=
retriestcp_syn_retriesip_nonlocal_bindip_no_pmtu_discip_autoconfigip_defa=
ult_ttlip_forwardtcp_retrans_collapsetcp_sacktcp_window_scalingtcp_timest=
ampsspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
routespin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
%s      %08X %08X    %04X       %d    %u %d      %08X %d      %u   %u**  =
    %08X %08X    %04X       %d    %u %d      %08X %d      %u   =
%uspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
ip_fib_hashspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
net/unixspin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
/usr/src/linux-2.4.21/include/asm/highmem.h/usr/src/linux-2.4.21/include/=
linux/highmem.h/usr/src/linux-2.4.21/include/linux/netdevice.hspin_lockwr=
ite_lockread_lockread_unlockmax_dgram_qlenunixnetspin_lockwrite_lockread_=
lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockunknownkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockunknownschedqchildqdelayqRPC: %4d =
disabling timer
kernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockunknownkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlockunknownRPC: creating NULL =
authenticator for client %p
spin_lockwrite_lockread_lockread_unlockkernel BUG at %s:%d!
spin_lockwrite_lockread_lockread_unlocksvc: svc_authenticate (%d)
spin_lockunknownwrite_lockread_lockread_unlockRPC: %4d rpc_getport(%s, =
%d, %d, %d)
pmap_getpmap_unsetpmap_setpmap_nullportmapspin_lockunknownwrite_lockread_=
lockread_unlockspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockunknownspin_lockwrite_lockread_loc=
kread_unlockunknownnet %d %d %d %d
spin_lockwrite_lockread_lockread_unlockunknown%dnlm_debugnfsd_debugnfs_de=
bugrpc_debugsunrpcspin_lockwrite_lockread_lockread_unlockkernel BUG at =
%s:%d!
spin_lockwrite_lockread_lockread_unlockipv4ethernet802core0123456789abcde=
fghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ<NULL>spin_lockw=
rite_lockread_lockread_unlockspin_lock <5>This architecture does not =
implement dump_stack()
spin_lockwrite_lockread_lockread_unlockspin_lockPROMLIB: Bad PROM =
version %d
spin_lockwrite_lockread_lockread_unlockkeyboardnamedevice_typeserialstdin=
-pathdisplaystdout-pathspin_lockwrite_lockread_lockread_unlocknamereg@%x,=
%xspin_lockwrite_lockread_lockread_unlockspin_lockwrite_lockread_lockread=
_unlock%s(%p) CPU#%d stuck at %08lx, owner PC(%08lx):CPU(%lx)

1 warning issued.  Results may not be reliable.

</OOPS>

This Oops happens 70% times when system make a boot (during kernel =
starts), look messages_oops.txt and messages_ok.txt (30% of boot).

Linux:
-----
Linux sparc20 2.4.21 #1 SMP Tue Jul 1 14:24:20 CEST 2003 sparc Debian =
3.0r1

Utils:
-----
modutils: 2.4.15-1
gcc: gcc version 2.95.4 20011002 (Debian prerelease)
binutils: 2.12.90.0.1-4

- More -
--------

Config:
http://www.17perso.it/fbriata/oops1/config-2.4.21.txt

Dmesg:
http://www.17perso.it/fbriata/oops1/dmesg.txt

oops (one more time)
http://www.17perso.it/fbriata/oops1/ksymoops.txt

http://www.17perso.it/fbriata/oops1/ksymoops -t -a.txt=20

http://www.17perso.it/fbriata/oops1/messages_oops.txt

http://www.17perso.it/fbriata/oops1/messages_ok.txt

http://www.17perso.it/fbriata/oops1/cpuinfo.txt

http://www.17perso.it/fbriata/oops1/lsmod.txt

http://www.17perso.it/fbriata/oops1/cmdline.txt

http://www.17perso.it/fbriata/oops1/devices.txt

http://www.17perso.it/fbriata/oops1/scsi.txt

http://www.17perso.it/fbriata/oops1/esp0.txt

http://www.17perso.it/fbriata/oops1/interrupts.txt

--
Fred

