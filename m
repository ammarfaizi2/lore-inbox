Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTLCA3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLCA3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:29:34 -0500
Received: from legolas.restena.lu ([158.64.1.34]:6635 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264443AbTLCA3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:29:05 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Craig Bradney <cbradney@zip.com.au>
To: b@netzentry.com
Cc: ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pomac@vapor.com, forming@charter.net
In-Reply-To: <3FCD21E1.5080300@netzentry.com>
References: <3FCD21E1.5080300@netzentry.com>
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1070411338.2452.66.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 01:28:58 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jump down for my replies..


On Wed, 2003-12-03 at 00:36, b@netzentry.com wrote:
> Regardless of BIOS version, doesnÿt the kernel get to
> fix values if things are "wrong?" I've seen this message
> on several boards where various tables and ACPI and APIC
> things are "fixed up." The only reason I want to find out so bad
> is that board survives unusual amounts of abuse on Windows 2000. (I 
> havent been able to hang Windows as Prakash had.)
> 
> Right now I can't even afford to test 2.6.0.test11 in terms
> of time but very similar problems exist in 2.4, suggesting
> something fundamental?
> 
> About the IDE, it seems to be the easiest way to promote the
> problem but time seems to be the biggest factor. Some have
> suggested wrt this NFORCE2 problem that idle time makes it
> worse, but I've seen the hang under both conditions.

Not idle time.. my PC idles (with KDE/xchat/evolution running , if that
is idling :)) while i am out or sleeping.. thats at least 4 hours non
stop per day...

> I have a very minimal set of things running on this board, I
> shut off the USB1.x and 2.0 controller, jumpered the Si SATA
> off and turned of Audio and the NVIDIA Lan. (Prakash suggested
> the Si SATA was the evil but I have it jumpered off.)

Audio on and used, USB 2.0, 1.x on but nothing plugged, NVIDIA lan off,
3com lan on and connected at 100Mbit.

> For me the formula to reproduce this problem is this simple:
> - Do anything (including passing the noapic nolapix noapixio etc)
> in a UP-kernel with APIC compiled in, get hang.
> - To avoid the problem, recompile the UP-kernel with APIC turned
> off.
> 
> What probably isnt the problem:
> - Motherboard flavor (This problem has cropped up on all nforce2 boards)

 a7n8x deluxe v2 with standard clocked athlon xp 2600+

> - BIOS (This problem can change nature with a BIOS rev, but I havent 
> seen it go away and I tried several).

 bios 1007.

> - SATA - problem appears even if SATA is shut off via jumper, as does Craig.

SATA is shut off on jumper. no SATA in kernel

> - Memory - I swapped memory in a test to see. I also tried the dual 
> channel and the single channel mode. No change.

dual channel 2x256mb

> - SMP / UP / passed flags Julien said: "I run strictly non-SMP kernels 
> and they always crash if APIC (or local APIC?) is enabled." - I see the 
> same things.

smp off, preempt off. lapic on, apic on, acpi on

> (Julien also suggest a quick way to see if the system is stable: type 
> hdparm -t /dev/hd<someharddrive> several times).

as my uptime below suggests.. that didnt hurt a thing. I havent rebooted
since that test.

> - ASUS. I have a rev2.0 PCB, and several rev 1.x PCB, and they all 
> suffer. Others also report boards from different manufacturers hanging 
> with the NFORCE2. (Prakash: Abit NF7-S V2.0), Lenar (Epox 8RDA+ , 8RDA3+  )
> - Kernel 2.4 or 2.6 specifically. This problem occurs both in later 2.6 
> builds and 2.4.23 (and below)
> - IDE (NFORCE/AMD IDE driver in kernel) It seems the problem is easily 
> exacerbated by IDE, but I think that this is not the root cause. In 
> NO-APIC mode the IDE behaves reliably.
> 
> 
> Craig said he ran it for 18 hours with abuse, including Juliens hdparm 
> test.


Uptime is 4 days 1:55 and counting...


