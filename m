Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTIHOvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTIHOvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:51:35 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:31726 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262544AbTIHOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:51:27 -0400
Subject: kernel 2.4.22's AIC7(triple x) driver not working anymore
From: Moal Tanguy <tanguy.moal.tux@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063032626.5032.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 08 Sep 2003 16:50:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I sent this message here because I don't where to send it!
Please redirect this message or read it if you can help
(I feel like talking with some kind of a god!)

There is the bug report. I hope it is completely clear and
understandable. 
Don't blame me for any grammar or spelling things, Sheakspire's language
isn't my cup of tea, but it seems to be a universal language.
:-)
Don't be affraid to reply me, I won't blame anyone.

[1.] One line summary of the problem: aic7xxx driver fails to
scan/probe? a hard drive
[2.] Full description of the problem/report: 
During the boot up, when the scsi card is being initialized (an adaptec 
19160B one) a hard drive (an IBM 9.1 GB 10krpm one) fails to load : the 
following message was printed on the screen :
Unexpected busfree while idle
[3.] Keywords (i.e., modules, networking, kernel): kernel : aic7xxx
[4.] Kernel version (from /proc/version) : 
Linux version 2.4.22 (root@localhost.localdomain) (version gcc 3.2.3 
20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2 lun sep 8 12:51:17
CEST 2003
[5.] Output of Oops : no Oops :-)
[6.] A small shell script :
Sorry but this problem isn't linked to any program/application, it 
happened during boot up, before the prompt.
[7.] Environment
[7.1.] Software :

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost.localdomain 2.4.22 #2 lun sep 8 12:51:17 CEST 2003 i686
AMD Athlon(tm) Processor AuthenticAMD GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.33
reiserfsprogs          3.6.8
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         nvidia 8139too mii crc32
[7.2.] Processor information (from /proc/cpuinfo)

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 4
cpu MHz		: 1400.064
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2791.83

[7.3.] Module information (from /proc/modules):

nvidia               1630784  11
8139too                15592   1
mii                     2528   0 [8139too]
crc32                   2880   0 [8139too]
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9800-98ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  9800-98ff : 8139too
a000-a0ff : Adaptec AIC-7892B U160/m
a400-a4ff : C-Media Electronics Inc CM8738
  a400-a4ff : cmpci
d000-d01f : VIA Technologies, Inc. USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  d800-d807 : ide0
e000-e003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller
e300-e37f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d93ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-0031ef35 : Kernel code
  0031ef36-003d9283 : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
cd000000-cd0000ff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  cd000000-cd0000ff : 8139too
cd800000-cd800fff : Adaptec AIC-7892B U160/m
  cd800000-cd800fff : aic7xxx
ce000000-cf5fffff : PCI Bus #01
  ce000000-ceffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
cf700000-df7fffff : PCI Bus #01
  cf800000-cf87ffff : nVidia Corporation NV20 [GeForce3 Ti 200]
  d0000000-d7ffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
    d0000000-d05fffff : vesafb
df800000-df800fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P]
System Controller
e0000000-efffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P]
System Controller
ffff0000-ffffffff : reserved

[7.5.]  PCI information ('lspci -vvv' as root):

no lspci on my system...
:-(

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K3_36_WLS Rev: 020K
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0d
  Type:   CD-ROM                           ANSI SCSI revision: 02
[7.7.] Other information :
We should see at 7.6 one more device looking something like that:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: xxxx
  Type:   Direct-Access                    ANSI SCSI revision: xx
(replacing x's by the appripriate values, I don't remember them)

Which is weird, is the fact that the same thing happened first with
gentoo sources of kernel 2.4.20-gentoo... Then I decided to get the
sources from kernel.org 2.4.21 it worked great! Then 2.4.22 went out
I downloaded it and installed and then, exactly the same error!
I will now shutdown my computer and check for any plugging error
(i.e. scsi id's or something)
I will also check adaptec website for any firmware update.
And then I'll try to get the full verbose output from the kernel
during next boot up
Finally I will send this e-mail.


I checked everything and used Adaptec SCSI Select(TM) utilities to
do a scandisk on each devices but the same error applies.
In addition, I quote the output on the screen during boot and it says 
the following:

scsi0: Unexpected busfree while idle
SEQADDR ==0x1

May be this can help?

For now, I well replaces the source subtree  aic7xxx in the
2.4.22/drivers/scsi
 by the one in 2.4.21/drivers/scsi to see if the problem is there...
I'll post the e-mail message later.

I did the replacement and built a knew kernel image. It works with the
older aic7xxx subtree (present in 2.4.21) and everything seems alright.
I will send this e-mail message know. I hope it will help. At least I
would be glade If someone could explain me what's going wrong and better
if a patch could published.
Best regards, Mr Moal Tanguy tanguy.moal.tux@wanadoo.fr.




