Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286230AbRLTM7e>; Thu, 20 Dec 2001 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286234AbRLTM7Z>; Thu, 20 Dec 2001 07:59:25 -0500
Received: from mail.merconic.com ([62.96.220.180]:46217 "HELO
	mail.merconic.com") by vger.kernel.org with SMTP id <S286230AbRLTM7I>;
	Thu, 20 Dec 2001 07:59:08 -0500
Date: Thu, 20 Dec 2001 13:59:05 +0100
From: "marc. h." <heckmann@hbe.ca>
To: linux-kernel@vger.kernel.org
Subject: cerberus on 2.4.17-rc2 UP
Message-ID: <20011220135904.B32516@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I am not subscribed to the list, please CC me directly]

Hi,

I tried out the latest cerberus from
http://people.redhat.com/bmatthews/cerberus/ on a UP redhat-7.2 box. I ran the
standard non-destructive RedHat tests.

It ran for about 14 hours and then became unresponsive..  machine still ping'ed
, I could switch VC's scroll up on console, but that's it. Could not log in,
etc.. Another point is that the hard drive light remained on but it was not
seeking, it seemed dead silent.

Kernel was compiled using redhat's stock gcc-2.96. Unfortunatly, I did not have
sysrq turned on (I just assumed there would be no problem on UP). The machine
is very well ventilated. 

The symptoms sound very much like what Bob Matthews reported on his 8 way...
just that they take longer to manifest themselves.

I'm willing to test/provide more info. The machine is slated for production
soon so I might only have a week or 2. I'm running the tests again now with
sysrq turned on.

Machine has 128Mb, 270Mb swap, IDE, ext3. no DRI or X. stock 2.4.17-rc2 no
patches applied.

Here is dmesg, lscpci, lsmod, /proc/cpuinfo output:

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 11)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 11)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 11)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 11)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 11)
01:00.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
01:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 03)

Module                  Size  Used by
eepro100               16896   1
3c59x                  25280   1
md                     43840   0  (unused)

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 801.838
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1599.07

-m

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
