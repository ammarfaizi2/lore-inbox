Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269064AbRHDRKV>; Sat, 4 Aug 2001 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268567AbRHDRKM>; Sat, 4 Aug 2001 13:10:12 -0400
Received: from dhcp233054.columbus.rr.com ([204.210.233.54]:29700 "HELO
	neutral.verbum.org") by vger.kernel.org with SMTP
	id <S269064AbRHDRKC>; Sat, 4 Aug 2001 13:10:02 -0400
To: linux-kernel@vger.kernel.org
Subject: eepro100 (PCI ID 82820) lockups/failure
X-Attribution: Colin
X-Face: %'w-_>8Mj2_'=;I$myE#]G"'D>x3CY_rk,K06:mXFUvWy>;3I"BW3_-MAiUby{O(mn"wV@m
 dd`)Vk[27^^Sa<qRKA=qTu-uV/qLcGrMm-}A24N2wgr)5%_46(#WMTajfXc_DBt)&'/(J1
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.104
 (powerpc-debian-linux-gnu)
Organization: The Ohio State University Dept. of Computer and Info. Science
From: Colin Walters <walters@cis.ohio-state.edu>
Date: Sat, 04 Aug 2001 02:06:10 -0400
Message-ID: <87elqs2wbx.church.of.emacs@space-ghost.verbum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ia32 motherboard (MSI 815EM Pro) with an integrated Intel
ethernet controller, about which lspci -v has to say:

01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 01)
        Subsystem: Intel Corporation: Unknown device 3013
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at d5001000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ac00 [size=64]
        Capabilities: [dc] Power Management version 2

And /proc/pci says:

  Bus  1, device   8, function  0:
    Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 1).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xd5001000 [0xd5001fff].
      I/O at 0xac00 [0xac3f].

I'm using the 2.4.7 eepro100 driver, and the machine consistently
locks up under any kind of heavy network load.  I've tried
2.4.8-pre{1,2,3} with the same results.  A message sometimes printed
to syslog before the machine locks completely is:

Aug  3 20:56:17 debian kernel: eepro100: wait_for_cmd_done timeout!
Aug  3 21:01:22 debian kernel: eepro100: wait_for_cmd_done timeout!
Aug  3 21:01:29 debian kernel: eepro100: wait_for_cmd_done timeout!

Sometimes it's just the network that goes down, but usually the
machine will lock not long thereafter.

I noticed a patch posted to this mailing list:

<URL:http://mailman.real-time.com/pipermail/linux-kernel/Week-of-Mon-20010618/041187.html>

But it doesn't seem to have been applied.

Anyone have any advice?
