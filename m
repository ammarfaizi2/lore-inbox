Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTFVRQx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 13:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbTFVRQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 13:16:53 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:40198 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP id S264762AbTFVRQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 13:16:46 -0400
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: 2.4.21 reiserfs oops
From: Nix <nix@esperi.demon.co.uk>
X-Emacs: Lovecraft was an optimist.
Date: Sun, 22 Jun 2003 15:00:20 +0100
Message-ID: <87he6iyzyj.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An nnrpd just oopsed and took the news filesystem (the only reiserfs fs
on this box) down with it (everything touching it D-states).

Oops:

ksymoops 2.4.6 on i586 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map (specified)

Jun 22 13:52:42 loki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 
Jun 22 13:52:42 loki kernel: c0092df4 
Jun 22 13:52:42 loki kernel: c0092df4 
Jun 22 13:52:42 loki kernel: *pde = 00000000 
Jun 22 13:52:43 loki kernel: Oops: 0000 
Jun 22 13:52:43 loki kernel: Oops: 0000 
Jun 22 13:52:43 loki kernel: CPU:    0 
Jun 22 13:52:43 loki kernel: CPU:    0 
Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 
Jun 22 13:52:43 loki kernel: EFLAGS: 00010246 
Jun 22 13:52:43 loki kernel: EFLAGS: 00010246 
Jun 22 13:52:43 loki kernel: eax: 00000001   ebx: 00000064   ecx: 00000000   edx: 00000001 
Jun 22 13:52:43 loki kernel: eax: 00000001   ebx: 00000064   ecx: 00000000   edx: 00000001 
Jun 22 13:52:43 loki kernel: esi: c1527b28   edi: c7381ea0   ebp: ffffffff   esp: c1527ae4 
Jun 22 13:52:43 loki kernel: esi: c1527b28   edi: c7381ea0   ebp: ffffffff   esp: c1527ae4 
Jun 22 13:52:43 loki kernel: ds: 0018   es: 0018   ss: 0018 
Jun 22 13:52:43 loki kernel: ds: 0018   es: 0018   ss: 0018 
Jun 22 13:52:43 loki kernel: Process nnrpd (pid: 1993, stackpage=c1527000) 
Jun 22 13:52:43 loki kernel: Process nnrpd (pid: 1993, stackpage=c1527000) 
Jun 22 13:52:43 loki kernel: Stack: c01a1c02 c1527b28 00000064 c1527c7c 00000000 c7381ea0 c019044b c1527b28  
Jun 22 13:52:43 loki kernel: Stack: c01a1c02 c1527b28 00000064 c1527c7c 00000000 c7381ea0 c019044b c1527b28  
Jun 22 13:52:43 loki kernel:        00000000 00000000 00000001 ffffffff c1527c7c 00000064 00000000 c1527c38  
Jun 22 13:52:43 loki kernel:        00000000 00000000 00000001 ffffffff c1527c7c 00000064 00000000 c1527c38  
Jun 22 13:52:43 loki kernel:        00000000 c1527c7c c7381ea0 c23af7a0 00000008 c01907a0 c1527c7c 00000064  
Jun 22 13:52:43 loki kernel:        00000000 c1527c7c c7381ea0 c23af7a0 00000008 c01907a0 c1527c7c 00000064  
Jun 22 13:52:43 loki kernel: Call Trace:    [<c01a1c02>] [<c019044b>] [<c01907a0>] [<c019bdec>] [<c019c59d>] 
Jun 22 13:52:43 loki kernel: Call Trace:    [<c01a1c02>] [<c019044b>] [<c01907a0>] [<c019bdec>] [<c019c59d>] 
Jun 22 13:52:43 loki kernel:   [<c019c799>] [<c0193150>] [<c01a6bdf>] [<c01a6f7b>] [<c01a72f9>] [<c01a67db>] 
Jun 22 13:52:43 loki kernel:   [<c019c799>] [<c0193150>] [<c01a6bdf>] [<c01a6f7b>] [<c01a72f9>] [<c01a67db>] 
Jun 22 13:52:43 loki kernel:   [<c01954ee>] [<c01954a0>] [<c0140d93>] [<c013e996>] [<c012f104>] [<c012e135>] 
Jun 22 13:52:43 loki kernel:   [<c01954ee>] [<c01954a0>] [<c0140d93>] [<c013e996>] [<c012f104>] [<c012e135>] 
Jun 22 13:52:43 loki kernel:   [<c0114ec8>] [<c0115467>] [<c011561f>] [<c0106c23>] 
Jun 22 13:52:44 loki kernel:   [<c0114ec8>] [<c0115467>] [<c011561f>] [<c0106c23>] 
Jun 22 13:52:44 loki kernel: Code: 0b 08 00 00 19 00 00 00 53 b0 2f 00 00 00 00 00 00 00 00 00  


>>EIP; c0092df4 Before first symbol   <=====
>>EIP; c0092df4 Before first symbol   <=====

