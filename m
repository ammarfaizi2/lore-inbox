Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVA3WK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVA3WK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVA3WKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:10:55 -0500
Received: from sheephost1.obster.org ([213.202.217.18]:10461 "EHLO
	sheephost1.obster.org") by vger.kernel.org with ESMTP
	id S261806AbVA3WKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:10:42 -0500
Message-ID: <41FD5B72.1060806@obster.org>
Date: Sun, 30 Jan 2005 23:10:58 +0100
From: Michael Obster <kernel@obster.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.29: strange behaviour system clock
References: <41FD336B.8050007@bluewin.ch>
In-Reply-To: <41FD336B.8050007@bluewin.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have also seen such offsets on some boxes running at EADS (a Compaq 
Proliant [<-- this one has a very small offset] and a no name machine 
[<-- this one is terrible in 10 minutes 2-3 minutes too fast]). I have 
no numbers at the moment.
If you need some more information please contact me.

I tried to fix this issue also, but haven't found any solution. Both 
servers are running SuSE Linux I think on 8.x (2.4 kernel). I don't know 
at the moment if we tried already an update to 2.6 kernel.

For the moment our fix is a 10 minute cronjob which execute
hwclock --hctosys
because hardware clock is running correct.

A fix or a hint whats wrong would be very nice :-).

Cheers,
Michael Obster
---
mailto:michael@obster.org
http://www.obster.org

Mario Vanoni wrote:
> the same with
> 2.4.29-rc[123]
> 2.4.28-lck1
> 2.4.23-aa3
> every time repeatable
> 
> UP P4-3400HT, 2GB mem, no swap
> IDE NEC DVD-RW ND-3500AG (dev/sr0)
> 
> DVD with 48 files (*.tar.bz2), 4.4GB
> 
> ntpdate -b swisstime.ethz.ch: offset 0.0...
> time dircmp /mnt/cdrom /source
> thinks it used 20 minutes, no errors
> ntpdate -b ...: offset 1134 sec !!!
> 
> SMP dual P3-550, 1GB mem, no swap
> SCSI PIONER DVD-ROM DVD-304 (slot-in, /dev/sr0)
> 
> same DVD, identical source (copied)
> 
> ntpdate -b ...: offset 0.0...
> time dircmp /mnt/cdrom /source
> thinks it used 12 minutes, no errors
> ntpdate -b ...: 0.020522 sec
> 
> SMP dual Xeon-2800HT, 2GB mem, no swap
> IDE NEC DVD-RW ND-2501A (/dev/sr0)
> 
> same deviation, offset tons of seconds
> this is the production, time must remain correct
> 
> Burning CD/DVD with IDE burners,
> there not exist SCSI burners,
> similar retards of the system clock.
> CD using cdrecord, DVD growisofs.
> 
> Doing hwclock --show, time is always correct.
> 
> Not in LKML, cc if you need, and ... thanks
> 
> Mario
> 
> PS We burn DVD only since 2 weeks,
>   before only CD and only on the SCSI machine,
>   and ... NO PROBLEM.
> 

