Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLLVVI>; Tue, 12 Dec 2000 16:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLLVU6>; Tue, 12 Dec 2000 16:20:58 -0500
Received: from hees.nijmegen.inter.nl.net ([193.67.237.8]:47763 "EHLO
	hees.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129752AbQLLVUr>; Tue, 12 Dec 2000 16:20:47 -0500
Date: Tue, 12 Dec 2000 21:38:50 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Mohammad A. Haque" <mhaque@haque.net>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd compilation
Message-ID: <20001212213850.A15095@iapetus.localdomain>
In-Reply-To: <20001211145901.A8047@baldur.yggdrasil.com> <3A357BC4.AC568471@haque.net> <20001211195305.B3199@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001211195305.B3199@cadcamlab.org>; from peter@cadcamlab.org on Mon, Dec 11, 2000 at 07:53:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 07:53:05PM -0600, Peter Samuelson wrote:
> 
> [Mohammad A. Haque]
> > Wasn't there discussion that user space apps shouldn't include kernel
> > headers?
> 
> Oh, it's been discussed, many times.  Here is my executive summary of
> why nobody needs to use kernel headers in userspace programs, *EVER*:
Oh, sounds reasonable. But:

Do the maintainers of strace, lm_sensors, the wacom input device in XFree
know this? (just to name a few)

The unanswered question remains:

$ cat `find linux/include/{linux,asm}/. -type f` |grep  '^#ifdef __KERNEL__'|wc
    246     514    4537

why is this?

Either: strip it or maintain it.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
