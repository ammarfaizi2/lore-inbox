Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129963AbQK1RGB>; Tue, 28 Nov 2000 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130021AbQK1RFw>; Tue, 28 Nov 2000 12:05:52 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:38415 "EHLO
        d185d0f1c.rochester.rr.com") by vger.kernel.org with ESMTP
        id <S129963AbQK1RFc>; Tue, 28 Nov 2000 12:05:32 -0500
Date: Tue, 28 Nov 2000 11:26:54 -0500
From: Chris Mason <mason@suse.com>
To: Blizbor <tb670725@ima.pl>, reiserfs-list@namesys.com
cc: reiser@idiom.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] VFS: brelse message in syslog, its due to
 ReiserFS or kernel  failure ?
Message-ID: <120880000.975428814@coffee>
In-Reply-To: <5.0.0.25.0.20001128142121.01da9e20@195.117.13.2>
X-Mailer: Mulberry/2.0.6a8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, November 28, 2000 14:29:34 +0100 Blizbor <tb670725@ima.pl>
wrote:

> Machine: P3 500 on ASUS P2B, WD 15GB IDE drive.
> System RH7 with upgraded glibc.
> 
> When I'm using 2.2.17 with ReiserFS:
> Nov 26 00:05:05 localhost kernel: Linux version 2.2.17
> (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux
> (egcs-1.1.2 relea se)) #9 Sat Nov 25 17:09:40 CET 2000
> 
> I have such messages in syslog and console:
> Nov 26 06:00:49 localhost kernel: VFS: brelse: Trying to free free buffer
> Nov 26 06:07:41 localhost kernel: VFS: brelse: Trying to free free buffer
> Nov 26 06:32:28 localhost kernel: VFS: brelse: Trying to free free buffer
> 
> FS size is about 8GB.
> 
> When I've switched to 2.4.0-test11 + ReiserFS patch there are no such
> messages.
> 
> Both kerlels are patched with latest ReiserFS patches.

These messages could have been caused by a journal bug I fixed a few weeks
ago.  The patch is in the reiserfs mailing list archives, I'll send it to
you privately.

Hans, could we please put out a 3.5.28 from the code in CVS?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
