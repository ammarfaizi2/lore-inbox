Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbRFXHv5>; Sun, 24 Jun 2001 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbRFXHvr>; Sun, 24 Jun 2001 03:51:47 -0400
Received: from [203.36.158.121] ([203.36.158.121]:4364 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S263793AbRFXHvi>; Sun, 24 Jun 2001 03:51:38 -0400
Date: Sun, 24 Jun 2001 17:51:39 +1000
From: Daniel Stone <daniel@sfarc.net>
To: linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [OOPS] XFS in large Maildir
Message-ID: <20010624175139.A19220@kabuki.sfarc.net>
Mail-Followup-To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi guys,
I've attached the ksymoops output from Linux 2.4.6-pre3-xfs (CVS tree from
some point). I'll try an update now, but when I try to access stuff in
~/Maildir/netfilter/cur (~7k files in it), XFS just OOPSes. The OOPS I
attached was from mutt, but it also successfully hangs ls, so I doubt it's a
mutt bug.

:) d

-- 
Daniel Stone						     <daniel@sfarc.net>
<Nuke> "can NE1 help me aim nuclear weaponz????? /MSG ME!!"

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops2

ksymoops 2.4.1 on i586 2.4.6-pre3-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-pre3-xfs/ (default)
     -m /boot/System.map-2.4.6-pre3-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Error (regular_file): read_system_map stat /boot/System.map-2.4.6-pre3-xfs failed
Unable to handle kernel paging request at virtual address e5a8b460
c01a7a0b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a7a0b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: e5a8b440   ebx: 224d7000   ecx: c5a8b440   edx: c5c7d9c0
esi: c5a8c1e0   edi: e5a8b440   ebp: c467ba9c   esp: c467ba98
ds: 0018   es: 0018   ss: 0018
Process mutt (pid: 7299, stackpage=c467b000)
Stack: c45bd7e0 c467bab8 c01a3f11 c5c7d9c0 e5a8b440 00000000 c467bcc4 c5a8d0c0
       c467bc70 c01a3d10 c5a8c1e0 c5a8b440 c467badc 00000000 c467bcc4 c5a8d0c0
       c01c3052 c589a470 c589a470 22508000 00000000 00001000 c467bb00 c589a550
Call Trace: [<c01a3f11>] [<e5a8b440>] [<c01a3d10>] [<c01c3052>] [<c01a3c4f>] [<c01a4722>] [<c020b840>]
       [<c01a3f67>] [<c01a7bca>] [<c01cfd10>] [<c01a4079>] [<c01a7c50>] [<c01a7c68>] [<c01a46fa>] [<c01f78e0>]
       [<c01e45d3>] [<c01e5643>] [<c01e36c9>] [<c01e3aa6>] [<c01f8baa>] [<c01fd1d1>] [<c020592e>] [<c01367a8>]
       [<c0136e6d>] [<c01375db>] [<c012c49e>] [<c012c7a6>] [<c0106b13>]
Code: 8b 48 20 8b 52 24 8b 40 24 39 cb 75 0c 39 c2 75 08 8d 74 26

>>EIP; c01a7a0b <pagebuf_generic_file_write+703/9a4>   <=====
Trace; c01a3f11 <load_nls_default+255f5/25d2c>
Trace; e5a8b440 <END_OF_CODE+256aa9ec/????>
Trace; c01a3d10 <load_nls_default+253f4/25d2c>
Trace; c01c3052 <pagebuf_unlock+1b212/63390>
Trace; c01a3c4f <load_nls_default+25333/25d2c>
Trace; c01a4722 <pagebuf_get+9e/134>
Trace; c020b840 <kmem_zone_alloc+38/8c>
Trace; c01a3f67 <load_nls_default+2564b/25d2c>
Trace; c01a7bca <pagebuf_generic_file_write+8c2/9a4>
Trace; c01cfd10 <pagebuf_unlock+27ed0/63390>
Trace; c01a4079 <load_nls_default+2575d/25d2c>
Trace; c01a7c50 <pagebuf_generic_file_write+948/9a4>
Trace; c01a7c68 <pagebuf_generic_file_write+960/9a4>
Trace; c01a46fa <pagebuf_get+76/134>
Trace; c01f78e0 <pagebuf_unlock+4faa0/63390>
Trace; c01e45d3 <pagebuf_unlock+3c793/63390>
Trace; c01e5643 <pagebuf_unlock+3d803/63390>
Trace; c01e36c9 <pagebuf_unlock+3b889/63390>
Trace; c01e3aa6 <pagebuf_unlock+3bc66/63390>
Trace; c01f8baa <pagebuf_unlock+50d6a/63390>
Trace; c01fd1d1 <pagebuf_unlock+55391/63390>
Trace; c020592e <pagebuf_unlock+5daee/63390>
Trace; c01367a8 <path_release+dc/150>
Trace; c0136e6d <path_walk+541/8bc>
Trace; c01375db <vfs_create+14f/65c>
Trace; c012c49e <filp_open+32/50>
Trace; c012c7a6 <get_unused_fd+1a2/244>
Trace; c0106b13 <__up_wakeup+102b/23dc>
Code;  c01a7a0b <pagebuf_generic_file_write+703/9a4>
0000000000000000 <_EIP>:
Code;  c01a7a0b <pagebuf_generic_file_write+703/9a4>   <=====
   0:   8b 48 20                  mov    0x20(%eax),%ecx   <=====
Code;  c01a7a0e <pagebuf_generic_file_write+706/9a4>
   3:   8b 52 24                  mov    0x24(%edx),%edx
Code;  c01a7a11 <pagebuf_generic_file_write+709/9a4>
   6:   8b 40 24                  mov    0x24(%eax),%eax
Code;  c01a7a14 <pagebuf_generic_file_write+70c/9a4>
   9:   39 cb                     cmp    %ecx,%ebx
Code;  c01a7a16 <pagebuf_generic_file_write+70e/9a4>
   b:   75 0c                     jne    19 <_EIP+0x19> c01a7a24 <pagebuf_generic_file_write+71c/9a4>
Code;  c01a7a18 <pagebuf_generic_file_write+710/9a4>
   d:   39 c2                     cmp    %eax,%edx
Code;  c01a7a1a <pagebuf_generic_file_write+712/9a4>
   f:   75 08                     jne    19 <_EIP+0x19> c01a7a24 <pagebuf_generic_file_write+71c/9a4>
Code;  c01a7a1c <pagebuf_generic_file_write+714/9a4>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi


2 warnings and 1 error issued.  Results may not be reliable.

--YiEDa0DAkWCtVeE4--
