Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSATALL>; Sat, 19 Jan 2002 19:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSATALC>; Sat, 19 Jan 2002 19:11:02 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:56556 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S287743AbSATAKt>; Sat, 19 Jan 2002 19:10:49 -0500
From: "Roland Schwarz" <schw4702@uni-trier.de>
To: "Linux Kernel MailingListe" <linux-kernel@vger.kernel.org>
Subject: Problem with network devices
Date: Sun, 20 Jan 2002 01:09:34 +0100
Message-ID: <ENEMLHMAAMHHCIBOKBBCMEHAEJAA.schw4702@uni-trier.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there ,

i have a small problem with my linux system.
Behaviour :
System runs for an amout of time, then the below messages begin, and after a
while the network connection is not working anymore. removeing and reloading
the module for the network card doesnt work, only a reboot helps.
Another interesting phenomen is during the system startup, after the message
"checking the halt instr." the system simply reboots.
no explanation. no entry in system log, nothing.


Below is a cut from the system log, maybe someone of you has an idea what i
could do to solve this.
The kernel used is a 2.4.10 from the Suse 7.3 distribution, compiled to work
in smp mode,
It's a P2-300 Dual, with a Gigabyte mainboard, scsi uw onboard, 256 Mb Ram,
now three 3com network cards,permedia2 agp graphics card.



Jan 18 00:18:49 highfidelity kernel: APIC error on CPU0: 00(02)
[...]
Jan 17 10:18:20 highfidelity kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Jan 17 10:18:20 highfidelity kernel: eth0: transmit timed out, tx_status 00
status e601.
Jan 17 10:18:20 highfidelity kernel:   diagnostics: net 0cd8 media 8880 dma
0000003a.
Jan 17 10:18:20 highfidelity kernel: eth0: Interrupt posted but not
delivered -- IRQ blocked by another device?
Jan 17 10:18:20 highfidelity kernel:   Flags; bus-master 1, dirty
11892733(13) current 11892733(13)
Jan 17 10:18:20 highfidelity kernel:   Transmit list 00000000 vs. cf505540.
Jan 17 10:18:20 highfidelity kernel:   0: @cf505200  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   1: @cf505240  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   2: @cf505280  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   3: @cf5052c0  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   4: @cf505300  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   5: @cf505340  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   6: @cf505380  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   7: @cf5053c0  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   8: @cf505400  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   9: @cf505440  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   10: @cf505480  length 80000036 status
00010036
Jan 17 10:18:20 highfidelity kernel:   11: @cf5054c0  length 8000002a status
8001002a
Jan 17 10:18:20 highfidelity kernel:   12: @cf505500  length 8000002a status
8001002a
Jan 17 10:18:20 highfidelity kernel:   13: @cf505540  length 800000ed status
000100ed
Jan 17 10:18:20 highfidelity kernel:   14: @cf505580  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel:   15: @cf5055c0  length 800000ff status
000100ff
Jan 17 10:18:20 highfidelity kernel: eth0: Resetting the Tx ring pointer.
Jan 17 10:18:35 highfidelity kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Jan 17 10:18:35 highfidelity kernel: eth0: transmit timed out, tx_status 00
status e601.
Jan 17 10:18:35 highfidelity kernel:   diagnostics: net 0cd8 media 8880 dma
0000003a.
Jan 17 10:18:35 highfidelity kernel: eth0: Interrupt posted but not
delivered -- IRQ blocked by another device?
Jan 17 10:18:35 highfidelity kernel:   Flags; bus-master 1, dirty
11892749(13) current 11892749(13)


[...repeats some times ... ]


cat interrupts

           CPU0       CPU1
  0:    1679470    1580287    IO-APIC-edge  timer
  1:       1826       2261    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          1    IO-APIC-edge  rtc
 14:      48311      49974    IO-APIC-edge  ide0
 15:      64430      48097    IO-APIC-edge  ide1
 16:    1634726    1532488   IO-APIC-level  aic7xxx, eth0
 17:    1779173    1806755   IO-APIC-level  eth1
 19:       5653       5089   IO-APIC-level  usb-uhci, eth2
NMI:          0          0
LOC:    3259912    3259911
ERR:        431
MIS:          6


cpu_info ... oh, not nice ...

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.686
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov mmx
bogomips        : 599.65

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 300.686
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 601.29



Thanks for any idea an help !


Greetings and a nice weekend !

Roland

