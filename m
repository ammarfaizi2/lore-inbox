Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312397AbSCYLOH>; Mon, 25 Mar 2002 06:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSCYLNo>; Mon, 25 Mar 2002 06:13:44 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:2833 "EHLO jubjub.wizard.com")
	by vger.kernel.org with ESMTP id <S312394AbSCYLNa>;
	Mon, 25 Mar 2002 06:13:30 -0500
Date: Mon, 25 Mar 2002 03:12:56 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with mount() - 2.5.7
Message-ID: <20020325111256.GA16099@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 3:03am  up 5 days, 11:20,  2 users,  load average: 0.07, 0.04, 0.04
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Next report in from me.. trying to mount a cd with ide-cd. my setup:

Tyan 2390B Mobo, VT82C686
1.1G Athlon

Linux bellicha 2.5.7 #3 Tue Mar 19 15:37:55 PST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.15
e2fsprogs              1.25
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nls_iso8859-1 parport_pc lp parport ppp_deflate 
zlib_deflate bsd_comp ppp_async snd-pcm-oss snd-mixer-oss snd-fm801 snd-pcm 
snd-mpu401-uart snd-rawmidi snd-opl3-lib snd-seq-device snd-hwdep snd-timer 
snd-ac97-codec snd soundcore ppp_generic slhc serial ide-cd sr_mod scsi_mod 
cdrom softdog ipt_LOG ipt_limit ipt_MASQUERADE ipt_state ip_nat_ftp 
ip_conntrack_ftp iptable_filter iptable_nat ip_conntrack ip_tables eepro100 
isofs zlib_inflate reiserfs unix


ksymoops 2.4.5 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000001
e118941e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e118941e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: fffffffb   ebx: c3bf7c90   ecx: df81b4b0   edx: 00000000
esi: c3bf7bd4   edi: 0000000a   ebp: c02f0e1c   esp: c3bf7bc4
ds: 0018   es: 0018   ss: 0018
Stack: c02f0e1c c3bf7c90 c3bf7c90 dfe966c0 c02f0e24 c02f0e24 00002000 00000000 
       00000000 00000000 00000000 00000420 ffffffff 00001600 00000001 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 c3bf7c90 00000000 
Call Trace: [<c01277a2>] [<c0127d47>] [<c0107160>] [<e1189b8c>] [<e118a729>] 
   [<e118e840>] [<c015219c>] [<c0153200>] [<e1166532>] [<e1166446>] [<e118b58d>] 
   [<c01bd8e4>] [<c013f750>] [<c013f8b8>] [<c013e51c>] [<e10fbb00>] [<e10fbb00>] 
   [<e10f80ef>] [<e10fbb00>] [<e10f6fb0>] [<c013e820>] [<e10fbb00>] [<c014fe79>] 
   [<c0150160>] [<c014ff9d>] [<c0150584>] [<c0107077>] 
Code: 0f be 42 01 50 0f be 02 50 8d 85 38 01 00 00 50 68 00 e1 18 


>>EIP; e118941e <[ide-cd]cdrom_queue_packet_command+5e/f0>   <=====

>>eax; fffffffb <END_OF_CODE+1ede4df4/????>
>>ebx; c3bf7c90 <_end+38fd3ac/2051d71c>
>>ecx; df81b4b0 <_end+1f520bcc/2051d71c>
>>esi; c3bf7bd4 <_end+38fd2f0/2051d71c>
>>ebp; c02f0e1c <ide_hwifs+63c/3bb0>
>>esp; c3bf7bc4 <_end+38fd2e0/2051d71c>

Trace; c01277a2 <__vma_link+62/b0>
Trace; c0127d47 <do_mmap_pgoff+417/4f0>
Trace; c0107160 <error_code+34/40>
Trace; e1189b8c <[ide-cd]cdrom_eject+7c/90>
Trace; e118a729 <[ide-cd]ide_cdrom_tray_move+39/50>
Trace; e118e840 <[ide-cd]ide_cdrom_dops+0/40>
Trace; c015219c <padzero+1c/20>
Trace; c0153200 <load_elf_binary+950/ab0>
Trace; e1166532 <[cdrom]open_for_data+a2/2d0>
Trace; e1166446 <[cdrom]cdrom_open+86/d0>
Trace; e118b58d <[ide-cd]ide_cdrom_open+4d/70>
Trace; c01bd8e4 <ide_open+b4/d0>
Trace; c013f750 <do_open+a0/1a0>
Trace; c013f8b8 <blkdev_get+68/80>
Trace; c013e51c <get_sb_bdev+fc/270>
Trace; e10fbb00 <[isofs]iso9660_fs_type+0/20>
Trace; e10fbb00 <[isofs]iso9660_fs_type+0/20>
Trace; e10f80ef <[isofs]isofs_get_sb+1f/30>
Trace; e10fbb00 <[isofs]iso9660_fs_type+0/20>
Trace; e10f6fb0 <[isofs]isofs_fill_super+0/5f0>
Trace; c013e820 <do_kern_mount+50/d0>
Trace; e10fbb00 <[isofs]iso9660_fs_type+0/20>
Trace; c014fe79 <do_add_mount+69/140>
Trace; c0150160 <do_mount+170/190>
Trace; c014ff9d <copy_mount_options+4d/a0>
Trace; c0150584 <sys_mount+a4/110>
Trace; c0107077 <syscall_call+7/b>

Code;  e118941e <[ide-cd]cdrom_queue_packet_command+5e/f0>
0000000000000000 <_EIP>:
Code;  e118941e <[ide-cd]cdrom_queue_packet_command+5e/f0>   <=====
   0:   0f be 42 01               movsbl 0x1(%edx),%eax   <=====
Code;  e1189422 <[ide-cd]cdrom_queue_packet_command+62/f0>
   4:   50                        push   %eax
Code;  e1189423 <[ide-cd]cdrom_queue_packet_command+63/f0>
   5:   0f be 02                  movsbl (%edx),%eax
Code;  e1189426 <[ide-cd]cdrom_queue_packet_command+66/f0>
   8:   50                        push   %eax
Code;  e1189427 <[ide-cd]cdrom_queue_packet_command+67/f0>
   9:   8d 85 38 01 00 00         lea    0x138(%ebp),%eax
Code;  e118942d <[ide-cd]cdrom_queue_packet_command+6d/f0>
   f:   50                        push   %eax
Code;  e118942e <[ide-cd]cdrom_queue_packet_command+6e/f0>
  10:   68 00 e1 18 00            push   $0x18e100


2 warnings issued.  Results may not be reliable.
 
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

