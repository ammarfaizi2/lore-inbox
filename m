Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275210AbRIZOIa>; Wed, 26 Sep 2001 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275212AbRIZOIT>; Wed, 26 Sep 2001 10:08:19 -0400
Received: from dspecialists.de ([195.143.27.194]:519 "EHLO
	dedsp.dspecialists.de") by vger.kernel.org with ESMTP
	id <S275209AbRIZOIL>; Wed, 26 Sep 2001 10:08:11 -0400
Subject: Ooops in 2.2.19
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OFD81D9B56.7EF46A96-ONC1256AD3.004D7E42@dspecialists.de>
From: stefan.altenkamp@dspecialists.de
Date: Wed, 26 Sep 2001 16:08:29 +0200
X-MIMETrack: Serialize by Router on lotus/dspecialists(Release 5.0.3 (Intl)|21 March
 2000) at 26/09/2001 04:08:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,
I'm running 2.2.19 on a P5 133.
>From time to time I'm getting this oops, which seems to kill network
functionality, but doesn't lead to a reboot.

Any ideas ?

Stefan


ksymoops 2.4.3 on i586 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module 3c59x is in lsmod but not in ksyms,
probably no symbols exported
Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
proc_sys_root_R__ver_proc_sys_root not found in System.map.  Ignoring
ksyms_base entry
Sep 26 00:02:05 dedsp kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Sep 26 00:02:05 dedsp kernel: current->tss.cr3 = 00e13000, %cr3 = 00e13000
Sep 26 00:02:05 dedsp kernel: *pde = 02c6e067
Sep 26 00:02:05 dedsp kernel: Oops: 0002
Sep 26 00:02:05 dedsp kernel: CPU:    0
Sep 26 00:02:05 dedsp kernel: EIP:    0010:[kfree+403/424]
Sep 26 00:02:05 dedsp kernel: EFLAGS: 00010286
Sep 26 00:02:05 dedsp kernel: eax: 0000001b   ebx: c3fff620   ecx: 00000018
edx: 00000023
Sep 26 00:02:05 dedsp kernel: esi: c22ab920   edi: 00000542   ebp: 00000000
esp: c37c7e54
Sep 26 00:02:05 dedsp kernel: ds: 0018   es: 0018   ss: 0018
Sep 26 00:02:05 dedsp kernel: Process slocate (pid: 4909, process nr: 38,
stackpage=c37c7000)
Sep 26 00:02:05 dedsp kernel: Stack: c22ab900 c34cb4a0 00000542 00000000
c22ab700 c34cb4a0 c01311f4 c22ab920
Sep 26 00:02:05 dedsp kernel:        c37c7eb4 c37c7eb4 c022c084 00000542
00000542 c013218b fffff709 0000015c
Sep 26 00:02:05 dedsp kernel:        00000000 c0253038 c022c084 c0253038
c0145b3f c01f8480 c249b880 c26ae018
Sep 26 00:02:05 dedsp kernel: Call Trace: [prune_dcache+260/340]
[try_to_free_inodes+199/264] [ext2_find_entry+455/752] [cprt+9280/56342]
[grow_inodes+30/384] [get_new_inode
Sep 26 00:02:05 dedsp kernel: Code: c7 05 00 00 00 00 00 00 00 00 83 c4 08
5b 5e 5f 5d 83 c4 08
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0
Code;  00000006 Before first symbol
   7:   00 00 00
Code;  0000000a Before first symbol
   a:   83 c4 08                  addl   $0x8,%esp
Code;  0000000c Before first symbol
   d:   5b                        popl   %ebx
Code;  0000000e Before first symbol
   e:   5e                        popl   %esi
Code;  0000000e Before first symbol
   f:   5f                        popl   %edi
Code;  00000010 Before first symbol
  10:   5d                        popl   %ebp
Code;  00000010 Before first symbol
  11:   83 c4 08                  addl   $0x8,%esp


4 warnings issued.  Results may not be reliable.




