Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbREWGBn>; Wed, 23 May 2001 02:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbREWGBe>; Wed, 23 May 2001 02:01:34 -0400
Received: from smtp.bmlv.gv.at ([193.171.152.34]:21206 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S262108AbREWGBT>;
	Wed, 23 May 2001 02:01:19 -0400
Message-Id: <3.0.6.32.20010523080316.00918900@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 23 May 2001 08:03:16 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: ioctl/setsockopt etc. vs read/write - idea
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I'd like to offer my $0.02 to the ongoing discussion.


IIRC we already have some OOB-data channels - ioctl, setsockopt, fcntl ...
to name only a few.

But: we already have a side-band: send with MSG_OOB!
And, as I just saw in the sources, there are some flags free.

So how about defining more than 1 OOB-channel and using them instead of
ioctl and so on?

There could be some bits reserved for the channel - 0 for normal, 1 for
alternate date (MSG_OOB), and eg. -1 for SOL_RAW, -2 for SOL_TCP, -3 for
SOL_IP, ... and so on.
For files there would be 1 layer giving locking functionality.

So, a syscall is already there - we could use this.

For compatibility this change could be undone in libc.


Please don't flame if I didn't see something obvious - everything else is
welcome.



Regards,

Phil