Things I can remember running in that time:
apache, mysql, proftpd, kde, evolution, xchat2, mozilla, konsole,
scribus, any updates including gcc 3.2.3 from 3.2.2 that came through
gentoo's portage system, gcc recompilation of scribus quite often (cvs
updates and own coding), gdb for about 3 hours finding one scribus
segfault testing over and over again with many crashes (fixed now btw
for those scribus users out there :)) 


> -> Craig, which kernel are you using? Distro (RedHat Taroon's kernel has 
> LAPIC turned off)? PCB Rev of motherboard? Bios revision? Whats the 
> lspci, cat /proc/interrupts look like? dmesg?

I'm using Gentoo's gentoo-dev-sources 2.6.0_beta11 which is 2.6 test11
plus the patches to be found at:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.6/

They have released a 2.6_beta11-r1 that I ahvent upgraded to which uses 
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.7/

and i notice there is a 0.8 directory.


So.. sorry if my comments have misled.. its not exactly standard 2.6 now
that I do check it. There is one nvidia nforce network patch. 

As above, PCB is 2.0, BIOS is standard 1007 from ASUS.

lspci and proc/interrupts follow. dmesg has been wiped out by some
packet command errors with drive seek errors on hdc (dvdrw) from when i
was playing music with that drive.

-----
lspci:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev
c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev
c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev
c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev
c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev
c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4)
00:05.0 Multimedia audio controller: nVidia Corporation nForce
MultiMedia audio [Via VT82C686B] (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast
Ethernet Controller (rev 40)
03:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If
[Radeon 9000] (rev 01)
03:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon
9000] (Secondary) (rev 01)
-----
cat /proc/interrupts
           CPU0
  0:  350520478          XT-PIC  timer
  1:     346366    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:    3568875    IO-APIC-edge  i8042
 14:    2286009    IO-APIC-edge  ide0
 15:     153023    IO-APIC-edge  ide1
 19:   26315864   IO-APIC-level  radeon@PCI:3:0:0
 21:     855007   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
 22:          3   IO-APIC-level  ohci1394
NMI:          0
LOC:  350520402
ERR:          0
MIS:          0
-----
> -> Josh, Craig & anyone else who gets this working on 2.6.test11 or some 
> other fork of 2.6 can they please try 2.4.23-release as well and see if 
> the machine hangs as well?

I was running gentoo's 2.4.23 pre 8 before this.. its still on the
machine. I get no hangs with it.

This machine has never run Win* (its only 3 weeks old). Wouldnt go near
an Uber BIOS on a still warranted motherboard.

Hope some of it helps.

Craig


