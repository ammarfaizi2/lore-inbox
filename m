Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQKVH6B>; Wed, 22 Nov 2000 02:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQKVH5v>; Wed, 22 Nov 2000 02:57:51 -0500
Received: from slc389.modem.xmission.com ([166.70.2.135]:27659 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129408AbQKVH5l>; Wed, 22 Nov 2000 02:57:41 -0500
To: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
Cc: "'David Lang'" <david.lang@digitalinsight.com>,
        David Riley <oscar@the-rileys.net>, linux-kernel@vger.kernel.org
Subject: Re: Better testing of hardware (was: Defective Read Hat)
In-Reply-To: <0066CB04D783714B88D83397CCBCA0CD49AF@spike2.i405.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Nov 2000 00:13:09 -0700
In-Reply-To: "Stephen Gutknecht's message of "Tue, 21 Nov 2000 13:39:17 -0800"
Message-ID: <m1bsv832ey.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com> writes:

> A Linux Kernel compile test does a really good job of testing the hard disk,
> RAM, and CPU... as it executes all types of instructions and the final
> output depends on all prior steps completing correctly.  On a really fast
> system (> 900Mhz) might make sense to run it twice, once to "warm up" the
> CPU and other components.  Most "benchmarks" just test speed, not the actual
> stability or data integrity (they write results to a device but don't check
> for data corruption, or they test only one device at a time, not all at
> once).

Also note that a Linux Kernel compile stresses memory because
of the very pointer loaded data structures of gcc.  This means that
memory corruption is most likely to flip a bit in a pointer, and cause
a bad pointer.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
