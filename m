Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHFWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHFWAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHFWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:00:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40205 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750731AbWHFWAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:00:03 -0400
Date: Sat, 5 Aug 2006 21:23:46 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: Harald Dunkel <harald.dunkel@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
Message-ID: <20060805212346.GE5417@ucw.cz>
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF7E5A.2010903@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 
> >0x2 frozen
> >ata1.00: (BMDMA stat 0x20)
> >ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 
> >(timeout)
> >ata1: port is slow to respond, please be patient
> >ata1: port failed to respond (30 secs)
> >ata1: soft resetting port
> >ata1.00: configured for UDMA/133
> >ata1: EH complete
> >SCSI device sda: 312581808 512-byte hdwr sectors 
> >(160042 MB)
> >sda: Write Protect is off
> >sda: Mode Sense: 00 3a 00 00
> >SCSI device sda: drive cache: write back
> >
> >The disk is a SAMSUNG SP1614C.
> >
> >On another machine (with a SAMSUNG SP2504C inside) 
> >there is no
> >such problem: The disk is back after just a few seconds.
> 
> In standby mode, the drive's interface and state 
> machines stay online and are supposed to spin up and 
> process the command when it receives one.  The above 
> message is printed because an IO command hasn't finished 
> in 30 secs meaning that it didn't wake up when it should 
> have.  The drive seems to act incorrectly.
> 
> >Is there some trick to wake up the disk a little bit 
> >faster?
> 
> Can you try the following instead of hdparm?
> 
> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state

Really? I thought power/state takes 0/3 (for D0 and D3)

							Pavel
-- 
Thanks for all the (sleeping) penguins.
