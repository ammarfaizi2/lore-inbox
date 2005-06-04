Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFDQkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFDQkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 12:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFDQkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 12:40:55 -0400
Received: from pop.gmx.de ([213.165.64.20]:35800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261396AbVFDQjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 12:39:52 -0400
X-Authenticated: #222744
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: "John Stoffel" <john@stoffel.org>
Date: Sat, 04 Jun 2005 18:39:45 +1
MIME-Version: 1.0
Subject: Re: kernel 2.2 against 2.4 on old dual-pentium system with intel hx-chipset
Reply-To: Dieter.Ferdinand@gmx.de
Cc: linux-kernel@vger.kernel.org
Message-ID: <42A1F571.31689.62FADD73@localhost>
In-reply-to: <17056.30388.197641.477214@smtp.charter.net>
References: <42A0889D.17491.5D69AF42@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a, DE v4.12a R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i test some kernel 2.4 to 2.4.29 or 30.

at the moment, i use kernel 2.2.23 on the system. the last time, i installed kernel 
2.2.26 i had problems on an other system (system hangs) and i have no time, to 
check why, while this system must work.

i check the hardware of the system with different tools and methods and can't find 
any hardware-error.
i use memtest, test big gzip-achive, compile big programs like gcc and the linux-
kernel to test my systems.

with actual configuration, the systems runs without problems, but on my 
development-system i can use kernel 2.4 only without smp.

i think a long time, the problem comes from a hardware bug, but i can't like it, if i 
don't know, why it don't work and make some tests on a testsystem, which is 
identical with one of my servers except the cpu's are a faster models, both use the 
same gigabyte 586hx-bords with adaptec scsi-controller and 3c905x network 
adapter.

the last test with my testsystem was a test of big gzip-files over the network in dual- 
and single-cpu-mode.
kernel 2.2.23 works fine with two cpu's, kernel 2.4.x (19 or 25) the system hangs 
after a some hours.
with the first 2.4 kernels, i get errors (illegal pointer values for function calls), but no 
more with the newest kernel-versions.

i get no informations from hanging systems.

tests with newer systems with p3-500 are ok, no system crashes with the last testet 
kernels.
i can only test with dual intel hx and bx boards, i have no ppro-system to test, but i 
can send you a compiled kernel or my configuration-file for the newest 2.4-kernel 
and test it on my testsystems if it hangs again.

at the moment i am installing a new server with dual p3-500 and the newest kernel 
2.4.30 or newer.

i can setup my testsystem with an internet-connection, that you can connect to the 
system over the net with teelnet or ssh, to check the system or install other kernels.
a connection to a serial-port is also possible over an internet-connection with a 
second system.
you can make all you want with this system, to find the bug. i have some test-
systems to test hard- and software and kill them with my tests and must recover 
them from an image.

informations from proc-filesystem at the end of the mail!

goodby

ps: i have one BIG BIG problem, i have no need, to search for errors, they will find 
me all.
one example: 4 new harddisk, the first disk is dead after 4 hours, the second works, 
the third is in test at the moment.

Datum:   	Fri, 3 Jun 2005 11:26:44 -0400
Von:            	"John Stoffel" <john@stoffel.org>
An:             	Dieter.Ferdinand@gmx.de
Kopie an:       	linux-kernel@vger.kernel.org
Betreff:        	Re: kernel 2.2 against 2.4 on old dual-pentium system with intel hx-chipset

> 
> Dieter> i have a big problem with my old dual-pentium-systems with
> Dieter> intel hx-chipset (gigabyte and asus mainboards).
> 
> Dieter> if i use kernel 2.2, it works fine. with kernel 2.4 i must
> Dieter> deactivate smp and i can only use one cpu. if i try to use
> Dieter> both cpu's, the system hangs after some ours or after some
> Dieter> times of heavy system-load.
> 
> What version of 2.2 and 2.4 are you using here?  Be specific!  Also,
> send the output of /proc/cpuinfo from both 2.2 and 2.4 along with
> /proc/interrupts as well.  
> 
> Dieter> i try some parameters (noacpi noapic) without success.
> 
> And does the system pass memtest86 for an extended amount of time?
> Say 24 hours?  
> 
> I ran some HP Pavillion Dual processor PPro systems for quite a while
> under kernel 2.4 without major problems.  
> 
> Dieter> can you help me, to get the newer kernel running on this systems ?
> 
> Sure, just post as many details as possible.  
> 
> Do you get any output on the console when the system freezes?  You
> should also look into setting up a serial console along with SysRq so
> you can try to get some debugging output when the next hang happens.  
> 
> John
> 
> 

my dual-pentium server:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 200.459
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
bogomips        : 399.76

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 200.459
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
bogomips        : 400.58

irq's
           CPU0       CPU1       
  0:   85288671          0          XT-PIC  timer
  1:         16          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  3:     421473          0          XT-PIC  serial
  5:      40052          0          XT-PIC  serial
  8:        240          0          XT-PIC  rtc
  9:    9451158          0          XT-PIC  NE2000
 11:         15          0          XT-PIC  aic7xxx
 12:   82322521          0          XT-PIC  aic7xxx, aic7xxx, eth0
 13:          1          0          XT-PIC  fpu
 15:     272319          0          XT-PIC  b1isa-150
NMI:          0
ERR:          0

my development-system:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 198.953
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic mmx
bogomips        : 396.49

irq's
           CPU0       
  0:   43579861          XT-PIC  timer
  1:         28          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     148178          XT-PIC  HiSax
  8:        124          XT-PIC  rtc
  9:     216798          XT-PIC  aha1740
 10:         14          XT-PIC  aha1740
 11:         14          XT-PIC  aha1740
 12:         14          XT-PIC  aha1740
 14:     531367          XT-PIC  aic7xxx
 15:  209677227          XT-PIC  eth0, saa7146(0)
NMI:          0 
LOC:          0 
ERR:         17
MIS:          0

Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

