Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbTC1QJv>; Fri, 28 Mar 2003 11:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbTC1QJv>; Fri, 28 Mar 2003 11:09:51 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:12492 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263032AbTC1QJs>; Fri, 28 Mar 2003 11:09:48 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at highmem.c:159! bugreport
Date: Fri, 28 Mar 2003 17:21:02 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uZHh+N+0MUVj9YG"
Message-Id: <200303281721.02949.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_uZHh+N+0MUVj9YG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attached you can find  an oops processed trough ksymmoops


Bernd


--Boundary-00=_uZHh+N+0MUVj9YG
Content-Type: text/plain;
  charset="us-ascii";
  name="ksymmoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymmoops.txt"

ksymoops 2.4.8 on i686 2.4.20-athlon-pp.  Options used
     -v vmlinux__2.4.20-athlon-pp (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-athlon-pp/ (default)
     -m System.map__2.4.20-athlon-pp (specified)

kernel BUG at highmem.c:159!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01345c9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c2b924b0   ecx: e4f94000   edx: 00000000
esi: f784a734   edi: 00000000   ebp: f5127e30   esp: e4f95ea4
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 7547, stackpage=e4f95000)
Stack: c2b924b0 f784a734 c0171015 c2b924b0 c012b6b5 f5127d80 c2b924b0 e4f95f8c
       e4f94000 e4f95f8c f5127d80 c0171047 f5127e30 00000000 c0170fb0 f5127d80
       c0171152 f5127d80 e4f95ef4 f50ce1c0 00000000 c013f99a f50ce1c0 e4f95f8c
Call Trace:    [<c0171015>] [<c012b6b5>] [<c0171047>] [<c0170fb0>] [<c0171152>]
  [<c013f99a>] [<c013fb0a>] [<c013fc8b>] [<c0140054>] [<c0135b9b>] [<c0135ef6>]
  [<c0108837>]
Code: 0f 0b 9f 00 98 f7 26 c0 05 00 00 00 02 c1 e8 0c c1 e0 02 ba


>>EIP; c01345c9 <kunmap_high+9/80>   <=====

>>ebx; c2b924b0 <_end+284360c/386531bc>
>>ecx; e4f94000 <_end+24c4515c/386531bc>
>>esi; f784a734 <_end+374fb890/386531bc>
>>ebp; f5127e30 <_end+34dd8f8c/386531bc>
>>esp; e4f95ea4 <_end+24c47000/386531bc>

Trace; c0171015 <nfs_symlink_filler+65/80>
Trace; c012b6b5 <read_cache_page+85/120>
Trace; c0171047 <nfs_getlink+17/80>
Trace; c0170fb0 <nfs_symlink_filler+0/80>
Trace; c0171152 <nfs_follow_link+22/70>
Trace; c013f99a <link_path_walk+70a/860>
Trace; c013fb0a <path_walk+1a/20>
Trace; c013fc8b <path_lookup+1b/30>
Trace; c0140054 <open_namei+74/560>
Trace; c0135b9b <filp_open+3b/60>
Trace; c0135ef6 <sys_open+36/90>
Trace; c0108837 <system_call+33/38>

Code;  c01345c9 <kunmap_high+9/80>
00000000 <_EIP>:
Code;  c01345c9 <kunmap_high+9/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01345cb <kunmap_high+b/80>
   2:   9f                        lahf   
Code;  c01345cc <kunmap_high+c/80>
   3:   00 98 f7 26 c0 05         add    %bl,0x5c026f7(%eax)
Code;  c01345d2 <kunmap_high+12/80>
   9:   00 00                     add    %al,(%eax)
Code;  c01345d4 <kunmap_high+14/80>
   b:   00 02                     add    %al,(%edx)
Code;  c01345d6 <kunmap_high+16/80>
   d:   c1 e8 0c                  shr    $0xc,%eax
Code;  c01345d9 <kunmap_high+19/80>
  10:   c1 e0 02                  shl    $0x2,%eax
Code;  c01345dc <kunmap_high+1c/80>
  13:   ba 00 00 00 00            mov    $0x0,%edx


--Boundary-00=_uZHh+N+0MUVj9YG--

