Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292104AbSBAWSj>; Fri, 1 Feb 2002 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292115AbSBAWSU>; Fri, 1 Feb 2002 17:18:20 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:46600 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S292104AbSBAWSA>; Fri, 1 Feb 2002 17:18:00 -0500
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
From: Martin Bahlinger <ry42@rz.uni-karlsruhe.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020201085545.A1034@namesys.com>
In-Reply-To: <1012499057.704.0.camel@hek411>
	<Pine.LNX.4.31.0201312133490.652-100000@hek411.hek.uni-karlsruhe.de> 
	<20020201085545.A1034@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 01 Feb 2002 23:17:56 +0100
Message-Id: <1012601878.644.0.camel@hek411>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, 2002-02-01 at 06:55, Oleg Drokin wrote:
> You are the only who reporting these errors for now.
> Can you reboot into vanilla 2.5.3 and capture PAP-5760 oops
> and all reiserfs-specific output around it? Thank you.

Because I don't have my first build of 2.5.3 any more, I had to compile
a new one without any patches applied to it. But now I get a completely
different behaviour: I can boot without problems and get those PAP-5580
oops after a few minutes uptime. I attached the oops message and the
output of ksymoops at the end of this mail.

I think, the other oops (PAP-14030) happened because of those filesystem
corruptions I mentioned before. Maybe the fs corrupted during the first
PAP-5580 oops, maybe it has been so for some days or even weeks. I just
don't know.

> > reiserfsck ran into a segfault when checking the semantic tree. And this
> 
> This means you need updated reiserfsprogs.

I use reiserfsprogs 3.x.0j as recommended by linux/Documentation/Changes

bye
  Martin


-----------------------------------------------------------------------------


vs-500: unknown uniqueness 536870912
vs-500: unknown uniqueness 536870912
vs-500: unknown uniqueness 268435456
vs-500: unknown uniqueness 268435456

===================================================================
LEAF NODE (28440) contains level=1, nr_items=6, free_space=2384 rdkey
-------------------------------------------------------------------------------
|##|   type    |           key           | ilen | free_space | version |
loc  |
-------------------------------------------------------------------------------
| 1| *3.6* [67650 1815 0x1 DIRECT], item_len 600, item_location 3452,
free_space(entry_count) 65535 |
"^_^^U<^B^Cmainlog.0VKj^\A^P^Da=OQ^W^PTfu=^F<t 
|^B^C4pFXB:?g^L^^\^Y^?Gh^?t^DU^Uc%xS1'oESC^WK^Y^Wb[ww^_oo[o^O^W^O^Wmmcu2}zy|5;w/^Nz[k36cs?x=^Tz^R<^Zb
N4^^^?q(^N^Xr3mu<7^UD^TESChU^O^^PSn"~~=S^\1df*z^]^Sn""_Y1e~OgVd ^^{@L9 
*~[CL9
*~WEL9
~W1D^PESC))~^WUD^TESC(hw9!&\Do^UyIneL9  *~w
^Xr^CuYosD^TESC(j7ESCbJMT^\_5*bJMTu;^]1e^F*__5
bJMTu;^VbLTtk%^LT^P^\-I^Wg4^N^X^W.R5^\GgJDK)<q#ND8tG*o\X;bJMT^1&bJMT-Fq
"U^K<'bJT_8c<^X:q       *ESCg^E1.Q$jE3 
^Xs#U/^ZwD8pG:K~kB^L^K^Wi-2^?TB]qc^E;RUoqa"U}v^B^X^WnH[_J|S^KwG^O^WnJUy^]^F^X^W.Rzi^E;cG^Kw%*_5cnvu~-^X!F^EKV4|U^K5'G+W9n(19Y&>9lL?/9Y!{^N'~(^^U=[^Y()9[qo]lx_^?.19YU3m5&^G;eOW ^Z^R3=5WO^RC/|'19Yu^^]^WjN^NVu<{^N^Z^R#]2g=:jLNV^]g=<7K^\glUOm1&dlUO}^_()yf^?vK|l^T^T"
-------------------------------------------------------------------------------
| 2| *3.6* [67650 2233 0x0 SD], item_len 44, item_location 3408,
free_space(entry_count) 65535 |
        mode | size | nlinks | first direct | mtime
        0100640 |    808 |  1 | 785786 | 1012598582
