Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVIEQCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVIEQCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVIEQCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:02:24 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:524 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S932221AbVIEQCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:02:23 -0400
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 65.26.120.26
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: hanaden01
Message-ID: <431C6C0A.4080302@hanaden.com>
Date: Mon, 05 Sep 2005 11:02:18 -0500
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LIST - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.13 hangs / freezes with nvidia kernel module on switch
 to virtual console (also 2.6.12)
Content-Type: multipart/mixed;
 boundary="------------050503040807030604060400"
X-SA-Score: 0.2
X-SA-Report: 0.2 #Spam detection software, running on the system "cognition.home.hanaden.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  kernel 2.6.13 hangs / freezes with nvidia kernel 
	module on switch to virtual console Running Debian testing and stable 
	and built the kernel with the attached config. Then the NVidia 
	installer was run. Everything boots and runs fine. X and Gnome come up 
	and run. Switching to a Virtual Console locks up the system and shows 
	some crazy colors. [...] 
	Content analysis details:   (0.2 points, 6.1 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-0.2 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 QENCPTR2               FULL: Quoted-Printable mime pattern
	-0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050503040807030604060400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

kernel 2.6.13 hangs / freezes with nvidia
kernel module on switch to virtual console

Running Debian testing and stable and built the kernel with the attached
config.  Then the NVidia installer was run.  Everything boots and runs
fine.  X and Gnome come up and run.  Switching to a Virtual Console
locks up the system and shows some crazy colors.

The system ran fine with the same configs until ~kernel 2.6.12.x and has
exhibited this failing behavior since then with multiple kernels.

The graphics card is a shown below and has two outputs both in use for
two monitors.  Thus the actual driver from NV is needed.  I do not
believe the Xfree nv driver supports dual head.

======================
NVidia version
NVIDIA-Linux-x86-1.0-7676-pkg1.run <= from nvidia.com

Debian: testing and stable
Linux ___ 2.6.13 #1 SMP Mon Sep 5 01:26:53 CDT 2005 i686 GNU/Linux

lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600
AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
Gigabit Ethernet (rev 03)
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
0000:00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
0000:00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[K8T800 South]
0000:01:00.0 VGA compatible controller: nVidia Corporation NV 36
[GeForce 5700 Ultra] (rev a1)

kernel config - attached

lsmod
Module                  Size  Used by
it87                   20320  0
eeprom                  6416  0
lm90                   11300  0
i2c_sensor              3264  3 it87,eeprom,lm90
i2c_isa                 2368  0
i2c_dev                 8448  0
i2c_viapro              7376  0
ipv6                  254208  19
lp                      9924  0
parport_pc             38596  1
parport                35144  2 lp,parport_pc
evdev                   8000  0
floppy                 56276  0
pcspkr                  3744  0
usb_storage            74560  0
snd_cmipci             32544  0
gameport               12488  1 snd_cmipci
snd_pcm                84804  1 snd_cmipci
snd_page_alloc          8968  1 snd_pcm
snd_opl3_lib            9920  1 snd_cmipci
snd_timer              22532  2 snd_pcm,snd_opl3_lib
snd_hwdep               7904  1 snd_opl3_lib
snd_mpu401_uart         6848  1 snd_cmipci
snd_rawmidi            21792  1 snd_mpu401_uart
snd_seq_device          7756  2 snd_opl3_lib,snd_rawmidi
snd                    48420  8
snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
eth1394                18696  0
ohci1394               33716  0
nvidia               3707496  12
sr_mod                 14756  0
sd_mod                 14592  0
sbp2                   21960  0
ide_cd                 39428  0

--------------050503040807030604060400
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
vqbhRaEAAA==
--------------050503040807030604060400--
