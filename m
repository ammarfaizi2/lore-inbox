Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRC0NRb>; Tue, 27 Mar 2001 08:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131290AbRC0NRV>; Tue, 27 Mar 2001 08:17:21 -0500
Received: from 8.ylenurme.ee ([193.40.6.8]:11780 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S131275AbRC0NRT>;
	Tue, 27 Mar 2001 08:17:19 -0500
Message-ID: <3AC092A6.8C3F045C@linking.ee>
Date: Tue, 27 Mar 2001 15:16:22 +0200
From: Elmer Joandi <elmer@linking.ee>
Organization: Linking OÜ
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.16, 2.4.*, harddeadlocks with XFree86 and framebuffer
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



So, the problem is on different hardware and kernel versions.

1. looks like VT switch with multiple X copies running  hangs  on
certain conditions
2. More critical: Matrox  G400  dualhead AGP 16M hangs immediately with
fb.


Tested computers:
   1.  Tyan 230 SMP Dual PIII  667Mhz , 512MB
   2. MSI  SMP Dual PIII 667Mhz 512MB
   3. Tyan 1834  SMP Dual Celeron 256MB
Software:
  1  compiled: 2.4.0,2.4.2,.2.4.2-ac8
   2  RH7 stock: 2.2.16

1. True multihead hang on computers 2, 3, both software :
     First,  to get it fly:
     I must log in via network, because executing X behind
X/console causes vt switch.
    First I run USB keyboard patched X for ATI cards, non-fb.
     That one I can run forever, normally, until:
     if to execute matrox (two cards : Millenium + Mystique) server,
    it hangs or wont work
    if I modprobe  matrofb_base, then now I have single possibility
    to run Xfree86-4  _once_ for matrox fb.
     If either of X's(for two matroxes or ATIs) quits, there is
hardlock.
    ping stops, capslock doesnt work(for console keyboard, USB one
    naturally doesnt work at all),

2.  Single dualhed G400 hang, on computers 1 2 3, software 1,2 .
    Well, it is simpler, it hangs with framebuffer and with normal X
mode,
    with 2.2.16 and with 2.4.*, quite soon.
     inserting framebuffer module hangs the beast.
    framebuffer matrox compiled into kernel does not hang until I try to

    start X in some ways or do other console change/swtiching
operations...

      Actually, RedHat 7.0 doesnt install on SMP Matrox dualhead G400 as

    XWindows setup probe lock the box up.



It looks like I should tear it down and use old nfsroot based Xtermian
again...
And sell G400, with which there is nothing to do.

Pity, everything works, but once a day ATI XFree86 sucks some dust in
and
gets killed and the whole box goes with it., cant stand it...



Elmer.



