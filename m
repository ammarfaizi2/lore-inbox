Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbRGCExr>; Tue, 3 Jul 2001 00:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbRGCExi>; Tue, 3 Jul 2001 00:53:38 -0400
Received: from stine.vestdata.no ([195.204.68.10]:9230 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S265180AbRGCExZ>;
	Tue, 3 Jul 2001 00:53:25 -0400
Date: Tue, 3 Jul 2001 06:53:12 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com
Subject: Re: [RFC][PATCH] first cut 64 bit block support
Message-ID: <20010703065312.J4841@vestdata.no>
In-Reply-To: <Pine.LNX.4.33.0107010040540.3950-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.LNX.4.33.0107010040540.3950-100000@toomuch.toronto.redhat.com>; from Ben LaHaise on Sun, Jul 01, 2001 at 12:53:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2001 at 12:53:25AM -0400, Ben LaHaise wrote:
> Hey folks,
> 
> Below is the first cut at making the block size limit configurable to 64
> bits on x86, as well as always 64 bits on 64 bit machines.  The audit
> isn't complete yet, but a good chunk of it is done.

Great !

> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/md1             7508125768        20 7476280496   1% /mnt/3
> 
> This is a 7TB ext2 filesystem on 4KB blocks.  The 7TB /dev/md1 consists of
> 7x 1TB sparse files on loop devices raid0'd together.  The current patch
> does not have the fixes in the SCSI layer or IDE driver yet; expect the
> SCSI fixes in the next version, although I'll need a tester.  The
> following should be 64 bit clean now: nbd, loop, raid0, raid1, raid5.

What about LVM?

We'll see what we can do to test the scsi-code. Please send it to us
when you have code. I guess there are fixes for both generic-scsi code
and for each controller, right? What controllers are you planning on
fixing first?
What tests do you recommend?
mkfs on a big device, and then putting >2TB data on it?



-- 
Ragnar Kjorstad
Big Storage
