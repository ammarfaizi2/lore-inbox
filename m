Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSAWQUE>; Wed, 23 Jan 2002 11:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289895AbSAWQTz>; Wed, 23 Jan 2002 11:19:55 -0500
Received: from [194.158.195.131] ([194.158.195.131]:6017 "HELO ns1.4enet.by")
	by vger.kernel.org with SMTP id <S289790AbSAWQTl>;
	Wed, 23 Jan 2002 11:19:41 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Berjoza Roman <b_rom_s@4enet.by>
Reply-To: b_rom_s@4enet.by
To: linux-kernel@vger.kernel.org
Subject: reiserfs+updatedb=oops
Date: Wed, 23 Jan 2002 18:23:12 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123161944Z289790-13996+10616@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] One line summary of the problem:  
Kernel 2.4.x oops with reiserfs on kdeinit

[2.] Full description of the problem/report:
Oopses appears after updatedb scripts when loading KDE.
Updating/reinstalling kde, updating gcc, kernel, reiserfsprogs, recreating 
reiser fs doesn't change situation. Replacing sda - same effect.
Switching to ext2 - no oopses detected.
Same problem was found described in other mailing lists.

[5.] Output of Oops.. 
There is series of oops, it is first:

ksymoops 2.4.0 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol vg  , lvm-mod says d081a520, 
/lib/modules/2.4.17/kernel/drivers/md/lvm-mod.o says d081a180.  Ignoring 
/lib/modules/2.4.17/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d080e4a0, 
/lib/modules/2.4.17/kernel/drivers/md/md.o says d080e2c0.  Ignoring 
/lib/modules/2.4.17/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d080dca0, 
/lib/modules/2.4.17/kernel/drivers/md/md.o says d080dac0.  Ignoring 
/lib/modules/2.4.17/kernel/drivers/md/md.o entry
Jan 23 12:56:40 ns1 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000000
Jan 23 12:56:40 ns1 kernel: c013b148
Jan 23 12:56:40 ns1 kernel: *pde = 00000000
Jan 23 12:56:40 ns1 kernel: Oops: 0000
Jan 23 12:56:40 ns1 kernel: CPU:    0
Jan 23 12:56:40 ns1 kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
Jan 23 12:56:40 ns1 kernel: EFLAGS: 00010217
Jan 23 12:56:40 ns1 kernel: eax: cfe89ce8   ebx: fffffff0   ecx: 0000000f   
edx: 2a005bcc
Jan 23 12:56:40 ns1 kernel: esi: 00000000   edi: c2fbffa4   ebp: 00000000   
esp: c2fbff04
Jan 23 12:56:40 ns1 kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 12:56:40 ns1 kernel: Process kdeinit (pid: 3279, stackpage=c2fbf000)
Jan 23 12:56:40 ns1 kernel: Stack: c2fbff64 00000000 c2fbffa4 cae75680 
cfe89ce8 c9a8602c 2a005bcc 00000009
Jan 23 12:56:40 ns1 kernel:        c01333d4 caf2ecc0 c2fbff64 c2fbff64 
c0133a58 caf2ecc0 c2fbff64 00000000
Jan 23 12:56:40 ns1 kernel:        c9a86000 00000000 c2fbffa4 00000009 
c01331ed 00000009 c9a86035 00000000
Jan 23 12:56:40 ns1 kernel: Call Trace: [cached_lookup+16/84] 
[link_path_walk+1184/1752] [getname+93/156] [path_walk+26/28] 
[__user_walk+53/80]
Jan 23 12:56:40 ns1 kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 
24 24 39 43 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 74                     jne    80 <_EIP+0x80> 00000080 Before first 
symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first 
symbol


4 warnings issued.  Results may not be reliable.

[5] Environment:
Various 2.4 kernels
Various gcc
Various reiserfsprogs
Kde 2.1/2.2
/ type reiserfs on /dev/sda6
SuSE 7.1

- -----------
Roman Berjoza
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjxO44EACgkQk3HFzj6OGB3lvgCgloVEf8oud8UlJl9EdyL172vP
eNkAoJSTIU8aEiTe8//THzcmkVdVrThQ
=CQbt
-----END PGP SIGNATURE-----
