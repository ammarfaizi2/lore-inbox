Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271599AbRIBJyU>; Sun, 2 Sep 2001 05:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271600AbRIBJyB>; Sun, 2 Sep 2001 05:54:01 -0400
Received: from mustard.heime.net ([194.234.65.222]:28596 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271599AbRIBJxu>; Sun, 2 Sep 2001 05:53:50 -0400
Message-Id: <200109020953.LAA02862@mustard.heime.net>
Date: Sun, 02 Sep 2001 09:53:59 +0000
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Reply-To: roy@karlsbakk.net
To: J.A.K.Mouw@ITS.TUDelft.NL, roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org, lars@snart.com
X-Mailer: phpGroupWare (http://www.phpgroupware.org)
Subject: Re: 2.4.6 error
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I have a bad system map file, so I'll try to make a new kernel. Anyway 
- if anyone's interested, I got the following output from ksymopps

roy

www:~/bugs># cat sadc-oops | ksymoops -m /boot/System.map-2.4.6
ksymoops 2.4.2 on i586 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not 
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol hotplug_path_R__ver_hotplug_path not found 
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol nfsd_linkage_R__ver_nfsd_linkage not found 
in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address c9049180
c9049180
*pde = 07f8b067
Oops: 0000
CPU:    0
EIP:    0010:[<c9049180>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c5e47f68   ebx: c0eb37a0   ecx: c0eb37c0   edx: c9049180
esi: 00000400   edi: 00000000   ebp: c7d0f000   esp: c5e47f40
ds: 0018   es: 0018   ss: 0018
Process sadc (pid: 13746, stackpage=c5e47000)
Stack: c0149fcd c7d0f000 c5e47f68 00000000 00000400 c5e47f64 c90500e0 c7f7b8c0
       00000000 00000000 00000000 c0eb37a0 ffffffea 00000000 00000400 c012ea28
       c0eb37a0 4001a000 00000400 c0eb37c0 00000000 00001000 00000003 00000022
Call Trace: [<c0149fcd>] [<c012ea28>] [<c0106d43>]
Code:  Bad EIP value.

>>EIP; c9049180 <_end+8d5bcb0/8d64b30>   <=====
Trace; c0149fcc <proc_file_read+bc/1a0>
Trace; c012ea28 <sys_read+98/d0>
Trace; c0106d42 <system_call+32/40>


3 warnings issued.  Results may not be reliable.
