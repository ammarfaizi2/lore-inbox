Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129655AbQK1Bhy>; Mon, 27 Nov 2000 20:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129764AbQK1Bhn>; Mon, 27 Nov 2000 20:37:43 -0500
Received: from pc-62-31-77-22-tw.blueyonder.co.uk ([62.31.77.22]:14090 "EHLO
        linux.scot-mur.demon.co.uk") by vger.kernel.org with ESMTP
        id <S129655AbQK1Bh3>; Mon, 27 Nov 2000 20:37:29 -0500
Date: Tue, 28 Nov 2000 01:07:38 +0000
From: rob@mur.org.uk
To: linux-kernel@vger.kernel.org
Subject: Problems with D-link DFE550TX in 2.4.0-test10
Message-ID: <20001128010738.J18097@scot-mur.demon.co.uk>
Mail-Followup-To: rob@mur.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Resending due to no reply

Any ideas what's wrong?

At boot, I get the following messages:

eth0: OEM Sundance Technology ST201 at 0xc8800000, 00:50:ba:14:de:30, IRQ 10.
eth0: No MII transceiver found!, ASIC status 62

it works a bit, but it freezes every so often. The card is plugged
into a 10/100 switch. When it freezes, I get the following messages:
(The link changed messages happen when I unplug the cable and put it
back in.)

Nov 24 22:44:40 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 22:53:46 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 22:53:46 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 22:53:46 linux kernel:   Rx ring c13fc940:  0000803c 0000803c 0000804c 0000803c 0000804c 0000804a 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000804c 0000803c 0000804c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000804a 00008042 0000804a 0000804a 0000803c 0000804c
Nov 24 22:53:46 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 22:56:25 linux kernel: eth0: Link changed: Autonegotiation advertising ffff  partner ffff.
Nov 24 22:56:31 linux kernel: eth0: Link changed: Autonegotiation advertising ffff  partner ffff.
Nov 24 23:11:59 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:13:36 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:13:36 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:13:36 linux kernel:   Rx ring c13fc940:  0000803e 00008044 00008044 0000804a 00008044 0000804a 00008044 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 0000803c 00008044 0000803c 0000803c 0000803c 0000803c 00008044 00008044 00008044 0000803c 0000803c 0000803c 0000803c 0000803c 0000803e 0000803e
Nov 24 23:13:36 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:13:44 linux kernel: eth0: Link changed: Autonegotiation advertising ffff  partner ffff.
Nov 24 23:13:49 linux kernel: eth0: Link changed: Autonegotiation advertising ffff  partner ffff.
Nov 24 23:15:33 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0000.
Nov 24 23:15:42 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:15:42 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:15:42 linux kernel:   Rx ring c13fc940:  00008062 00008048 00008062 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 00008062 0000803c 0000803c 0000803c 0000803c 00008062 0000803c 00008062 00008042 00008046 00008062 00008062
Nov 24 23:15:42 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:18:15 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:18:24 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:18:24 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:18:24 linux kernel:   Rx ring c13fc940:  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 0000803c 00008062 0000803c 00008062 0000803c 00008062 0000803e 0000803c 00008062 0000803c 00008062 00008040 0000803c 00000000
Nov 24 23:18:24 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:23:49 linux kernel: spurious 8259A interrupt: IRQ15.
Nov 24 23:25:29 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:25:36 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:25:36 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:25:36 linux kernel:   Rx ring c13fc940:  00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 0000803c 0000803c 00008062 0000803c 00008062 0000803c 0000803c 00008062 0000803c 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 24 23:25:36 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:26:10 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:26:20 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:26:20 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:26:20 linux kernel:   Rx ring c13fc940:  0000803c 00008062 0000803c 0000803c 0000803c 00008062 0000803c 0000803c 00008062 0000803c 00008062 0000803c 0000803c 0000803c 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 0000803c 00008062 0000803c 00008062 0000803c 00008062
Nov 24 23:26:20 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:26:56 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:27:06 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:27:06 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:27:06 linux kernel:   Rx ring c13fc940:  00008062 0000803c 00008062 0000803c 0000803c 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 0000803c 0000803c 0000803c 00008062 0000803c 0000803c 00008062 00008062 0000803c
Nov 24 23:27:06 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c
Nov 24 23:29:25 linux kernel: eth0: Too much work at interrupt, status=0x0011 / 0x0401.
Nov 24 23:29:34 linux kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 24 23:29:34 linux kernel: eth0: Transmit timed out, status c0, resetting...
Nov 24 23:29:34 linux kernel:   Rx ring c13fc940:  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000803c 0000803c 0000803c 00008062 0000803c 0000803c 0000803c 00008062 00008062 0000803e 00008062 00008062 0000803e 00008062 00008062 00000000 00000000 00000000 00000000
Nov 24 23:29:34 linux kernel:   Tx ring c13fcb40:  80018000 80018004 80018008 8001800c 80018010 80018014 80018018 8001801c 80018020 80018024 80018028 8001802c 80018030 80018034 80018038 8001803c

Script started on Fri Nov 24 23:39:51 2000
linux:/hdb/robbie/src/netdiag#./alta-diag 
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xd000.
  Receive mode is 0x15: Normal unicast and hashed multicast.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0000: No interrupts pending.
  Station address 00:50:ba:14:de:30.
 Use '-a' or '-aa' to show device registers,
     '-e' to show EEPROM contents, -ee for parsed contents,
  or '-m' or '-mm' to show MII management registers.
linux:/hdb/robbie/src/netdiag#./alta-diag -m
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xd000.
  Receive mode is 0x15: Normal unicast and hashed multicast.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0000: No interrupts pending.
  Station address 00:50:ba:14:de:30.
 MII PHY found at address 1, status 0x782d.
 MII PHY #1 transceiver registers:
   3000 782d 0016 f880 01e1 45e1 ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0022 ff40 00d0 ffc0 0008 ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff.
 MII PHY #1 transceiver registers:
   3000 782d 0016 f880 01e1 45e1 ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff
   0022 ff40 00d0 ffc0 0010 ffff ffff ffff
   ffff ffff ffff ffff ffff ffff ffff ffff.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:05:be:--:--:--, model 8 rev. 0.
   No specific information is known about this transceiver type.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Negotiation  completed.
linux:/hdb/robbie/src/netdiag#./alta-diag -e
alta-diag.c:v2.00 4/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Sundance Technology Alta adapter at 0xd000.
  Receive mode is 0x15: Normal unicast and hashed multicast.
  MAC mode is 0000: half duplex.
  Tx status 00, threshold 8188.
  Interrupt status is 0000: No interrupts pending.
  Station address 00:50:ba:14:de:30.
EEPROM Subsystem IDs, Vendor 1186 Device 1002.
  EEPROM Station address is 00:50:ba:14:de:30.
  Configuration 2af8, ASIC Control c062.
linux:/hdb/robbie/src/netdiag#./mii-diag 
Using the default interface 'eth0'.
Basic registers of MII PHY #1:  ffff ffff ffff ffff ffff ffff ffff ffff.
  No MII transceiver present!.
linux:/hdb/robbie/src/netdiag#cat /proc/interrupts
           CPU0       
  0:     481945          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:      15005          XT-PIC  serial
  4:      23207          XT-PIC  serial
  5:    9379947          XT-PIC  ide2, ide3
 10:      11823          XT-PIC  eth0
 11:    9587177          XT-PIC  ide6, ide7
 12:    9323271          XT-PIC  ide4, ide5
 13:          0          XT-PIC  fpu
 14:     115651          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:        113
linux:/hdb/robbie/src/netdiag#cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.000031
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 897.84

linux:/hdb/robbie/src/netdiag#lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:0b.0 SCSI storage controller: Adaptec AIC-7880U
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
00:13.0 Ethernet controller: D-Link System Inc: Unknown device 1002
00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
linux:/hdb/robbie/src/netdiag#exit
exit

Script done on Fri Nov 24 23:43:44 2000

The kernel is 2.4.0-test10 with the reiserfs patch. It's an smp system
with 2 pii450s, but I'm booting with "nosmp noapic" because of
stability problems.

Regards


-- 
Rob Murray
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