> The Linux APIC code generically works on most other hardware. Something 
> specific to the NFORCE2 chips and its interaction with Linux's APIC code 
> causes the hard hangs. The Windows 2000's APIC code was made before the 
> NFORCE2 existed, and it seems to run fine there.
> 
> - About that Uber BIOS bios for the Asus Deluxe board, Anyone running 
> this: a) do you really want to run a hacked bios when other OS run fine 
> on the unhacked BIOS b) do you believe that any of the un-hidden 
> settings the uber bios or settings you may have changed helps solve this 
> problem?
> 
> These bugs on the LK Bugzilla seem related:
> http://bugme.osdl.org/show_bug.cgi?id=1203
> 
> Loosely related:
> http://bugme.osdl.org/show_bug.cgi?id=1530
> http://bugme.osdl.org/show_bug.cgi?id=1440
> http://bugme.osdl.org/show_bug.cgi?id=1269
> 
> 
> Does anyone know which developers would be interested in looking at 
> this? I think it would be better if a specific
> patch fixed this problem than try a kernel from bitkeeper
> on a daily basis and wait for the problem to go away without
> ever knowing what caused it.
> 
> 
> 
> 
> 
>  > To me the strangest thing is that when I first got this
>  > board a month or so ago it would hang with APIC or LAPIC
>  > enabled. Now it works fine without disabling APIC. All I
>  > did was update the BIOS and use it for a while with APIC
>  > disabled. 2.6.0-test9-mm through 2.6.0-test11 all work just
>  > fine. Still at the same time some people are reporting that
>  > it works, some are reporting that it doesn't. I probably
>  > wouldn't think to much of this except I was one of the ones
>  > that said APIC causes crashes with IDE load, but now it
>  > doesn't?
>  >
> 
> 
> 
>  > On approximately Tue, Dec 02, 2003 at 10:13:46AM +0000,
>  > ross.alexander wrote: Alistair,
>  >
>  > I upgraded the BIOS about a week ago to 1007. I personally
>  > found it to be less stable than 1006. I don't believe it is
>  > a problem with my hardware combination since it has been
>  > stable for long periods of time. I was running the SMP
>  > kernel simply because I (wrongly) presumed a) you needed it
>  > to get the IO-APIC working, and b) it didn't do any harm.
>  >
>  > It is clear that the UP kernel is considerable more stable
>  > than the SMP kernel. This is a very useful fact since it
>  > suggests that it is not a problem with the IDE device
>  > driver per se. The whole purpose of my testing is to try to
>  > determine which options increased the stability and hence
>  > highlight where the problem could be.
>  >
>  > One of the reasons I don't like ACPI is the huge amount of
>  > additional complexity it adds and the amount of stuff it
>  > could screw up. Now I have not heard that any of the VIA
>  > KTxxx based motherboards have any problems. If this is true
>  > then the problem does not lie with the LAPIC, since that is
>  > in the processor, not the MB. The fact that it seems to
>  > only occur with the NForce2 chipset means it could well be
>  > some interrupt coming into the LAPIC from Interrupt Bus.
>  > However I certainly don't claim to be an expert on this so
>  > I could well be talking complete crap.
>  >
>  > Conclusion: More testing required.
>  >
>  > Cheers,
>  >
>  > Ross
>  >
>  > Alistair John Strachan <s0348365 28/11/2003
>  > 04:46 p.m.
>  >
>  > To: ross.alexander
>  > <brendan cc: linux-kernel
>  > Subject: Re: NForce2 pseudoscience stability testing
>  > (2.6.0-test11)
>  >
>  > On Friday 28 November 2003 15:13,
>  > ross.alexander
>  >
>  > The conclusion to this is the problem is in Local APIC with
>  > SMP. I'm not saying this is actually true only that is what
>  > the data suggests. If anybody wants me to try some other
>  > stuff feel free to suggest ideas.
>  >
>  > Cheers,
>  >
>  > Ross
>  >
>  > It's evidently a configuration problem, albeit BIOS,
>  > mainboard revision, memory quality, etc. because I and many
>  > others like me are able to run Linux 2.4/2.6 with all the
>  > options you tested and still achieve absolute stability, on
>  > the nForce 2 platform.
>  >
>  > My system is an EPOX 8RDA+, with an Athlon 2500+ (Barton)
>  > overclocked to 2.2Ghz, and 2x256MB TwinMOS PC3200 dimms.
>  > FSB is at 400Mhz, and the ram timings are 4,2,2,2. One
>  > might expect such a configuration to be unstable,
>  >
>  > but it is not.
>  >
>  > I'm currently running 2.6.0-test10-mm1 with full ACPI (+
>  > routing), APIC and local APIC, no preempt, UP, and
>  > everything has been rock-solid, despite the machine being
>  > under constant 100% CPU load and fairly active IO load.
>  >
>  > Also, many others have found that just disabling local apic
>  > (and the MPS setting in the BIOS) as well as ACPI solves
>  > their problem, so I'm skeptical that SMP really causes
>  > *nForce 2 specific* instability.
>  >
>  > -- Cheers, Alistair.
>  >
>  > personal: alistair()devzero!co!uk university:
>  > s0348365()sms!ed!ac!uk student: CS/AI Undergraduate
>  > contact: 7/10 Darroch Court, University of Edinburgh.
>  >
>  > - To unsubscribe from this list: send the line "unsubscribe
>  > linux-kernel" in the body of a message to
>  > majordomo@vger.kernel.org More majordomo info at
>  > http://vger.kernel.org/majordomo-info.html Please read the
>  > FAQ at http://www.tux.org/lkml/
> 





