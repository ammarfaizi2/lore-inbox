Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUHCVTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUHCVTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266871AbUHCVTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:19:55 -0400
Received: from web14921.mail.yahoo.com ([216.136.225.5]:48224 "HELO
	web14921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266864AbUHCVTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:19:49 -0400
Message-ID: <20040803211948.59456.qmail@web14921.mail.yahoo.com>
Date: Tue, 3 Aug 2004 14:19:48 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200408021903.39273.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is saying that my AGP bridge chip has a ROM right?

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev
02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Expansion ROM at 0000d000 [disabled] [size=4K]
 
Each of my video controllers has one too:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If
[Radeon 9000] (rev 01) (prog-if 00 [VGA])
        Subsystem: C.P. Technology Co. Ltd RV250 If [Radeon 9000 Pro
"Evil Commando"]
        Flags: stepping, 66Mhz, medium devsel, IRQ 177
        Memory at f4000000 (32-bit, prefetchable) [disabled]
[size=fea00000]
        I/O ports at de00 [disabled] [size=256]
        Memory at fe9e0000 (32-bit, non-prefetchable) [disabled]
[size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: <available only to root>
 
02:02.0 VGA compatible controller: ATI Technologies Inc Rage 128 PD/PRO
TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage 128 AIW
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 209
        Memory at f8000000 (32-bit, prefetchable) [size=fe800000]
        I/O ports at ce00 [size=256]
        Memory at fe7dc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: <available only to root>

Both of the video ROMs are at 00020000, won't they end up on top of
each other when enabled?

With the patch the video ROMs are in sysfs but the AGP bridge one is
not.


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
