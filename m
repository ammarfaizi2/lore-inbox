Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUA1Nay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUA1Nay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:30:54 -0500
Received: from rzfoobar.is-asp.com ([217.11.194.155]:26527 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id S265946AbUA1Nax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:30:53 -0500
Message-ID: <4017B98C.2040603@isg.de>
Date: Wed, 28 Jan 2004 14:30:52 +0100
From: Lutz Vieweg <lkv@isg.de>
Organization: Innovative Software AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030721 wamcom.org
X-Accept-Language: de, German, en
MIME-Version: 1.0
To: Bart Samwel <bart@samwel.tk>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there a way to keep the 2.6 kjournald from writing to idle
 disks? (to allow spin-downs)
References: <Pine.LNX.3.96.1040127133932.11664B-100000@gatekeeper.tmr.com> <4016B3F0.1060804@samwel.tk>
In-Reply-To: <4016B3F0.1060804@samwel.tk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel wrote:

>> Well, it's the o.p. system, not mine, but I don't see how noatime will
>> help him, the atime shouldn't change unless he's doing disk access, and
>> if he's doing disk access the disk will spin up anyway.

That's what I thought, too... and I really killed everything that I could
imagine accessing the disk... but...

> If something really is accessing the drive, noatime might still help as 
> long as the accesses are from the cache.

... that really helped! I'm kind of surprised, since I didn't use noatime
before the update, and I still don't know of any process that might do
the reading, but since mounting / with noatime helped, I'm happy for now.

My curiosity isn't completely gone, though, so maybe one day I'll try to
find out who-is-trying-to-read-what, "find -atime ..." didn't reveal the secret
yet.

Regards,

Lutz Vieweg


