Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135258AbREBNMa>; Wed, 2 May 2001 09:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135259AbREBNMV>; Wed, 2 May 2001 09:12:21 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:61911 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S135258AbREBNME>; Wed, 2 May 2001 09:12:04 -0400
Date: Wed, 2 May 2001 14:12:03 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: alad@hss.hns.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel
In-Reply-To: <65256A40.00441BB5.00@sandesh.hss.hns.com>
Message-ID: <Pine.SOL.3.96.1010502140229.24744A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001 alad@hss.hns.com wrote:
>      The question may sound very stupid... But I have following doubt.
> 
> suppose I am making some change in sched.c and now I want to build my kernel
> that reflects the change..
> Is there any way I can avoid answering all the questions when I do make zImage ?
> 
> In short how should I compile the kernel (in very small time) to see my changes.

Assuming you have already configured your kernel and previously compiled
it then no questions should be asked. - The way I work is to do make
bzImage, try it, modify. make bzImage, try, etc... No questions asked.

If you did an accidental make mrproper or make clean in between then make
a copy of you old .config (I keep mine in /usr/src/my2.4.4config for
example so I would do from /usr/src/linux: cp ../my2.4.4config .config)
then run make oldconfig

followed by make dep && make bzImage

In future don't do a make mrproper or clean for that matter. All modified
files are automatically recompiled while non-modified ones are taken from
old compile. - This saves incredible amounts of time when using a Pentium
133 for development...

> Thanks (for not flaming me)

You are welcome. (-:

HTH,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

