Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSBWW4p>; Sat, 23 Feb 2002 17:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293250AbSBWW4f>; Sat, 23 Feb 2002 17:56:35 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:12195 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S293249AbSBWW4Y>; Sat, 23 Feb 2002 17:56:24 -0500
Date: Sat, 23 Feb 2002 23:53:53 +0100 (CET)
From: beh@icemark.net
X-X-Sender: beh@berenium.icemark.ch
To: linux-kernel@vger.kernel.org
Subject: Some problems on a ThinkPad A30P (again...)
Message-ID: <Pine.LNX.4.44.0202232340020.1435-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, a big thanks for the help I got so far  (reg. kapm-idled thread)...

Today I've experimented some more, and found the following:


 - even ALSA 0.90beta11 can't solve the suspend problem. I also noticed
   something rather strange, that I didn't realize before  (due to
   auto-loading of modules):
	When I try to load "snd-card-intel8x0" for the first time,
	modprobe complains about the card not being found or being
	busy.
	When I try to load the same module a second time,
	everything works "fine"...
   But - WHY would linux at first say, the card isn't there, but
   find and initialize the card on the second run?

 - Due to the problem with ALSA, I went back to try the kernel
   sound drivers instead and found the i810_audio to work fine
   (and - more importantly - not disturb the suspend... ;)
   ("historically" I switched to ALSA on a TP600 which was a pain
   to get sound working with kernel drivers, but which was fairly
   easy to do with ALSA at the time...   ...and since then I hadn't
   even tried the kernel drivers any more...)


But - the following problems remain:


 -> Hibernation doesn't work at all (this used to work on the TP600
    and on the TP A21P I had before)...



 -> trying to load agpgart (to make DRI work) fails with:

	Linux agpgart interface v0.99 (c) Jeff Hartmann
	agpgart: Maximum main memory to use for agp memory: 816M
	agpgart: Detected an Intel 830M, but could not find the secondary device.
	agpgart: no supported devices found.



 -> When the system resumes from a suspend, the following message
    turns up in dmesg:

	APIC error on CPU0: 00(40)

    (The system appears to work fine, but I'd still like to know,
     what the error is for...?)


 -> prism2_pci (linux-wlan-ng-0.1.10; linux-wlan-ng-0.1.13pre[1-4])
    WLan throughput is VERY low (~18KB/s, as opposed to ~550KB/s
    on a PCMCIA card, linked to the same Wireless access point;
    also - Win2K also reaches 550KB/s on the internal prism2
    chip)...


Any help on any of the above would be highly appreciated! :)



      Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)

