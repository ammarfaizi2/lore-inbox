Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268774AbRG0FFr>; Fri, 27 Jul 2001 01:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268778AbRG0FFg>; Fri, 27 Jul 2001 01:05:36 -0400
Received: from mail15b.boca15-verio.com ([208.55.91.59]:44639 "HELO
	mail15b.boca15-verio.com") by vger.kernel.org with SMTP
	id <S268774AbRG0FF3>; Fri, 27 Jul 2001 01:05:29 -0400
Message-ID: <3B60F5FB.AB29B413@sigmastorage.com>
Date: Thu, 26 Jul 2001 22:02:51 -0700
From: Matt Ryan <matt@sigmastorage.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2-june14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: device name switching
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[ please CC responses to me ]

hello -
	if I have two hard drives /dev/hda and /dev/hdc, and I pull out the
first drive (root partition is raid1 for redundant boot), on reboot I am
left with just /dev/hdc.  this would seem like the normal, anticipated
behavior.
	however, if I stick in a couple of drives connected to a Promise Ultra
100 card and try the same sort of thing, the drive name assignments
reliably are changed.  if I start with /dev/hd[aceg] (e and g on the
promise card), and pull out hdc, on reboot I have /dev/hd[ace].  if I
start with /dev/hd[aceg] and pull out hda, I also end up with
/dev/hd[ace].  the higher drives sort of collapse down to fill the
'hole.'  this behavior has been reproducible through a series of 2.4
kernels, the last I've tried is 2.4.5.
	my question is, is this anticipated behavior, or does this surprise
anybody?  for all I know the BIOS decides the assignments and the kernel
has nothing to do with it (also this is an intel d815eea2 chipset,
though I'm pretty sure I've seen the same behavior on a Sis-based
chipset as well).


	another reminiscent problem (but probably totally unrelated), is the
name assigned to NICs.  in a box with the same intel motherboard, with
one onboard nic (eepro100) and one PCI nic (3C905C), I have a 2.4.3
kernel and a 2.4.7 kernel.  each kernel has the opposite idea of which
card is eth0 and which is eth1.  curious...


Matt
