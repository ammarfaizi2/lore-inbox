Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVFPGuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVFPGuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVFPGuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:50:13 -0400
Received: from mollusk.mweb.co.za ([196.2.24.27]:31632 "EHLO
	mollusk.mweb.co.za") by vger.kernel.org with ESMTP id S261760AbVFPGtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:49:13 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andi Kleen <ak@muc.de>
Subject: Re: Tracking a bug in x86-64
Date: Thu, 16 Jun 2005 08:49:58 +0200
User-Agent: KMail/1.8.50
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
References: <200506132259.22151.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506151740110.8487@ppc970.osdl.org> <20050616020247.GA27608@muc.de>
In-Reply-To: <20050616020247.GA27608@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506160849.58397.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 04:02 am, Andi Kleen wrote:
> > (It would be even better to see that for one of the processes that tends 
> > to core-dump, like "cc1", but that would require you to catch it, probably 
> > by doign ^Z at just the right time)
> 
> iirc gdb can extract that information from a core dump.
> if not readelf -a probably can. 
> 
> -Andi
> 

[bongani@bongani64 patches]$ cat /proc/self/maps
00400000-00405000 r-xp 00000000 03:06 5668926                            /bin/cat
00505000-00506000 rw-p 00005000 03:06 5668926                            /bin/cat
00506000-00527000 rw-p 00506000 00:00 0                                  [heap]
2aaaaaaab000-2aaaaaabf000 r-xp 00000000 03:06 11911179                   /lib64/ld-2.3.4.so
2aaaaaabf000-2aaaaaac0000 rw-p 2aaaaaabf000 00:00 0
2aaaaaac0000-2aaaaaac1000 r--p 00000000 03:06 7389703                    /usr/share/locale/en_ZA/LC_IDENTIFICATION
2aaaaaac1000-2aaaaaac2000 r--p 00000000 03:06 7389947                    /usr/share/locale/en_ZA/LC_MEASUREMENT
2aaaaaac2000-2aaaaaac3000 r--p 00000000 03:06 7389700                    /usr/share/locale/en_ZA/LC_TELEPHONE
2aaaaaac3000-2aaaaaac4000 r--p 00000000 03:06 7389704                    /usr/share/locale/en_ZA/LC_ADDRESS
2aaaaaac4000-2aaaaaac5000 r--p 00000000 03:06 7389701                    /usr/share/locale/en_ZA/LC_NAME
2aaaaaac5000-2aaaaaac6000 r--p 00000000 03:06 7389909                    /usr/share/locale/en_ZA/LC_PAPER
2aaaaaac6000-2aaaaaac7000 r--p 00000000 03:06 7389933                    /usr/share/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES
2aaaaaac7000-2aaaaaac8000 r--p 00000000 03:06 7389702                    /usr/share/locale/en_ZA/LC_MONETARY
2aaaaaac8000-2aaaaaace000 r--p 00000000 03:06 7389316                    /usr/share/locale/ISO-8859-1/LC_COLLATE
2aaaaaace000-2aaaaaacf000 r--p 00000000 03:06 7389922                    /usr/share/locale/en_US/LC_TIME
2aaaaaacf000-2aaaaaad0000 r--p 00000000 03:06 7389930                    /usr/share/locale/en_ZA/LC_NUMERIC
2aaaaaad0000-2aaaaaafc000 r--p 00000000 03:06 7389456                    /usr/share/locale/ISO-8859-1/LC_CTYPE
2aaaaabbf000-2aaaaabc0000 r--p 00014000 03:06 11911179                   /lib64/ld-2.3.4.so
2aaaaabc0000-2aaaaabc1000 rw-p 00015000 03:06 11911179                   /lib64/ld-2.3.4.so
2aaaaabc1000-2aaaaace9000 r-xp 00000000 03:06 11911311                   /lib64/tls/libc-2.3.4.so
2aaaaace9000-2aaaaade8000 ---p 00128000 03:06 11911311                   /lib64/tls/libc-2.3.4.so
2aaaaade8000-2aaaaadeb000 r--p 00127000 03:06 11911311                   /lib64/tls/libc-2.3.4.so
2aaaaadeb000-2aaaaadee000 rw-p 0012a000 03:06 11911311                   /lib64/tls/libc-2.3.4.so
2aaaaadee000-2aaaaadf4000 rw-p 2aaaaadee000 00:00 0
7fffff92d000-7fffff942000 rw-p 7fffff92d000 00:00 0                      [stack]
ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0                  [vdso]

[bongani@bongani64 linux-2.6.8]$ readelf -a core.21904
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         7
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

There are no sections in this file.

There are no section groups in this file.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x00000000000001c8 0x0000000000000000 0x0000000000000000
                 0x0000000000000a48 0x0000000000000000         0
  LOAD           0x0000000000001000 0x0000000000400000 0x0000000000000000
                 0x0000000000000000 0x00000000003e6000  R E    1000
  LOAD           0x0000000000001000 0x00000000008e6000 0x0000000000000000
                 0x0000000000002000 0x0000000000002000  RW     1000
  LOAD           0x0000000000003000 0x00000000008e8000 0x0000000000000000
                 0x0000000000000000 0x0000000000094000  RW     1000
  LOAD           0x0000000000003000 0x00002aaaaaaab000 0x0000000000000000
                 0x0000000000000000 0x0000000000014000  R E    1000
  LOAD           0x0000000000003000 0x00002aaaaabbf000 0x0000000000000000
                 0x0000000000002000 0x0000000000002000  RW     1000
  LOAD           0x0000000000005000 0x00007ffffffac000 0x0000000000000000
                 0x0000000000016000 0x0000000000016000  RW     1000

There is no dynamic section in this file.

There are no relocations in this file.

There are no unwind sections in this file.

No version information found in this file.

Notes at offset 0x000001c8 with length 0x00000a48:
  Owner         Data size       Description
  CORE          0x00000150      NT_PRSTATUS (prstatus structure)
  CORE          0x00000088      NT_PRPSINFO (prpsinfo structure)
  CORE          0x00000720      NT_TASKSTRUCT (task structure)
  CORE          0x00000100      NT_AUXV (auxiliary vector)


gdb bt of cc1[21904]: segfault at 00002aaaaabc1008 rip 00002aaaaaaac1c8 rsp 00007ffffffbfd50 error 4

Core was generated by `                                       '.
Program terminated with signal 11, Segmentation fault.
#0  0x00002aaaaaaac1c8 in ?? ()
(gdb) bt 
#0  0x00002aaaaaaac1c8 in ?? ()
#1  0x0000000000000000 in ?? ()
#2  0x0000000000000000 in ?? ()
#3  0x0000000000000000 in ?? ()
#4  0x0000000000000000 in ?? ()
#5  0x0000000000000000 in ?? ()
#6  0x0000000000000000 in ?? ()
#7  0x0000000000000000 in ?? ()
#8  0x0000000000000000 in ?? ()
#9  0x0000000000000000 in ?? ()
#10 0x0000000000000000 in ?? ()
#11 0x0000000000000000 in ?? ()
#12 0x0000000000000000 in ?? ()
#13 0x0000000000000000 in ?? ()
#14 0x0000000000000000 in ?? ()
#15 0x0000000000000000 in ?? ()
#16 0x00002aaaaaaaba88 in ?? ()
#17 0x0000000000000028 in ?? ()
#18 0x00007ffffffc0a3d in ?? ()
#19 0x00007ffffffc0a3e in ?? ()
#20 0x00007ffffffc0a3f in ?? ()
#21 0x00007ffffffc0a40 in ?? ()
#22 0x00007ffffffc0a41 in ?? ()
#23 0x00007ffffffc0a42 in ?? ()
#24 0x00007ffffffc0a43 in ?? ()
#25 0x00007ffffffc0a44 in ?? ()
#26 0x00007ffffffc0a45 in ?? ()
#27 0x00007ffffffc0a46 in ?? ()
#28 0x00007ffffffc0a47 in ?? ()
#29 0x00007ffffffc0a48 in ?? ()
#30 0x00007ffffffc0a49 in ?? ()
#31 0x00007ffffffc0a4a in ?? ()
#32 0x00007ffffffc0a4b in ?? ()
#33 0x00007ffffffc0a4c in ?? ()
#34 0x00007ffffffc0a4d in ?? ()
#35 0x00007ffffffc0a4e in ?? ()
#36 0x00007ffffffc0a4f in ?? ()
#37 0x00007ffffffc0a50 in ?? ()
#38 0x00007ffffffc0a51 in ?? ()
#39 0x00007ffffffc0a52 in ?? ()
#40 0x00007ffffffc0a53 in ?? ()
#41 0x00007ffffffc0a54 in ?? ()
#42 0x00007ffffffc0a55 in ?? ()
#43 0x00007ffffffc0a56 in ?? ()
#44 0x00007ffffffc0a57 in ?? ()
#45 0x00007ffffffc0a58 in ?? ()
#46 0x00007ffffffc0a59 in ?? ()
#47 0x00007ffffffc0a5a in ?? ()
#48 0x00007ffffffc0a5b in ?? ()
#49 0x00007ffffffc0a5c in ?? ()
#50 0x00007ffffffc0a5d in ?? ()
#51 0x00007ffffffc0a5e in ?? ()
#52 0x00007ffffffc0a5f in ?? ()
#53 0x00007ffffffc0a60 in ?? ()
#54 0x00007ffffffc0a61 in ?? ()
#55 0x00007ffffffc0a62 in ?? ()
#56 0x00007ffffffc0a63 in ?? ()
#57 0x00007ffffffc0a64 in ?? ()
#58 0x0000000000000000 in ?? ()
#59 0x00007ffffffc0a65 in ?? ()
#60 0x00007ffffffc0a66 in ?? ()
#61 0x00007ffffffc0a67 in ?? ()
#62 0x00007ffffffc0a68 in ?? ()
#63 0x00007ffffffc0a69 in ?? ()
#64 0x00007ffffffc0a6a in ?? ()
#65 0x00007ffffffc0a6b in ?? ()
#66 0x00007ffffffc0a6c in ?? ()
#67 0x00007ffffffc0a6d in ?? ()
#68 0x00007ffffffc0a6e in ?? ()
#69 0x00007ffffffc0a6f in ?? ()
#70 0x00007ffffffc0a70 in ?? ()
#71 0x00007ffffffc0a71 in ?? ()
#72 0x00007ffffffc0a72 in ?? ()
#73 0x00007ffffffc0a73 in ?? ()
#74 0x00007ffffffc0a74 in ?? ()
#75 0x00007ffffffc0a75 in ?? ()
#76 0x00007ffffffc0a76 in ?? ()
#77 0x00007ffffffc0a77 in ?? ()
#78 0x00007ffffffc0a78 in ?? ()
#79 0x00007ffffffc0a79 in ?? ()
#80 0x00007ffffffc0a7a in ?? ()
#81 0x00007ffffffc0a7b in ?? ()
#82 0x00007ffffffc0a7c in ?? ()
#83 0x00007ffffffc0a7d in ?? ()
#84 0x00007ffffffc0a7e in ?? ()
#85 0x00007ffffffc0a7f in ?? ()
#86 0x00007ffffffc0a80 in ?? ()
#87 0x00007ffffffc0a81 in ?? ()
#88 0x00007ffffffc0a82 in ?? ()
#89 0x00007ffffffc0a83 in ?? ()
#90 0x00007ffffffc0a84 in ?? ()
#91 0x00007ffffffc0a85 in ?? ()
#92 0x00007ffffffc0a86 in ?? ()
#93 0x00007ffffffc0a87 in ?? ()
#94 0x00007ffffffc0a88 in ?? ()
#95 0x00007ffffffc0a89 in ?? ()
#96 0x00007ffffffc0a8a in ?? ()
#97 0x00007ffffffc0a8b in ?? ()
#98 0x00007ffffffc0a8c in ?? ()
#99 0x00007ffffffc0a8d in ?? ()
#100 0x00007ffffffc0a8e in ?? ()
#101 0x00007ffffffc0a8f in ?? ()
#102 0x00007ffffffc0a90 in ?? ()
#103 0x00007ffffffc0a91 in ?? ()
#104 0x00007ffffffc0a92 in ?? ()
#105 0x00007ffffffc0a93 in ?? ()
#106 0x00007ffffffc0a94 in ?? ()
#107 0x00007ffffffc0a95 in ?? ()
#108 0x00007ffffffc0a96 in ?? ()
#109 0x00007ffffffc0a97 in ?? ()
#110 0x00007ffffffc0a98 in ?? ()
#111 0x00007ffffffc0a99 in ?? ()
#112 0x00007ffffffc0a9a in ?? ()
#113 0x00007ffffffc0a9b in ?? ()
#114 0x00007ffffffc0a9c in ?? ()
#115 0x00007ffffffc0a9d in ?? ()
#116 0x00007ffffffc0a9e in ?? ()
#117 0x00007ffffffc0a9f in ?? ()
#118 0x00007ffffffc0aa0 in ?? ()
#119 0x00007ffffffc0aa1 in ?? ()
#120 0x00007ffffffc0aa2 in ?? ()
#121 0x00007ffffffc0aa3 in ?? ()
#122 0x00007ffffffc0aa4 in ?? ()
#123 0x00007ffffffc0aa5 in ?? ()
#124 0x00007ffffffc0aa6 in ?? ()
#125 0x00007ffffffc0aa7 in ?? ()
#126 0x00007ffffffc0aa8 in ?? ()
#127 0x00007ffffffc0aa9 in ?? ()
#128 0x00007ffffffc0aaa in ?? ()
#129 0x00007ffffffc0aab in ?? ()
#130 0x00007ffffffc0aac in ?? ()
#131 0x00007ffffffc0aad in ?? ()
#132 0x00007ffffffc0aae in ?? ()
#133 0x00007ffffffc0aaf in ?? ()
#134 0x00007ffffffc0ab0 in ?? ()
#135 0x00007ffffffc0ab1 in ?? ()
#136 0x00007ffffffc0ab2 in ?? ()
#137 0x00007ffffffc0ab3 in ?? ()
#138 0x00007ffffffc0ab4 in ?? ()
#139 0x00007ffffffc0ab5 in ?? ()
#140 0x00007ffffffc0ab6 in ?? ()
#141 0x00007ffffffc0ab7 in ?? ()
#142 0x00007ffffffc0ab8 in ?? ()
#143 0x00007ffffffc0ab9 in ?? ()
#144 0x00007ffffffc0aba in ?? ()
#145 0x00007ffffffc0abb in ?? ()
#146 0x00007ffffffc0abc in ?? ()
#147 0x00007ffffffc0abd in ?? ()
#148 0x00007ffffffc0abe in ?? ()
#149 0x00007ffffffc0abf in ?? ()
#150 0x00007ffffffc0ac0 in ?? ()
#151 0x00007ffffffc0ac1 in ?? ()
#152 0x00007ffffffc0ac2 in ?? ()
#153 0x00007ffffffc0ac3 in ?? ()
#154 0x00007ffffffc0ac4 in ?? ()
#155 0x00007ffffffc0ac5 in ?? ()
#156 0x00007ffffffc0ac6 in ?? ()
#157 0x00007ffffffc0ac7 in ?? ()
#158 0x00007ffffffc0ac8 in ?? ()
#159 0x00007ffffffc0ac9 in ?? ()
#160 0x00007ffffffc0aca in ?? ()
#161 0x00007ffffffc0acb in ?? ()
#162 0x00007ffffffc0acc in ?? ()
#163 0x00007ffffffc0acd in ?? ()
#164 0x00007ffffffc0ace in ?? ()
#165 0x00007ffffffc0acf in ?? ()
#166 0x00007ffffffc0ad0 in ?? ()
#167 0x00007ffffffc0ad1 in ?? ()
#168 0x00007ffffffc0ad2 in ?? ()
#169 0x00007ffffffc0ad3 in ?? ()
#170 0x00007ffffffc0ad4 in ?? ()
#171 0x00007ffffffc0ad5 in ?? ()
#172 0x00007ffffffc0ad6 in ?? ()
#173 0x00007ffffffc0ad7 in ?? ()
#174 0x00007ffffffc0ad8 in ?? ()
#175 0x00007ffffffc0ad9 in ?? ()
#176 0x00007ffffffc0ada in ?? ()
#177 0x00007ffffffc0adb in ?? ()
#178 0x00007ffffffc0adc in ?? ()
#179 0x00007ffffffc0add in ?? ()
#180 0x00007ffffffc0ade in ?? ()
#181 0x00007ffffffc0adf in ?? ()
#182 0x00007ffffffc0ae0 in ?? ()
#183 0x00007ffffffc0ae1 in ?? ()
#184 0x00007ffffffc0ae2 in ?? ()
#185 0x00007ffffffc0ae3 in ?? ()
#186 0x00007ffffffc0ae4 in ?? ()
#187 0x00007ffffffc0ae5 in ?? ()
#188 0x00007ffffffc0ae6 in ?? ()
#189 0x00007ffffffc0ae7 in ?? ()
#190 0x00007ffffffc0ae8 in ?? ()
#191 0x00007ffffffc0ae9 in ?? ()
#192 0x00007ffffffc0aea in ?? ()
#193 0x00007ffffffc0aeb in ?? ()
#194 0x00007ffffffc0aec in ?? ()
#195 0x00007ffffffc0aed in ?? ()
#196 0x00007ffffffc0aee in ?? ()
#197 0x00007ffffffc0aef in ?? ()
#198 0x0000000000000000 in ?? ()
#199 0x0000000000000010 in ?? ()
#200 0x00000000078bfbff in ?? ()
#201 0x0000000000000006 in ?? ()
#202 0x0000000000001000 in ?? ()
#203 0x0000000000000011 in ?? ()
#204 0x00002aaaaaaac130 in ?? ()
#205 0x0000000000000003 in ?? ()
#206 0x0000000000400040 in ?? ()
#207 0x0000000000000004 in ?? ()
#208 0x0000000000000038 in ?? ()
#209 0x0000000000000005 in ?? ()
#210 0x0000000000000008 in ?? ()
#211 0x0000000000000007 in ?? ()
#212 0x00002aaaaaaab000 in ?? ()
#213 0x0000000000000008 in ?? ()
#214 0x0000000000000000 in ?? ()
#215 0x0000000000000009 in ?? ()
#216 0x0000000000402400 in ?? ()
#217 0x000000000000000b in ?? ()
#218 0x0000000000000000 in ?? ()
#219 0x000000000000000c in ?? ()
#220 0x0000000000000000 in ?? ()
#221 0x000000000000000d in ?? ()
#222 0x0000000000000000 in ?? ()
#223 0x000000000000000e in ?? ()
#224 0x0000000000000000 in ?? ()
#225 0x0000000000000017 in ?? ()
#226 0x0000000000000000 in ?? ()
#227 0x000000000000000f in ?? ()
#228 0x00007ffffffc0489 in ?? ()
#229 0x0000000000000000 in ?? ()
#230 0x0000000000000000 in ?? ()
#231 0x0000000000000000 in ?? ()
#232 0x0034365f36387800 in ?? ()
#233 0x0000000000000000 in ?? ()
#234 0x0000000000000000 in ?? ()
#235 0x0000000000000000 in ?? ()
#236 0x0000000000000000 in ?? ()
#237 0x0000000000000000 in ?? ()
#238 0x0000000000000000 in ?? ()
#239 0x0000000000000000 in ?? ()
#240 0x0000000000000000 in ?? ()

./sysconfig/i18n:LC_ADDRESS=en_ZA
./sysconfig/i18n:LC_NAME=en_ZA
./sysconfig/i18n:LC_NUMERIC=en_ZA
./sysconfig/i18n:LC_MEASUREMENT=en_ZA
./sysconfig/i18n:LC_IDENTIFICATION=en_ZA
./sysconfig/i18n:LC_TELEPHONE=en_ZA
./sysconfig/i18n:LC_MONETARY=en_ZA
./sysconfig/i18n:LC_PAPER=en_ZA
