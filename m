Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272563AbRHaASL>; Thu, 30 Aug 2001 20:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272564AbRHaASB>; Thu, 30 Aug 2001 20:18:01 -0400
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:19141
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S272563AbRHaARu>; Thu, 30 Aug 2001 20:17:50 -0400
Date: Fri, 31 Aug 2001 12:18:00 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Still flaky (Re: Crashing with Abit KT7, 2.2.19+ide patches)
Message-ID: <20010831121800.G30535@cone.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Tim Moore <timothymoore@bigfoot.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20010828155108.G14714@cone.kiwa.co.nz> <Pine.LNX.4.10.10108280029480.19311-100000@coffee.psychology.mcmaster.ca> <20010831103932.A30535@cone.kiwa.co.nz> <3B8ED3E5.22D6233@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8ED3E5.22D6233@bigfoot.com>; from timothymoore@bigfoot.com on Thu, Aug 30, 2001 at 05:01:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 05:01:41PM -0700, Tim Moore wrote:
> I'd try another [non-seagate] disk before chasing ghosts.  The ide
> patch/2.2.19/.20 combo has been very stable.  Same tulip driver and VIA
> chipset.

I've grown to dislike Seagate over the last year.  You are probably not
wrong.

I assume this means a bad sector:

Aug 31 11:24:49 hoppa kernel: hda: irq timeout: status=0xd0 { Busy }
Aug 31 11:25:20 hoppa kernel: ide0: reset timed-out, status=0x80
Aug 31 11:25:20 hoppa kernel: hda: status timeout: status=0x80 { Busy }
Aug 31 11:25:20 hoppa kernel: hda: drive not ready for command
Aug 31 11:25:55 hoppa kernel: ide0: reset timed-out, status=0x80
Aug 31 11:25:55 hoppa kernel: hda: status timeout: status=0x80 { Busy }
Aug 31 11:25:55 hoppa kernel: end_request: I/O error, dev 03:05 (hda), sector 524327
Aug 31 11:25:55 hoppa kernel: hda: drive not ready for command


on a disk which is less than a month old.  Although this corruption
could be a result of the previous crashes.



Oh, well time to hassle my supplier.


Thanks for the assistance,
Nicholas