>>esi; c1527b28 <_end+11e54e4/8512a1c>
>>edi; c7381ea0 <_end+703f85c/8512a1c>
>>esp; c1527ae4 <_end+11e54a0/8512a1c>
>>esi; c1527b28 <_end+11e54e4/8512a1c>
>>edi; c7381ea0 <_end+703f85c/8512a1c>
>>esp; c1527ae4 <_end+11e54a0/8512a1c>

Trace; c01a1c02 <leaf_delete_items+3e/158>
Trace; c019044b <balance_leaf_when_delete+6b/37c>
Trace; c01907a0 <balance_leaf+44/2698>
Trace; c019bdec <dc_check_balance_internal+2c8/568>
Trace; c019c59d <clear_all_dirty_bits+11/18>
Trace; c01a1c02 <leaf_delete_items+3e/158>
Trace; c019044b <balance_leaf_when_delete+6b/37c>
Trace; c01907a0 <balance_leaf+44/2698>
Trace; c019bdec <dc_check_balance_internal+2c8/568>
Trace; c019c59d <clear_all_dirty_bits+11/18>
Trace; c019c799 <wait_tb_buffers_until_unlocked+1f5/2a4>
Trace; c0193150 <do_balance+84/fc>
Trace; c01a6bdf <reiserfs_cut_from_item+97/45c>
Trace; c01a6f7b <reiserfs_cut_from_item+433/45c>
Trace; c01a72f9 <reiserfs_do_truncate+2fd/430>
Trace; c01a67db <reiserfs_delete_object+23/50>
Trace; c019c799 <wait_tb_buffers_until_unlocked+1f5/2a4>
Trace; c0193150 <do_balance+84/fc>
Trace; c01a6bdf <reiserfs_cut_from_item+97/45c>
Trace; c01a6f7b <reiserfs_cut_from_item+433/45c>
Trace; c01a72f9 <reiserfs_do_truncate+2fd/430>
Trace; c01a67db <reiserfs_delete_object+23/50>
Trace; c01954ee <reiserfs_delete_inode+4e/98>
Trace; c01954a0 <reiserfs_delete_inode+0/98>
Trace; c0140d93 <iput+113/208>
Trace; c013e996 <dput+e6/144>
Trace; c012f104 <fput+bc/e0>
Trace; c012e135 <filp_close+59/64>
Trace; c01954ee <reiserfs_delete_inode+4e/98>
Trace; c01954a0 <reiserfs_delete_inode+0/98>
Trace; c0140d93 <iput+113/208>
Trace; c013e996 <dput+e6/144>
Trace; c012f104 <fput+bc/e0>
Trace; c012e135 <filp_close+59/64>
Trace; c0114ec8 <put_files_struct+54/bc>
Trace; c0115467 <do_exit+af/240>
Trace; c011561f <sys_exit+f/10>
Trace; c0106c23 <system_call+33/40>
Trace; c0114ec8 <put_files_struct+54/bc>
Trace; c0115467 <do_exit+af/240>
Trace; c011561f <sys_exit+f/10>
Trace; c0106c23 <system_call+33/40>

Code;  c0092df4 Before first symbol
00000000 <_EIP>:
Code;  c0092df4 Before first symbol   <=====
   0:   0b 08                     or     (%eax),%ecx   <=====
Code;  c0092df6 Before first symbol
   2:   00 00                     add    %al,(%eax)
Code;  c0092df8 Before first symbol
   4:   19 00                     sbb    %eax,(%eax)
Code;  c0092dfa Before first symbol
   6:   00 00                     add    %al,(%eax)
Code;  c0092dfc Before first symbol
   8:   53                        push   %ebx
Code;  c0092dfd Before first symbol
   9:   b0 2f                     mov    $0x2f,%al

Jun 22 13:52:44 loki kernel: Code: 0b 08 00 00 19 00 00 00 53 b0 2f 00 00 00 00 00 00 00 00 00  


Code;  c0092df4 Before first symbol
00000000 <_EIP>:
Code;  c0092df4 Before first symbol
   0:   0b 08                     or     (%eax),%ecx
Code;  c0092df6 Before first symbol
   2:   00 00                     add    %al,(%eax)
Code;  c0092df8 Before first symbol
   4:   19 00                     sbb    %eax,(%eax)
Code;  c0092dfa Before first symbol
   6:   00 00                     add    %al,(%eax)
Code;  c0092dfc Before first symbol
   8:   53                        push   %ebx
Code;  c0092dfd Before first symbol
   9:   b0 2f                     mov    $0x2f,%al


Modules:

Module                  Size  Used by    Not tainted
opl3                   11040   0 (unused)
sb                      7348   0
sb_lib                 32334   0 [sb]
uart401                 6020   0 [sb_lib]
sound                  51692   0 [opl3 sb_lib uart401]
nls_iso8859-1           2844   1 (autoclean)
nls_cp437               4348   1 (autoclean)


.config:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=10
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_PLIP=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_YM3812=m
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

-- 
`It is an unfortunate coincidence that the date locarchive.h was
 written (in hex) matches Ritchie's birthday (in octal).'
               -- Roland McGrath on the libc-alpha list
