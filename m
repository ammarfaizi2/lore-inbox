Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUA0Rpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbUA0Rpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:45:30 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:44440 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S264898AbUA0RpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:45:20 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
In-Reply-To: <1iEqx-8bO-31@gated-at.bofh.it>
References: <1izgH-3H4-37@gated-at.bofh.it> <1iBiv-5u0-27@gated-at.bofh.it> <1iEqx-8bO-31@gated-at.bofh.it>
Date: Tue, 27 Jan 2004 18:45:17 +0100
Message-Id: <E1AlXH3-0000UR-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 17:40:45 +0100, you wrote in linux.kernel:

> I'm surprised the sense messages don't show that it's a write to a write
> protected disc (xx/27/zz, where xx == 0x07 or 0x05).

Yep, I wasn't precise, that shows up before the error=0x70 line.

> However, it's even
> more annoying to _not_ be able to write to a media because the kernel
> thinks it knows better. In your fsck case you sort of get what you ask
> for, by shooting yourself in the foot :)

Agreed. It just bit me extra hard because I was thinking my sector
size patches were screwing things up. ;)
 
>> It's fine with me either way. Do you want me to resend with the
>> default fallback changed?
> Yes please.

Ok, I'll do that.

>> +	unsigned short sectors_per_frame = drive->queue->hardsect_size >> 9;
> 
> Nitpick: sectors_per_frame = queue_hardsect_size(q) >> 9;

Yes, I agree, better to use the existing abstraction. I'll split it
then and initialize it as the first line of the function(s), otherwise
it doesn't fit into 80 columns.

> That's about, the rest looks fine.

I'll make that change everywhere and then send an updated version.

-- 
Ciao,
Pascal
