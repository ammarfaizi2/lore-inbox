Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284020AbRLHTEX>; Sat, 8 Dec 2001 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284036AbRLHTEN>; Sat, 8 Dec 2001 14:04:13 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:42794 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284020AbRLHTEB>;
	Sat, 8 Dec 2001 14:04:01 -0500
Subject: 2.4.17-pre4/5 card services oops
From: pHilipp Zabel <pzabel@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 08 Dec 2001 20:00:20 +0100
Message-Id: <1007838029.580.0.camel@monster>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When I insert any pcmcia card (cardmgr 3.1.29 running), I get the
following Oops on a Dell Inspiron 8000 with Debian sid and
linux kernel 2.4.17-pre4 or 2.4.17-pre5 installed (this does not
happen with 2.4.16):

,---------------------------------------------------------------

cs: memory probe 0xa0000000-0xa0ffffff:<1>Unable to handle kernel NULL
pointer dereference at virtual address 00000004
 printing eip:
c01178e1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01178e1>]    Tainted: P 
EFLAGS: 00010206
eax: 00000000   ebx: cde93988   ecx: 00000000   edx: a00fffff
esi: a00fffff   edi: a0000000   ebp: 00100000   esp: cde93968
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 847, stackpage=cde93000)
Stack: cde93988 a0000000 a0000000 c01179b4 00000000 cde93988 ce0e04a0
a0000000 
       00000200 a0000000 a00fffff ce0e04a0 d0940745 a0000000 00100000
d094074e 
       00000000 a0000000 00100000 ce0e04a0 00000000 ce988000 d093e4c4
a1000000 
Call Trace: [<c01179b4>] [<d0940745>] [<d094074e>] [<d093e4c4>]
[<d09408db>] 
   [<d093e344>] [<d093e4c4>] [<d093e4c4>] [<d0940890>] [<d093e344>]
[<d093e4c4>] 
   [<d093e4c4>] [<d0940890>] [<d093e344>] [<d093e4c4>] [<d0940935>]
[<d093e344>] 
   [<d093e4c4>] [<d093e532>] [<d093e344>] [<d093e4c4>] [<d093e0cc>]
[<d093e722>] 
   [<d093ebfb>] [<d093ea1a>] [<d09400b5>] [<d084bd30>] [<d0854e77>]
[<d0856d90>] 
   [<d08570b4>] [<d0857a15>] [<d084e65c>] [<d0860eef>] [<d0861287>]
[<d0951fcf>] 
   [<c012f2ec>] [<d085eca3>] [<d085f54f>] [<d0869328>] [<d0850a1c>]
[<d085ead8>] 
   [<d08524d4>] [<d086686f>] [<d0866cd5>] [<c0111280>] [<c01289a7>]
[<c01289c2>] 
   [<c013970a>] [<c0139a08>] [<c0139a42>] [<c0139e9f>] [<d0951ad7>]
[<c0139057>] 
   [<c0106b0b>] 

Code: 3b 79 04 72 05 3b 71 08 76 05 89 c8 eb 29 90 8d 51 18 8b 02 

`---------------------------------------------------------------

a lsmod just before inserting a card revealed this:

,---------------------------------------------------------------

Module                  Size  Used by    Tainted: P 
ds                      6504   2 
yenta_socket            8424   2 
pcmcia_core            38760   0  [ds yenta_socket]
rtc                     5536   0  (autoclean)
nls_cp437               4384   2  (autoclean)
nls_iso8859-1           2880   3  (autoclean)
ntfs                   47016   1  (autoclean)
reiserfs              151120   1  (autoclean)
i8k                     5192   0  (unused)
ospm_thermal           10680   0  (unused)
ospm_processor          9204   0  (unused)
ospm_button             4588   0  (unused)
ospm_battery            7472   0  (unused)
ospm_ac_adapter         3296   0  (unused)
maestro3               24752   0  (unused)
ac97_codec              9568   0  [maestro3]
soundcore               3500   2  [maestro3]
vfat                    9324   2 
fat                    29216   0  [vfat]

`---------------------------------------------------------------

Please tell me, if I forgot anything of importance.

grusz
pHilipp


