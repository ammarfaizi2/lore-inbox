Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTDJTHK (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTDJTHK (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:07:10 -0400
Received: from WARSL401PIP4.highway.telekom.at ([195.3.96.79]:4401 "HELO
	email05.aon.at") by vger.kernel.org with SMTP id S264122AbTDJTHI (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 15:07:08 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rtl8139 Problem/kernel panic (probably unrelated)
Date: Thu, 10 Apr 2003 21:18:24 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304102118.24350.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have problems with my Ovis Link 10/100 PCI Network adapter (based on 
RTL8139too)

Until yesterday the NIC worked flawlessly with Linux-2.4.19-SuSE (from SuSE 
8.1) and rtl8139too (driver version 0.9.26).

Yesterday I exchanged motherboards + Processor (from MSI 6195, K7pro with 
Slot1 K7-700 to MSI 3660, K7turbo with Socket A 1.2 Thunderbird) and added 
256MB RAM (now 512MB).

The old motherboard had a AMD751 Irongate chipset, the new has a Via 
KT133A(552BGA)/VIA686B(352BGA) chipset.

Now the network connection is sometimes "stuck" for ~1-2 seconds every ~30
seconds, "dmesg" outputs the following:

eth0: Too much work at interrupt, IntrStatus=0x0001.

I googled around a bit but all I could find was the advice to try another
PCI slot (tried it - but helped nothing) and to replace the cheap NIC to a
better quality one.

Oooops - while writing this and opening the Acrobat Reader I received
multiple kernel panics:

--------------- snip -----------------
Unable to handle kernel paging request at virtual address 67726f46
 printing eip:
c0147790
*pde = 00000000
Oops: 0000 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 2002
CPU:    0
EIP:    0010:[<c0147790>]    Tainted: P
EFLAGS: 00013a83
eax: c8740000   ebx: 67726f2e   ecx: 000001d2   edx: 000001d2
esi: 00000001   edi: c0b75480   ebp: 00000001   esp: c8741dd8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1097, stackpage=c8741000)
Stack: c0b753c0 c10206c0 c0b75480 c0147934 c0b75480 c10206c0 000001d2 c10206c0
       c02d3e2c 00004a7e c013ac80 c10206c0 000001d2 c8740000 00000000 00000c80
       000001d2 00000012 00000020 000001d2 c02d3e2c c02d3e2c c013b11f c8741e50
Call Trace:    [<c0147934>] [<c013ac80>] [<c013b11f>] [<c013b180>] 
[<c013c249>]
  [<c013c4f7>] [<c013c5ff>] [<c012f82f>] [<c012ff26>] [<c011a78d>] 
[<c9c180e9>]
  [<c9d58c00>] [<c9c180ab>] [<c9c17fed>] [<c9c18c50>] [<c9c01821>] 
[<c010a034>]
  [<c9d58c00>] [<c010a1c8>] [<c011a5e0>] [<c0108f74>]
Modules: [(nvidia:<c9c00060>:<c9d79680>)]
Code: f7 43 18 06 00 00 00 74 37 b8 07 00 00 00 0f ab 43 18 19 c0
 <1>Unable to handle kernel paging request at virtual address 742e778f
 printing eip:
c0147790
*pde = 00000000
Oops: 0000 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 2002
CPU:    0
EIP:    0010:[<c0147790>]    Tainted: P
EFLAGS: 00013a83
eax: 00000000   ebx: 742e7777   ecx: 000001d0   edx: 000001d0
esi: 00000000   edi: c0b75780   ebp: 00000001   esp: dff9df10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=dff9d000)
Stack: c0b75720 c1021230 c0b75780 c0147934 c0b75780 c1021230 000001d0 c1021230
       c02d3e2c 00004833 c013ac80 c1021230 000001d0 dff9c000 00000000 000003e8
       000001d0 0000000a 0000000a 000001d0 c02d3e2c c02d3e2c c013b11f dff9df88
Call Trace:    [<c0147934>] [<c013ac80>] [<c013b11f>] [<c013b180>] 
[<c013b2ce>]
  [<c013b326>] [<c013b462>] [<c0105000>] [<c01072c6>] [<c013b3c0>]
Code: f7 43 18 06 00 00 00 74 37 b8 07 00 00 00 0f ab 43 18 19 c0
 <1>Unable to handle kernel paging request at virtual address 0000cdd0
 printing eip:
c0147790
*pde = 00000000
Oops: 0000 2.4.19-4GB #1 Fri Sep 13 13:14:56 UTC 2002
CPU:    0
EIP:    0010:[<c0147790>]    Tainted: P
EFLAGS: 00010203
eax: da494000   ebx: 0000cdb8   ecx: 000001d2   edx: 000001d2
esi: 00000001   edi: c0b75d80   ebp: 00000001   esp: da495dc8
ds: 0018   es: 0018   ss: 0018
Process acroread (pid: 2306, stackpage=da495000)
Stack: c0b75d20 c1021350 c0b75d80 c0147934 c0b75d80 c1021350 000001d2 c1021350
       c02d3e2c 00004a45 c013ac80 c1021350 000001d2 da494000 00000000 00000898
       000001d2 00000015 00000016 000001d2 c02d3e2c c02d3e2c c013b11f da495e40
Call Trace:    [<c0147934>] [<c013ac80>] [<c013b11f>] [<c013b180>] 
[<c013c249>]
  [<c013c4f7>] [<c0134681>] [<c013c5ff>] [<c012fc0b>] [<c012ff26>] 
[<c011a78d>]

-------------------- snip ----------------------

Well - this could be due to these buggy nvidia drivers. :-(

Anyway, do you have another suggestion to the network card problems - except
replacing cards - or is this just a incompatibility between the 8139 chipset
and the Via KT133A chipset?

                Best Regards,
                Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

