Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVBQMui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVBQMui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 07:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVBQMui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 07:50:38 -0500
Received: from fep17.inet.fi ([194.251.242.242]:11250 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S262136AbVBQMua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 07:50:30 -0500
Date: Thu, 17 Feb 2005 14:50:28 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.10, ReiserFS errors, preempt
Message-ID: <20050217125028.GK21077@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0502170125120.2155@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0502170125120.2155@poirot.grange>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 01:59:47AM +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> The machine was running updatedb, while I was trying to burn on an ATAPI 
> CDR (hdc) and read a SCSI DVD-ROM not very intensively, ran a couple of 
> random applications, when my /home partition (hda7) became unaccessible, 

some apps using bttv?

> then came a few Oopses. I sysrq-dumped traces and rebooted. After the 
> reboot /home mounted without any errors, nothing seems to be lost 
> (phew...). In logs found a few ReiserFS errors before the Oops. Attached 
> is a log, perhaps too verbous - sorry.
> 
> In kernel configured ACPI (no suspends), USB-UHCI, Bluetooth, bttv, no 
> ide-scsi, CONFIG_BLK_DEV_VIA82CXXX, LAPIC, boot parameter nmi_watchdog=2 
> (doesn't seem to work anyway), hda is a pretty new. Just looked at 
> smartctl -a /dev/hda - didn't see anything bad (not 100% sure though).
> 
> A comment "fixed in latest 2.6.11-rcX" would be gladly accepted:-)

I don't know, but if I keep on whacking 'v' in xawtv (Video (Capture) on/off),
I get this kind of crap sooner or later (and Oops a bit later).

Dec 25 16:27:37 safari kernel: bttv0: timeout: drop=18 irq=3151491/3151491, risc=0d85301c, bits: VSYNC HSYNC OFLOW
Dec 25 16:27:38 safari kernel: bttv0: reset, reinitialize
Dec 25 16:27:38 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Dec 25 16:29:56 safari kernel: ReiserFS: warning: is_tree_node: node level 8 does not match to the expected one 1
Dec 25 16:29:56 safari kernel: ReiserFS: hda6: warning: vs-5150: search_by_key: invalid format found in block 1774456. Fsck?

so, can you reproduce the Oops without using bttv?
I believe there's unresolved memory corruption bug in bttv...

-- 
