Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbUCGMEK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCGMEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:04:10 -0500
Received: from zork.zork.net ([64.81.246.102]:30957 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261840AbUCGMEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:04:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
References: <20040303113756.GQ9196@suse.de> <6ufzcmm5qt.fsf@zork.zork.net>
	<20040307103542.GD23525@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 07 Mar 2004 12:04:04 +0000
In-Reply-To: <20040307103542.GD23525@suse.de> (Jens Axboe's message of "Sun,
 7 Mar 2004 11:35:42 +0100")
Message-ID: <6u7jxwn9sb.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Sat, Mar 06 2004, Sean Neakums wrote:
>> Jens Axboe <axboe@suse.de> writes:
>> 
>> > Hi,
>> >
>> > 2.6 still uses PIO for CDROMREADAUDIO cdda ripping, which is less than
>> > optimal of course... This patch uses the block layer infrastructure to
>> > enable zero copy DMA ripping through CDROMREADAUDIO.
>> >
>> > I'd appreciate people giving this a test spin. Patch is against
>> > 2.6.4-rc1 (well current BK, actually).
>> 
>> Applied successfully to 2.6.4-rc1-mm2, and it works great.  For some
>> reason, on two different machines, ripping with cdparanoia used to
>> somehow crowd out the serial port, but now everything just works.
>
> cd ripping was highly cpu intensive when it ran in pio, so it's very
> likely that this screwed up your serial port communication. It doesn't
> matter with the patch, but had you used hdparm -u1 on your cd device
> on an unpatched kernel, you would have had better luck.

I had a look, just for pig iron, and hdparm -u on one of the machines
reports that it is already enabled.  That machine is SMP with two
1.13GHz PIIIs.  I can't check the other machine as the drive in
question is no longer functional.
