Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTJTPVV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbTJTPVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:21:20 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:55683
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262633AbTJTPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:21:19 -0400
From: Tovar <tvr@penngrove.fdns.net>
To: linux-kernel@vger.kernel.org
cc: David H?rdeman <david@2gen.com>
Subject: Re: Suspend with 2.6.0-test7-mm1
Message-Id: <E1ABbqb-0002B5-00@penngrove.fdns.net>
Date: Mon, 20 Oct 2003 08:21:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    > I've been playing with the suspend features of 2.6.0-test7-mm1 and I
    > can't get it to work. When I do "echo -n standby > /sys/power/state",
    > the screen flickers briefly and then the system is back to normal. In
    > the logs I see the following message:
    >
	...

    I've seen this, too. Try "sleep 1; echo -n standby > /sys/power/state".
    I theory I thought of, is that the system suspends before you have
    time to release the enter key, and the key release triggers a wakeup.
    Does this seem reasonable to those more knowledgeable?

That doesn't change anything for me, either.  Same 'dmesg' output as noted
before.

     .config:	http://bugzilla.kernel.org/attachment.cgi?id=1092

This is on a Sony VAIO R505EL, attached is 'lspci'.

			   -- JM

-------------------------------------------------------------------------------
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82830 CGC [Chipset Graphics Controller] (rev 04)
00:02.1 Display controller: Intel Corp. 82830 CGC [Chipset Graphics Controller]
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02)
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
02:05.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
===============================================================================
