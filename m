Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTDFTZr (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTDFTZr (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:25:47 -0400
Received: from h154n3c1o1029.bredband.skanova.com ([217.209.166.154]:2833 "EHLO
	cyclops") by vger.kernel.org with ESMTP id S261970AbTDFTZp (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 15:25:45 -0400
Date: Sun, 6 Apr 2003 21:37:08 +0200
From: Fredrik Jagenheim <fredde@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Maestro sound module locks up the computer
Message-ID: <20030406193707.GG917@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maestro sound module locks up the computer

When playing music through the maestro sounddriver, the computer will lock up
at irregular intervals. These lock ups will cause the entire machine to freeze,
but a single press on the keyboard will cause the machine to continue as if
nothing had happened. The machine's services are still active though, and if I
ssh in to the machine there are two apparent problems; the input/output 'lags'
behind (that is, when I type 'ls', I have to press return twice to see the
output, the two returns are still processed as two returns, but it seems like I
lag one command behind all the time) and that the machines clock is acting
weird. When typing 'date', I noticed that the time seemed to wrap around after
8 seconds; e.g. say the clock is '16:40:10'. After 6 seconds the clock is, not
surprisingly, '16:40:16'; but after 8 seconds it's '16:40:10' again. I'm not
sure it's exactly 8 seconds though, as I've only had the chance of verifying
this once.

I've narrowed it down (I think) to the maestro driver as these lockups only
happen when I play music. It doesn't matter if I use mplayer from console, or
xmms from X, the lockups still happen. These lockups doesn't happen if I don't
play music, so...

This started to happen a couple of months ago.

More information can be obtained if you ask me. It's very easy to reproduce the
problem (as it happens several times a day), so I can test various hacks if
you have any.

Please CC me any replies, I only read the list filtered through kernel-traffic.
;)

//F

The machine is an Compaq Armada M700, with an Maestro 2E soundcard:
maestro: Configuring ESS Maestro 2E found at IO 0x3000 IRQ 11
maestro:  subvendor id: 0xb1120e11
maestro: not attempting power management.
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
maestro: version 0.15 time 08:33:02 Mar  5 2003

ver_linux output:
Linux wolverine.xmen 2.4.20-gentoo-r1 #2 Wed Mar 5 08:15:06 CET 2003 i686
Pentium III (Coppermine) GenuineIntel GNU/Linux
 
 Gnu C                  3.2.2
 Gnu make               3.80
 util-linux             2.11y
 mount                  2.11y
 modutils               2.4.25
 e2fsprogs              1.32
 reiserfsprogs          3.6.4
 Linux C Library        2.3.1
 Dynamic linker (ldd)   2.3.1
 Procps                 2.0.10
 Net-tools              1.60
 Kbd                    1.06
 Sh-utils               2.0.15
 Modules Loaded         nls_iso8859-1 floppy thermal processor fan button
 		battery ac maestro hid uhci usbcore keybdev mousedev input

proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-13feffff : System RAM
  00100000-002c496c : Kernel code
  002c496d-00348aff : Kernel data
13ff0000-13ff37ff : reserved
13ff3800-13ffffff : ACPI Non-volatile Storage
40000000-410fffff : PCI Bus #01
  40000000-40ffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
  41000000-41000fff : ATI Technologies Inc Rage Mobility P/M AGP 2x
41100000-41100fff : Texas Instruments PCI1450
41180000-41180fff : Texas Instruments PCI1450 (#2)
41200000-4121ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
41280000-41280fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  41280000-41280fff : eepro100
41300000-41300fff : Lucent Microelectronics LT WinModem
50000000-53ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge

