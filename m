Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273483AbRIUM33>; Fri, 21 Sep 2001 08:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273484AbRIUM3T>; Fri, 21 Sep 2001 08:29:19 -0400
Received: from hal.grips.com ([62.144.214.40]:2458 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S273483AbRIUM3D>;
	Fri, 21 Sep 2001 08:29:03 -0400
Message-Id: <200109211229.f8LCT9J19687@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <geroldj@grips.com>
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch xfs
Date: Fri, 21 Sep 2001 14:29:08 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <1000581501.32705.46.camel@phantasy> <3BA94B2E.99FABD43@grips.com> <1000947409.4348.58.camel@phantasy>
In-Reply-To: <1000947409.4348.58.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 September 2001 02:56, Robert Love wrote:
> I am surprised, you should see a difference, especially with the
> latencytest.  Silly question, but you both applied the patch and enabled
> the config statement, right?
>
Really, i have checked twice.
The patch could, by the way, write a line to the syslog when enabled.

All the filesystem operations happend on the xfs partitions.
I noticed more equally distributed read/write operations with smaller slices 
during big copy jobs on xfs.
This effect may well come from the preemption patch. I used a spare partition
for the test, so the filesystem was in the same state with both kernels 
during the tests.
Xfs usually delays the write operations and does them in bigger blocks.
The behavior of XFS has changed with the kernel versions towards this 
direction anyway but is clearly different with the preemption patch.

I will redo the latency tests with the standard Xfree86 nvidia driver.
It may give a different picture.
The graphics test and the /proc test have shown the highest latency's.
Both involve the xserver (proc for the xterm).
The other tests have been around 5-6 msec in both cases.

And i will do the dbench test of course.

Gerold
