Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130944AbRCFFeo>; Tue, 6 Mar 2001 00:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130945AbRCFFee>; Tue, 6 Mar 2001 00:34:34 -0500
Received: from gear.torque.net ([204.138.244.1]:6411 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130944AbRCFFeY>;
	Tue, 6 Mar 2001 00:34:24 -0500
Message-ID: <3AA47557.1DC03D6@torque.net>
Date: Tue, 06 Mar 2001 00:27:51 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

> Well, it's entirely possible that the mid-level SCSI layer is doing
> something horribly stupid.

Well it's in good company as FreeBSD 4.2 on the same hardware
returns the same result (including IDE timings that were too
fast). My timepeg analysis showed that the SCSI disk was consuming
the time, not any of the SCSI layers.

> On the other hand, it's also entirely possible that IDE is just a lot
> better than what the SCSI-bigots tend to claim. It's not all that
> surprising, considering that the PC industry has pushed untold billions of
> dollars into improving IDE, with SCSI as nary a consideration. The above
> may just simply be the Truth, with a capital T.

What exactly do you think fsync() and fdatasync() should
do? If they need to wait for dirty buffers to get flushed
to the disk oxide then multiple reported IDE results to
this thread are defying physics.


Doug Gilbert
