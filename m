Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVE3CN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVE3CN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 22:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVE3CN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 22:13:59 -0400
Received: from web32601.mail.mud.yahoo.com ([68.142.207.228]:32684 "HELO
	web32601.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261496AbVE3CNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 22:13:14 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=1ZdnNEudhIRJOWgBkZPsesneyR6fSZGWBVtgqw6gwG7fryqyF4slWz+5dRFIl69r1RYbjgKv9Irc0KRYABu8UeQvp+tJSs6Te4M9xkovHHVkePOLBIYbLQ9a3rffjJB3JaKeLitozjF+LS3rajoJsvG0pAGglo/mhd9qLJ7xoas=  ;
Message-ID: <20050530021313.43231.qmail@web32601.mail.mud.yahoo.com>
Date: Sun, 29 May 2005 19:13:13 -0700 (PDT)
From: frank nero <m4rcos2003@yahoo.com>
Subject: oops in kernel 2.6.11.10
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. After an upgrade to the kernel 2.6.11.10 the system
have freezed two times in the span of two days.

2. The 1st opps happen about 2 minutes after i umount
a usb stick. So i power off the computer, wait 10
seconds and power on again and 4 hours later the 2nd
opps happen . Another col

3. keywords? not sure, maybe USB?

4. Linux version 2.6.11.10-ARCH (root@earth) (gcc
version 3.4.3) #1 SMP Mon May 16 14:58:59 PDT 2005

5.   First opps:

May 27 23:34:24 nova usb 1-2: USB disconnect, address
2
May 27 23:34:24 nova usb 1-2.1: USB disconnect,
address 3
May 27 23:36:15 nova Unable to handle kernel NULL
pointer dereference at virtual address 000
00000
May 27 23:36:15 nova printing eip:
May 27 23:36:15 nova c0166630
May 27 23:36:15 nova *pde = 00000000
May 27 23:36:15 nova Oops: 0000 [#1]
May 27 23:36:15 nova PREEMPT SMP
May 27 23:36:15 nova Modules linked in: nls_cp437 vfat
fat usb_storage ipt_TCPMSS ipt_limit
ip_nat_irc ip_nat_ftp iptable_mangle ipt_LOG
ipt_MASQUERADE iptable_nat ipt_TOS ipt_REJECT i
p_conntrack_irc ip_conntrack_ftp ipt_state
ip_conntrack iptable_filter ip_tables ohci_hcd eh
ci_hcd pcspkr rtc snd_via82xx snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
_page_alloc gameport snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore via686a i2c_se
nsor i2c_core uhci_hcd usbcore tsdev evdev parport_pc
lp parport ne 8390 8139too mii
May 27 23:36:15 nova CPU:    0
May 27 23:36:15 nova EIP:    0060:[<c0166630>]    Not
tainted VLI
May 27 23:36:15 nova EFLAGS: 00010213  
(2.6.11.10-ARCH)
May 27 23:36:15 nova EIP is at drop_buffers+0x20/0xa0
May 27 23:36:15 nova eax: 00000000   ebx: c1069fc0  
ecx: 00000000   edx: 00000000
May 27 23:36:15 nova esi: 00000000   edi: caf64e0c  
ebp: c1069fc0   esp: c1709df0
May 27 23:36:15 nova ds: 007b   es: 007b   ss: 0068
May 27 23:36:15 nova Process kswapd0 (pid: 118,
threadinfo=c1708000 task=c16db590)
May 27 23:36:15 nova Stack: c1709eb4 c1069fc0 00000000
c1499578 c1709eb4 c01666f9 c1069fc0 c
1709e10
May 27 23:36:15 nova 00000000 c1709f5c c1069fc0
c149952c c014bff1 c1069fc0 000000d0 00000000

May 27 23:36:15 nova 00000001 00000000 00000007
00000000 c1709e40 c1709e40 00000007 00000001

May 27 23:36:15 nova Call Trace:
May 27 23:36:15 nova [<c01666f9>]
try_to_free_buffers+0x49/0xb0
May 27 23:36:15 nova [<c014bff1>]
shrink_list+0x2a1/0x450
May 27 23:36:15 nova [<c014ad35>]
__pagevec_release+0x25/0x30
May 27 23:36:15 nova [<c014c91d>]
refill_inactive_zone+0x41d/0x4f0
May 27 23:36:15 nova [<c014c320>]
shrink_cache+0x180/0x360
May 27 23:36:15 nova [<c014ca92>]
shrink_zone+0xa2/0xd0
May 27 23:36:15 nova [<c014cf1e>]
balance_pgdat+0x23e/0x3c0
May 27 23:36:15 nova [<c014d184>] kswapd+0xe4/0x140
May 27 23:36:15 nova [<c0136240>]
autoremove_wake_function+0x0/0x60
May 27 23:36:15 nova [<c01031b2>]
ret_from_fork+0x6/0x14
May 27 23:36:15 nova [<c0136240>]
autoremove_wake_function+0x0/0x60
May 27 23:36:15 nova [<c014d0a0>] kswapd+0x0/0x140
May 27 23:36:15 nova [<c0101375>]
kernel_thread_helper+0x5/0x10
May 27 23:36:15 nova Code: 00 00 00 00 8d bc 27 00 00
00 00 55 57 56 53 83 ec 04 8b 6c 24 18
 8b 45 00 f6 c4 10 74 7f 8b 7d 0c 89 f9 90 8d b4 26 00
00 00 00 <8b> 01 f6 c4 04 74 09 8b 45
   10 f0 0f ba 68 44 10 8b 11 8b 41 0c
     May 27 23:36:15 nova <6>note: kswapd0[118] exited
with preempt_count 1

    Second opps:

May 28 04:08:14 nova Unable to handle kernel paging
request at virtual address dfb50fbc
May 28 04:08:14 nova printing eip:
May 28 04:08:14 nova c0166630
May 28 04:08:14 nova *pde = 00000000
May 28 04:08:14 nova Oops: 0000 [#1]
May 28 04:08:14 nova PREEMPT SMP
May 28 04:08:14 nova Modules linked in: ipt_TCPMSS
ipt_limit ip_nat_irc ip_nat_ftp iptable_mangle ipt_LOG
ipt_M
ASQUERADE iptable_nat ipt_TOS ipt_REJECT
ip_conntrack_irc ip_conntrack_ftp ipt_state
ip_conntrack iptable_filte
r ip_tables ohci_hcd ehci_hcd pcspkr rtc snd_via82xx
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
snd_timer
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore via686a i2c_sensor
i2c_core u
hci_hcd usbcore tsdev evdev parport_pc lp parport ne
8390 8139too mii
May 28 04:08:14 nova CPU:    0
May 28 04:08:14 nova EIP:    0060:[<c0166630>]    Not
tainted VLI
May 28 04:08:14 nova EFLAGS: 00010202  
(2.6.11.10-ARCH)
May 28 04:08:14 nova EIP is at drop_buffers+0x20/0xa0
May 28 04:08:14 nova eax: 20001009   ebx: c1384840  
ecx: dfb50fbc   edx: 00000000
May 28 04:08:14 nova esi: 00000000   edi: dfb50fbc  
ebp: c1384840   esp: c1709df0
May 28 04:08:14 nova ds: 007b   es: 007b   ss: 0068
May 28 04:08:14 nova Process kswapd0 (pid: 118,
threadinfo=c1708000 task=c16db590)
May 28 04:08:14 nova Stack: c13b8460 c1384840 00000000
c1499398 c1709eb4 c01666f9 c1384840 c1709e10
May 28 04:08:14 nova 00000000 c1709f5c c1384840
c149934c c014bff1 c1384840 000000d0 00000000
May 28 04:08:14 nova 00000001 00000000 00000000
00000000 c1709e40 c1709e40 00000000 00000001
May 28 04:08:14 nova Call Trace:
May 28 04:08:14 nova [<c01666f9>]
try_to_free_buffers+0x49/0xb0
May 28 04:08:14 nova [<c014bff1>]
shrink_list+0x2a1/0x450
May 28 04:08:14 nova [<c01197cc>]
recalc_task_prio+0x8c/0x160
May 28 04:08:14 nova [<c014ad35>]
__pagevec_release+0x25/0x30
May 28 04:08:14 nova [<c014c91d>]
refill_inactive_zone+0x41d/0x4f0
May 28 04:08:14 nova [<c014c320>]
shrink_cache+0x180/0x360
May 28 04:08:14 nova [<c014ca92>]
shrink_zone+0xa2/0xd0
May 28 04:08:14 nova [<c014cf1e>]
balance_pgdat+0x23e/0x3c0
May 28 04:08:14 nova [<c014d184>] kswapd+0xe4/0x140
May 28 04:08:14 nova [<c0136240>]
autoremove_wake_function+0x0/0x60
May 28 04:08:14 nova [<c01031b2>]
ret_from_fork+0x6/0x14
May 28 04:08:14 nova [<c0136240>]
autoremove_wake_function+0x0/0x60
May 28 04:08:14 nova [<c014d0a0>] kswapd+0x0/0x140
May 28 04:08:14 nova [<c0101375>]
kernel_thread_helper+0x5/0x10
May 28 04:08:14 nova Code: 00 00 00 00 8d bc 27 00 00
00 00 55 57 56 53 83 ec 04 8b 6c 24 18 8b 45 00 f6 c4
10
74 7f 8b 7d 0c 89 f9 90 8d b4 26 00 00 00 00 <8b> 01
f6 c4 04 74 09 8b 45 10 f0 0f ba 68 44 10 8b 11 8b 41
0c
May 28 04:08:14 nova <6>note: kswapd0[118] exited with
preempt_count 1

6. Not sure what trigger this, the first opps culprit
seems to be the usb stick, no idea about the second
opps.

7.1  output of ver_linux:

Linux nova 2.6.11.10-ARCH #1 SMP Mon May 16 14:58:59
PDT 2005 i686 Intel(R) Celeron(TM) CPU               
1000MHz GenuineIntel GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15
util-linux             2.12q
mount                  2.12q
module-init-tools      3.1
e2fsprogs              1.37
reiserfsprogs          3.6.19
reiser4progs           line
PPP                    2.4.3
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      6.0.3
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   057
Modules Loaded         nls_cp437 vfat fat ipt_TCPMSS
ipt_limit ip_nat_irc ip_nat_ftp iptable_mangle ipt_LOG
ipt_MASQUERADE iptable_nat ipt_TOS ipt_REJECT
ip_conntrack_irc ip_conntrac


7.2 cpu info:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU            
   1000MHz
stepping        : 1
cpu MHz         : 998.067
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1961.98

7.3 module information:

nls_cp437 6144 1 - Live 0xe0307000
vfat 14976 1 - Live 0xe0321000
fat 41884 1 vfat, Live 0xe032e000
ipt_TCPMSS 4864 1 - Live 0xe02fa000
ipt_limit 2816 8 - Live 0xe02ff000
ip_nat_irc 2688 0 - Live 0xe02f8000
ip_nat_ftp 3456 0 - Live 0xe02f6000
iptable_mangle 3200 0 - Live 0xe02f1000
ipt_LOG 7808 8 - Live 0xe02a3000
ipt_MASQUERADE 4096 1 - Live 0xe02ec000
iptable_nat 23996 4
ip_nat_irc,ip_nat_ftp,ipt_MASQUERADE, Live 0xe02a8000
ipt_TOS 2816 0 - Live 0xe02a6000
ipt_REJECT 7680 1 - Live 0xe022f000
ip_conntrack_irc 72336 1 ip_nat_irc, Live 0xe02ce000
ip_conntrack_ftp 73360 1 ip_nat_ftp, Live 0xe02bb000
ipt_state 2176 8 - Live 0xe02a1000
ip_conntrack 44488 7
ip_nat_irc,ip_nat_ftp,ipt_MASQUERADE,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp,ipt_state,
Live 0xe02af000
iptable_filter 3328 1 - Live 0xe022d000
ip_tables 23936 10
ipt_TCPMSS,ipt_limit,iptable_mangle,ipt_LOG,ipt_MASQUERADE,iptable_nat,ipt_TOS,ipt_REJECT,ipt_state,iptable_filter,
Live 0xe0292000
ohci_hcd 23048 0 - Live 0xe029a000
ehci_hcd 36488 0 - Live 0xe0215000
pcspkr 4044 0 - Live 0xe01a1000
rtc 13260 0 - Live 0xe0228000
snd_via82xx 29376 1 - Live 0xe021f000
snd_ac97_codec 79352 1 snd_via82xx, Live 0xe025b000
snd_pcm_oss 56224 0 - Live 0xe024c000
snd_mixer_oss 21120 2 snd_pcm_oss, Live 0xe01fe000
snd_pcm 98564 3
snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live
0xe0232000
snd_timer 27268 1 snd_pcm, Live 0xe01ca000
snd_page_alloc 10244 2 snd_via82xx,snd_pcm, Live
0xe01fa000
gameport 5120 1 snd_via82xx, Live 0xe019e000
snd_mpu401_uart 8832 1 snd_via82xx, Live 0xe01c6000
snd_rawmidi 26144 1 snd_mpu401_uart, Live 0xe01f2000
snd_seq_device 8972 1 snd_rawmidi, Live 0xe01bb000
snd 59492 9
snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xe0205000
soundcore 10848 2 snd, Live 0xe01b7000
via686a 20760 0 - Live 0xe01bf000
i2c_sensor 3968 1 via686a, Live 0xe019c000
i2c_core 23296 2 via686a,i2c_sensor, Live 0xe016e000
uhci_hcd 33424 0 - Live 0xe01ad000
usbcore 125560 4 ohci_hcd,ehci_hcd,uhci_hcd, Live
0xe01d2000
tsdev 8256 0 - Live 0xe018a000
evdev 9984 0 - Live 0xe0186000
parport_pc 29252 1 - Live 0xe01a4000
lp 12548 0 - Live 0xe0181000
parport 38600 2 parport_pc,lp, Live 0xe018e000
ne 8004 0 - Live 0xe0165000
8390 11264 1 ne, Live 0xe017d000
8139too 28160 0 - Live 0xe0175000
mii 5760 1 8139too, Live 0xe0168000
7.4

cat /proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : ISAPnP
0260-0267 : pnp 00:0b
0280-029f : ne
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f2-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
d000-d00f : 0000:00:07.1
d000-d007 : ide0
d008-d00f : ide1
d400-d41f : 0000:00:07.2
d400-d41f : uhci_hcd
d800-d81f : 0000:00:07.3
d800-d81f : uhci_hcd
dc00-dcff : 0000:00:07.5
dc00-dcff : VIA686A
e000-e003 : 0000:00:07.5
e000-e003 : VIA686A
e400-e403 : 0000:00:07.5
e400-e403 : VIA686A
e800-e8ff : 0000:00:0b.0
e800-e8ff : 8139too


cat /proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-1f7fffff : System RAM
00100000-004fd6d4 : Kernel code
004fd6d5-006329ff : Kernel data
e0000000-e3ffffff : 0000:00:00.0
e4000000-e6ffffff : PCI Bus #01
e5000000-e57fffff : 0000:01:00.0
e5800000-e5ffffff : 0000:01:00.0
e6000000-e601ffff : 0000:01:00.0
e8000000-e80000ff : 0000:00:0b.0
e8000000-e80000ff : 8139too
ffff0000-ffffffff : reserved

lspci -vvv:



00:00.0 Host bridge: VIA Technologies, Inc. VT8601
[Apollo ProMedia] (rev 05)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
Latency: 8
Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=64M]
Capabilities: [a0] AGP version 2.0
Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8601
[Apollo ProMedia AGP] (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
Latency: 0
Bus: primary=00, secondary=01, subordinate=01,
sec-latency=0
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: e4000000-e6ffffff
Prefetchable memory behind bridge: fff00000-000fffff
BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset-
FastB2B-
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686
[Apollo Super South] (rev 40)
Subsystem: VIA Technologies, Inc. VT82C686/A PCI to
ISA Bridge
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 0
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
Subsystem: VIA Technologies, Inc. VT8235 Bus Master
ATA133/100/66/33 IDE
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32
Region 4: I/O ports at d000 [size=16]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB
(rev 1a) (prog-if 00 [UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB
Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32, cache line size 08
Interrupt: pin D routed to IRQ 11
Region 4: I/O ports at d400 [size=32]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.3 USB Controller: VIA Technologies, Inc. USB
(rev 1a) (prog-if 00 [UHCI])
Subsystem: VIA Technologies, Inc. (Wrong ID) USB
Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32, cache line size 08
Interrupt: pin D routed to IRQ 11
Region 4: I/O ports at d800 [size=32]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686
[Apollo Super ACPI] (rev 40)
Subsystem: VIA Technologies, Inc. VT82C686 [Apollo
Super ACPI]
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Capabilities: [68] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies,
Inc. VT82C686 AC97 Audio Controller (rev 50)
Subsystem: Realtek Semiconductor Co., Ltd.: Unknown
device 4710
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin C routed to IRQ 3
Region 0: I/O ports at dc00 [size=256]
Region 1: I/O ports at e000 [size=4]
Region 2: I/O ports at e400 [size=4]
Capabilities: [c0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor
Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
Subsystem: Unknown device 00a2:00c0
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (8000ns min, 16000ns max)
Interrupt: pin A routed to IRQ 11
Region 0: I/O ports at e800 [size=256]
Region 1: Memory at e8000000 (32-bit,
non-prefetchable) [size=256]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:00.0 VGA compatible controller: Trident
Microsystems CyberBlade/i1 (rev 6a) (prog-if 00 [VGA])
Subsystem: Trident Microsystems CyberBlade/i1
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32
Interrupt: pin A routed to IRQ 10
Region 0: Memory at e5800000 (32-bit,
non-prefetchable) [size=8M]
Region 1: Memory at e6000000 (32-bit,
non-prefetchable) [size=128K]
Region 2: Memory at e5000000 (32-bit,
non-prefetchable) [size=8M]
Expansion ROM at <unassigned> [disabled] [size=64K]
Capabilities: [80] AGP version 2.0
Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
Capabilities: [90] Power Management version 1
Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 32, cache line size 08
Interrupt: pin D routed to IRQ 11
Region 4: I/O ports at d800 [size=32]
Capabilities: [80] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-


7.6 SCSI information: no scsi devices.





		
__________________________________
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html
