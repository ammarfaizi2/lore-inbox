Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136490AbRAMF1R>; Sat, 13 Jan 2001 00:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136552AbRAMF05>; Sat, 13 Jan 2001 00:26:57 -0500
Received: from mail.etang.com ([202.101.42.207]:8103 "HELO mail.etang.com")
	by vger.kernel.org with SMTP id <S136490AbRAMF0z>;
	Sat, 13 Jan 2001 00:26:55 -0500
Date: Sat, 13 Jan 2001 13:25:55 -0800
From: hugang <linuxhappy@etang.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0+reiserfs+lvm oops
Message-Id: <20010113132555.4f9ba7bd.linuxhappy@etang.com>
X-Mailer: Sylpheed version 0.4.52pre2 (GTK+ 1.2.8; Linux 2.4.1-pre2; i686)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all.
-----------------------------------------------------------------------------
	ksymoops 2.3.4 on i686 2.4.0-prerelease.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-prerelease/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 702d3042
c4919998
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c4919998>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 702d302e   ebx: c28afc68   ecx: ffffffe4   edx: 00000000
esi: c060a000   edi: c060a07c   ebp: 00000004   esp: c28afb68
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 954, stackpage=c28af000)
Stack: c060a000 c060a07c 00000000 ffffffe4 00000060 00000000 c3df38a0 c1d02018 
       c28afc68 000003b0 00000000 00000000 c491bc33 c28afc68 00000000 c28afc68 
       00000000 c28afc68 00000000 c060a000 00000000 00000000 c28afc68 00000130 
Call Trace: [<c491bc33>] [<c491c555>] [<c4925dec>] [<c4934930>] [<c49263ae>] [<c4947044>] [<c49182d4>] 
       [<c492f244>] [<c493382f>] [<c4919011>] [<c491915c>] [<c492f384>] [<c493382f>] [<c0130456>] [<c012f5b5>] 
       [<c012f603>] [<c0108f47>] [<c010002b>] 
Code: 8b 40 14 ff d0 89 c2 8b 06 83 c4 10 01 c2 89 16 8b 83 8c 01 

>>EIP; c4919998 <[reiserfs]create_virtual_node+298/490>   <=====
Trace; c491bc33 <[reiserfs]dc_check_balance_leaf+53/150>
Trace; c491c555 <[reiserfs]fix_nodes+115/450>
Trace; c4925dec <[reiserfs]reiserfs_cut_from_item+1fc/430>
Trace; c4934930 <[reiserfs]reiserfs_mounted_fs_count+0/4>
Trace; c49263ae <[reiserfs]reiserfs_do_truncate+32e/470>
Trace; c4947044 <.data.end+128d/???
Trace; c49182d4 <[reiserfs]reiserfs_truncate_file+b4/1a0>
Trace; c492f244 <[reiserfs].rodata.start+1184/654e>
Trace; c493382f <[reiserfs].rodata.start+576f/654e>
Trace; c4919011 <[reiserfs]reiserfs_file_release+1b1/320>
Trace; c491915c <[reiserfs]reiserfs_file_release+2fc/320>
Trace; c492f384 <[reiserfs].rodata.start+12c4/654e>
Trace; c493382f <[reiserfs].rodata.start+576f/654e>
Trace; c0130456 <fput+36/d0>
Trace; c012f5b5 <filp_close+55/60>
Trace; c012f603 <sys_close+43/50>
Trace; c0108f47 <system_call+33/38>
Trace; c010002b <startup_32+2b/139>
Code;  c4919998 <[reiserfs]create_virtual_node+298/490>
00000000 <_EIP>:
Code;  c4919998 <[reiserfs]create_virtual_node+298/490>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c491999b <[reiserfs]create_virtual_node+29b/490>
   3:   ff d0                     call   *%eax
Code;  c491999d <[reiserfs]create_virtual_node+29d/490>
   5:   89 c2                     mov    %eax,%edx
Code;  c491999f <[reiserfs]create_virtual_node+29f/490>
   7:   8b 06                     mov    (%esi),%eax
Code;  c49199a1 <[reiserfs]create_virtual_node+2a1/490>
   9:   83 c4 10                  add    $0x10,%esp
Code;  c49199a4 <[reiserfs]create_virtual_node+2a4/490>
   c:   01 c2                     add    %eax,%edx.
Code;  c49199a6 <[reiserfs]create_virtual_node+2a6/490>
   e:   89 16                     mov    %edx,(%esi)
Code;  c49199a8 <[reiserfs]create_virtual_node+2a8/490>
  10:   8b 83 8c 01 00 00         mov    0x18c(%ebx),%eax


1 warning issued.  Results may not be reliable.

-------------------------------------------------------------------------------
I thinks the bug in fs/reiserfs/fix_node.c,line 181. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
