Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUEJTqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUEJTqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUEJTqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:46:22 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:43360 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S261396AbUEJTqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:46:05 -0400
From: Ricardo Galli <gallir@atlas-iap.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 doesn't boot with 4k stacks
Date: Mon, 10 May 2004 21:46:01 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405102146.01863.gallir@atlas-iap.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps I missed some readme, but just in case. One of my computer, P4HT[*]
dies during booting. There is no log because nothing is still mounted, 
but I took a photograph of the stack dump in the screen.

http://mnm.uib.es/~gallir/tmp/hang1s.jpg

The .config file:
http://mnm.uib.es/~gallir/tmp/2.6.6-bad-config.txt

I unchecked the 4K stack option and it's working nice.


Regards,


[*]
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2799.439
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5554.17

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 9
cpu MHz         : 2799.439
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5586.94

$ lspci
0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3)
0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:02:05.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
0000:02:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:02:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:02:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

 cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 14 sound
116 alsa
128 ptm
136 pts
171 ieee1394
180 usb
195 nvidia

Block devices:
  2 fd
  3 ide0
  8 sd
 22 ide1
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/
  127.0.0.1 sweet 127.0.0.1