===================================================================
PAP-5580: reiserfs_cut_from_item: item to convert does not exist ([67650
2233 0x1 IND])invalid operand: 0000
CPU:    0
EIP:    0010:[<c0167549>]    Not tainted
EFLAGS: 00010282
eax: 0000005a   ebx: c0224e80   ecx: 00000001   edx: df256000
esi: c1971c00   edi: 00000000   ebp: d2507e20   esp: d2507c24
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 605, stackpage=d2507000)
Stack: c02239fa c02aa0a0 c0224e80 d2507c48 d2507c80 00000000 c016e85c
c1971c00
       c0224e80 d2507e60 d5504cc0 00000003 00000001 00000003 00001000
00000000
       00000001 d2507c84 00000cd8 00000001 00000cd8 c1971c00 63000000
00000000
Call Trace: [<c016e85c>] [<c016ee59>] [<c0160506>] [<c01612fb>]
[<c013113c>]
   [<c013017c>] [<c0117998>] [<c0117f8e>] [<c011813e>] [<c0108837>]

Code: 0f 0b 68 a0 a0 2a c0 b8 00 3a 22 c0 8d 96 cc 00 00 00 85 f6



-----------------------------------------------------------------------------



ksymoops 2.4.3 on i686 2.5.3.  Options used
     -V (default)
     -k /var/log/ksymoops/20020201222518.ksyms (specified)
     -l /var/log/ksymoops/20020201222518.modules (specified)
     -o /lib/modules/2.5.3/ (default)
     -m /usr/src/linux/System.map (specified)

8139too Fast Ethernet driver 0.9.22
ac97_codec: AC97 Audio codec, id: 0x414c:0x4326 (Unknown)
        0100640 |    808 |  1 | 785786 | 1012598582
CPU:    0
EIP:    0010:[<c0167549>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000005a   ebx: c0224e80   ecx: 00000001   edx: df256000
esi: c1971c00   edi: 00000000   ebp: d2507e20   esp: d2507c24
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 605, stackpage=d2507000)
Stack: c02239fa c02aa0a0 c0224e80 d2507c48 d2507c80 00000000 c016e85c
c1971c00
       c0224e80 d2507e60 d5504cc0 00000003 00000001 00000003 00001000
00000000
       00000001 d2507c84 00000cd8 00000001 00000cd8 c1971c00 63000000
00000000
Call Trace: [<c016e85c>] [<c016ee59>] [<c0160506>] [<c01612fb>]
[<c013113c>]
   [<c013017c>] [<c0117998>] [<c0117f8e>] [<c011813e>] [<c0108837>]
Code: 0f 0b 68 a0 a0 2a c0 b8 00 3a 22 c0 8d 96 cc 00 00 00 85 f6

>>EIP; c0167548 <reiserfs_panic+28/50>   <=====
Trace; c016e85c <reiserfs_cut_from_item+1ac/450>
Trace; c016ee58 <reiserfs_do_truncate+308/440>
Trace; c0160506 <reiserfs_truncate_file+c6/160>
Trace; c01612fa <reiserfs_file_release+31a/340>
Trace; c013113c <fput+4c/e0>
Trace; c013017c <filp_close+5c/70>
Trace; c0117998 <put_files_struct+58/c0>
Trace; c0117f8e <do_exit+ae/230>
Trace; c011813e <sys_exit+e/10>
Trace; c0108836 <syscall_traced+6/a>
Code;  c0167548 <reiserfs_panic+28/50>
00000000 <_EIP>:
Code;  c0167548 <reiserfs_panic+28/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016754a <reiserfs_panic+2a/50>
   2:   68 a0 a0 2a c0            push   $0xc02aa0a0
Code;  c016754e <reiserfs_panic+2e/50>
   7:   b8 00 3a 22 c0            mov    $0xc0223a00,%eax
Code;  c0167554 <reiserfs_panic+34/50>
   c:   8d 96 cc 00 00 00         lea    0xcc(%esi),%edx
Code;  c016755a <reiserfs_panic+3a/50>
  12:   85 f6                     test   %esi,%esi



-----------------------------------------------------------------------------




 
-- 
Martin Bahlinger <bahlinger@rz.uni-karlsruhe.de>   (PGP-ID: 0x98C32AC5)

