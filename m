Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbTGWSAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTGWSAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:00:14 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8021 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S271191AbTGWR7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:59:32 -0400
Message-ID: <3F1ECCD6.5060007@myrealbox.com>
Date: Thu, 24 Jul 2003 01:58:46 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Content-Type: multipart/mixed;
 boundary="------------040307010102000301030103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040307010102000301030103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
            Just found some debug messages like the subject above, from 
the latest kernel compiled with debug options. Attached are the dmesg 
output and the .config file. Not sure if anyone has seen this.

Thanks.


Other relevant info
-------------------------


[root@feynman linux-2.5]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

 
Linux feynman 2.6.0-test1 #5 Tue Jul 22 11:37:12 SGT 2003 i686 i686 i386 
GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         isofs ide_cd cdrom e100 uhci_hcd mousedev hid 
usbcore rtc ext3 jbd





[root@feynman linux-2.5]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 187.200
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 851.96



[root@feynman linux-2.5]# cat /proc/modules
isofs 22980 0 - Live 0xd890b000
ide_cd 38432 0 - Live 0xd88df000
cdrom 33248 1 ide_cd, Live 0xd88ea000
e100 76324 0 - Live 0xd88f7000
uhci_hcd 40904 0 - Live 0xd88d4000
mousedev 7404 2 - Live 0xd8814000
hid 25664 0 - Live 0xd881f000
usbcore 119700 4 uhci_hcd,hid, Live 0xd8840000
rtc 19064 0 - Live 0xd8819000
ext3 109192 4 - Live 0xd8860000
jbd 81304 1 ext3, Live 0xd882b000


[root@feynman linux-2.5]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4
1800-183f : Intel Corp. 82557/8/9 [Ethernet
  1800-183f : e100
1840-1847 : Xircom Mini-PCI V.90 56k Mo
1850-185f : Intel Corp. 82371AB/EB/MB PIIX4
1860-187f : Intel Corp. 82371AB/EB/MB PIIX4
  1860-187f : uhci-hcd




[root@feynman linux-2.5]# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000cd7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0031c36f : Kernel code
  0031c370-003db53f : Kernel data
17ff0000-17ffebff : ACPI Tables
17ffec00-17ffffff : ACPI Non-volatile Storage
50000000-50000fff : Texas Instruments PCI1450
50100000-50100fff : Texas Instruments PCI1450 (#2)
e8000000-e80fffff : Cirrus Logic CS 4614/22/24 [Cryst
e8100000-e811ffff : Intel Corp. 82557/8/9 [Ethernet
  e8100000-e811ffff : e100
e8120000-e8120fff : Intel Corp. 82557/8/9 [Ethernet
  e8120000-e8120fff : e100
e8121000-e8121fff : Xircom Mini-PCI V.90 56k Mo
e8122000-e8122fff : Cirrus Logic CS 4614/22/24 [Cryst
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. 86C270-294 Savage/IX
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443B
fff80000-ffffffff : reserved






--------------040307010102000301030103
Content-Type: application/x-gzip;
 name="output.dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="output.dmesg.gz"

H4sICDzJHj8AA291dHB1dC5kbWVzZwDtmG9rGkEQxt/fpxh81RKNe55nVNpCalKwJE3QpBRK
OdbdOV28P+Zuzyil372zmoS0DS2BggYG5JTbZ5+d2d/M3WKUmunMRmWCuDgQqxCbYnUkPPj6
Rgnfx+Co9+4b6DxayClGsawSS6qjHqnaWt3JOkc9IUlWzlJMoyx3WuclSdW59wqxN4m3XtnW
jiR+HDun7r2oLUMVkKjKklzNH1QBicIHIy3jcGt0u7iXtMPQGclHkQvxROTil8CF6m7yw6LI
i0jl2lm1NGmC7r1kgh0XdrkulUySyF3cDpBm4nkzrfpwfHV8OYRW+wucfD5pjC7OQRdmiXUI
/db8PQykmqF3nZk4L1IYPFIUMMKlKU2e9SE49FveCU6qaR82MEw2hbjKlKVhcKuihrjIUzDZ
UiZGg8oziysL0tItlVQam4nJqlWzuC0xPZz124E3oHlwVUiF/bt8Wi0VIuUTRXsFPoxj1d2E
tUxlRHnMDxwE0uwE6UKqOVra4jSVmd6aERcrbVW+pQR9+A4nDuEIpV7DGHE+yNNFghbh1Inh
x9+MNl/Op+1hpqMCbyosbR+GzYvtWB00LoEc6lCisuQnvG2Z0X2j0A0R0e1aNI+qYyoTuDOC
RgNejTErEea4pnVE+JrEA5lluSWR1JCiNlUKDVc6FLi0ZpIguAqV2+myVDQxEHWgXzfOo+U8
rmakksYVY41W0K7kYWyLStmqwNrv+d7Ksg80rUZLCvHHx99cu08M1bzh+AJ6nY6A05WlVKgL
yOrcqCIv89jCxzwxtNAZLjGB4Gn1aDS8jPxezz/2Fms7c22WVSkWhohv6NsEfGgFYErIJ2Xu
8B0+R/p/Y3yeG9fpHtfpI6roC0E7aWcCPg0HcEaPNldE1wugATifLEr4UNFTWleEZcUlxSX1
T6p8TNj9MYEZ7J7BM97UjGv3uJgBM+C/FpgUd8v+M+BueSmkuFt2z4C75aWQ4m5hBsyAGTAD
ZsAM9oMBn55eCinuFmbADJgBM2AGzGA/GPDp6aWQ4m5hBsyAGTADZsAMmAEzYAbMgBkwA2bA
DPaRwU/twiuwHTsAAA==
--------------040307010102000301030103
Content-Type: application/x-gzip;
 name="config.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.txt.gz"

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
VAAA
--------------040307010102000301030103--

