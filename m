Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbTIOMsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbTIOMsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:48:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261327AbTIOMsL (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 15 Sep 2003 08:48:11 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linux Kernel <linux-kernel@vger.redhat.com>
Subject: Re: Oops on 2.4.22 when mounting from broken NFS server
Date: Mon, 15 Sep 2003 22:47:20 +1000
User-Agent: KMail/1.5.3
References: <200309131938.40177.russell@coker.com.au>
In-Reply-To: <200309131938.40177.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YTbZ/W0fHPH1wew"
Message-Id: <200309152247.20462.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YTbZ/W0fHPH1wew
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 13 Sep 2003 19:38, Russell Coker wrote:
> Attached is the output of ksymoops from an Oops when mounting from a broken
> NFS server.  I was experimenting with a new security policy for the NFS
> server and didn't grant the daemons all the access they needed.  Afterwards
> I noticed that kernel had Oops'd on a mount command (I should have
> suspected when the mount SEGV'd).
>
> I can probably reproduce this if requested.  It's 2.4.22 client and server.

This is embarassing.  I attached the wrong file to the last message.  Attached 
is the correct one.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YTbZ/W0fHPH1wew
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops"

ksymoops 2.4.8 on i586 2.4.22-cobalt.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-cobalt/ (default)
     -m /boot/System.map-2.4.22-cobalt (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
d88891ee
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d88891ee>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c1425348   edx: c1425350
esi: c69958a0   edi: d88b5940   ebp: d88b59c0   esp: c9787da4
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 8396, stackpage=c9787000)
Stack: c7f9a4f0 d88a98ee 00000000 c15b9e60 00000286 c9787ed0 00000000 c0129fe7 
       c14255d0 00000286 d7981ec0 c01df4ab c7f9a410 00000002 00000001 c9787e84 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:    [<d88a98ee>] [<c0129fe7>] [<c01df4ab>] [<c013730a>] [<d88b7c50>]
  [<d88b7c50>] [<d88b7c50>] [<c01375f7>] [<d88b7c50>] [<c01377e0>] [<d88b7c50>]
  [<c0148cf8>] [<c0148fd2>] [<c0148e36>] [<c0149394>] [<c0107203>]
Code: 8b 03 85 c0 74 29 f6 05 2c 89 89 d8 02 75 29 80 63 20 3f 53 


>>EIP; d88891ee <[sunrpc]rpc_shutdown_client+e/80>   <=====

>>ecx; c1425348 <_end+11492f8/1853f010>
>>edx; c1425350 <_end+1149300/1853f010>
>>esi; c69958a0 <_end+66b9850/1853f010>
>>edi; d88b5940 <[nfs].rodata.end+659/2599>
>>ebp; d88b59c0 <[nfs].rodata.end+6d9/2599>
>>esp; c9787da4 <_end+94abd54/1853f010>

Trace; d88a98ee <[nfs]nfs_read_super+42e/960>
Trace; c0129fe7 <kfree+27/40>
Trace; c01df4ab <kfree_skbmem+b/60>
Trace; c013730a <get_anon_super+8a/e0>
Trace; d88b7c50 <[nfs]nfs_fs_type+0/30>
Trace; d88b7c50 <[nfs]nfs_fs_type+0/30>
Trace; d88b7c50 <[nfs]nfs_fs_type+0/30>
Trace; c01375f7 <get_sb_nodev+37/80>
Trace; d88b7c50 <[nfs]nfs_fs_type+0/30>
Trace; c01377e0 <do_kern_mount+100/140>
Trace; d88b7c50 <[nfs]nfs_fs_type+0/30>
Trace; c0148cf8 <do_add_mount+58/140>
Trace; c0148fd2 <do_mount+132/180>
Trace; c0148e36 <copy_mount_options+56/c0>
Trace; c0149394 <sys_mount+74/c0>
Trace; c0107203 <system_call+33/40>

Code;  d88891ee <[sunrpc]rpc_shutdown_client+e/80>
00000000 <_EIP>:
Code;  d88891ee <[sunrpc]rpc_shutdown_client+e/80>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  d88891f0 <[sunrpc]rpc_shutdown_client+10/80>
   2:   85 c0                     test   %eax,%eax
Code;  d88891f2 <[sunrpc]rpc_shutdown_client+12/80>
   4:   74 29                     je     2f <_EIP+0x2f>
Code;  d88891f4 <[sunrpc]rpc_shutdown_client+14/80>
   6:   f6 05 2c 89 89 d8 02      testb  $0x2,0xd889892c
Code;  d88891fb <[sunrpc]rpc_shutdown_client+1b/80>
   d:   75 29                     jne    38 <_EIP+0x38>
Code;  d88891fd <[sunrpc]rpc_shutdown_client+1d/80>
   f:   80 63 20 3f               andb   $0x3f,0x20(%ebx)
Code;  d8889201 <[sunrpc]rpc_shutdown_client+21/80>
  13:   53                        push   %ebx


1 warning issued.  Results may not be reliable.

--Boundary-00=_YTbZ/W0fHPH1wew--

