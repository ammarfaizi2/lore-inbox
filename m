Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267836AbUGWQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267836AbUGWQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267837AbUGWQo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:44:57 -0400
Received: from outfbmx006.isp.belgacom.be ([195.238.3.101]:4319 "EHLO
	outfbmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S267836AbUGWQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 12:44:48 -0400
Message-ID: <4100F899.7050501@skynet.be>
Date: Fri, 23 Jul 2004 13:38:01 +0200
From: "Gerard H. Pille" <g.h.p@skynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: nl-BE, nl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.8 breaks pop3, telnet
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.
2.6.8 breaks pop3, telnet

2.
hallo,

on a number of systems that I upgraded from 2.6.6 and 2.6.7 to 2.6.8, mozilla
can no longer access my pop3 mail account, neither can I when using telnet:

telnet pop3.skynet.be 110
Trying 195.238.3.116...
Connected to pop3pool1.skynet.be.
Escape character is '^]'.
+OK Skynet POP3 Ready pop3pool1.skynet.be
user XXXXXX
+OK USER XXXXXX set
pass YYYYYY
+OK You are so in
UIDL
+OK uidl command accepted.


and the connection hangs until I interrupt it.  Same thing when I try this from
tcl/tk (wish).  strace shows it hangs on recv on Redhat, on a Debian system it
showed select.

patch-2.6.8-rc2 is +3Mb zipped, so if anyone would know where to start looking,
much appreciated!

3.
2.6.8-rc2, telnet, pop3, recv(), select()

4.
2.6.7 : OK
2.6.8-rc2 : broken, I am quite sure the same goes for 2.6.8-rc1

6.
see above

7.1Linux sky82915.localnet 2.6.7 #2 SMP Wed Jul 21 20:40:15 CEST 2004 i686 unknown

Gnu C                  3.3
Gnu make               3.79.1
binutils               2.13.90.0.18
util-linux             2.11n
mount                  2.10f
module-init-tools      0.9.15-pre2
e2fsprogs              1.27
PPP                    2.4.0
nfs-utils              0.1.9.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5..
Procps                 2.0.6
Net-tools              1.54
Kbd                    1.06
Sh-utils               2.0i
Modules Loaded         ide_cd cdrom ipt_TCPMSS ipt_state ppp_async ppp_generic 
slhc evdev nvidia parport_pc lp parport snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi 
snd_seq_device snd ipt_LOG ipt_limit ipt_MASQUERADE iptable_nat ip_conntrack 
iptable_filter ip_tables e1000 wacom mousedev psmouse uhci_hcd

7.2  (but had the same on P4 without SMP/HT)
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 3006.941
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5947.39

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 9
cpu MHz         : 3006.941
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5996.54

7.3
ide_cd 42372 1 - Live 0xf9a8f000
cdrom 39072 1 ide_cd, Live 0xf9a84000
ipt_TCPMSS 4864 1 - Live 0xf9a68000
ipt_state 2432 7 - Live 0xf9a54000
ppp_async 12800 1 - Live 0xf9a63000
ppp_generic 27028 5 ppp_async, Live 0xf9a5b000
slhc 7552 1 ppp_generic, Live 0xf9a4f000
evdev 9600 1 - Live 0xf9a4b000
nvidia 4820020 12 - Live 0xf9ed8000
parport_pc 28832 1 - Live 0xf99db000
lp 10788 0 - Live 0xf99b6000
parport 41928 2 parport_pc,lp, Live 0xf9964000
snd_pcm_oss 63272 0 - Live 0xf99ca000
snd_mixer_oss 21888 1 snd_pcm_oss, Live 0xf997a000
snd_intel8x0 32136 1 - Live 0xf9971000
snd_ac97_codec 73348 1 snd_intel8x0, Live 0xf99a3000
snd_pcm 112288 2 snd_pcm_oss,snd_intel8x0, Live 0xf9986000
snd_timer 29828 1 snd_pcm, Live 0xf9941000
snd_page_alloc 12552 2 snd_intel8x0,snd_pcm, Live 0xf9934000
snd_mpu401_uart 9472 1 snd_intel8x0, Live 0xf993d000
snd_rawmidi 27968 1 snd_mpu401_uart, Live 0xf995c000
snd_seq_device 9096 1 snd_rawmidi, Live 0xf9939000
snd 67844 11 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xf994a000
ipt_LOG 6784 4 - Live 0xf98ae000
ipt_limit 2944 4 - Live 0xf98b4000
ipt_MASQUERADE 4608 4 - Live 0xf98b1000
iptable_nat 25380 2 ipt_MASQUERADE, Live 0xf990b000
ip_conntrack 36228 3 ipt_state,ipt_MASQUERADE,iptable_nat, Live 0xf98f0000
iptable_filter 3200 1 - Live 0xf988e000
ip_tables 18944 7 
ipt_TCPMSS,ipt_state,ipt_LOG,ipt_limit,ipt_MASQUERADE,iptable_nat,iptable_filter, 
Live 0xf98a6000
e1000 75652 0 - Live 0xf98b8000
wacom 13056 0 - Live 0xf9885000
mousedev 10384 1 - Live 0xf988a000
psmouse 19976 0 - Live 0xf9899000
uhci_hcd 32656 0 - Live 0xf9890000

7.4
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
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-047f : 0000:00:1f.0
0480-04bf : 0000:00:1f.0
0500-051f : 0000:00:1f.3
0778-077a : parport0
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #02
   a000-a01f : 0000:02:01.0
     a000-a01f : e1000
b000-b01f : 0000:00:1d.0
   b000-b01f : uhci_hcd
b400-b41f : 0000:00:1d.1
   b400-b41f : uhci_hcd
b800-b81f : 0000:00:1d.2
   b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:1d.3
   bc00-bc1f : uhci_hcd
c000-c007 : 0000:00:1f.2
   c000-c007 : libata
c400-c403 : 0000:00:1f.2
   c400-c403 : libata
c800-c807 : 0000:00:1f.2
   c800-c807 : libata
cc00-cc03 : 0000:00:1f.2
   cc00-cc03 : libata
d000-d00f : 0000:00:1f.2
   d000-d00f : libata
d800-d8ff : 0000:00:1f.5
dc00-dc3f : 0000:00:1f.5
f000-f00f : 0000:00:1f.1
   f000-f007 : ide0
   f008-f00f : ide1

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-002f1366 : Kernel code
   002f1367-003ad57f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : 0000:00:1f.1
e0000000-e7ffffff : 0000:00:00.0
e8000000-f7ffffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
   f0000000-f007ffff : 0000:01:00.0
f8000000-f9ffffff : PCI Bus #01
   f8000000-f8ffffff : 0000:01:00.0
     f8000000-f8ffffff : nvidia
fa000000-faffffff : 0000:03:06.0
   fa000000-faffffff : cx8800[0]
fb000000-fb0fffff : PCI Bus #02
   fb000000-fb01ffff : 0000:02:01.0
     fb000000-fb01ffff : e1000
fb100000-fb1003ff : 0000:00:1d.7
fb102000-fb1021ff : 0000:00:1f.5
   fb102000-fb1021ff : Intel ICH5 - AC'97
fb103000-fb1030ff : 0000:00:1f.5
   fb103000-fb1030ff : Intel ICH5 - Controller
fec00000-ffffffff : reserved

Gerard H. Pille

