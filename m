Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288519AbSADHZG>; Fri, 4 Jan 2002 02:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288521AbSADHY4>; Fri, 4 Jan 2002 02:24:56 -0500
Received: from dsl-213-023-043-248.arcor-ip.net ([213.23.43.248]:21010 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288519AbSADHYu>;
	Fri, 4 Jan 2002 02:24:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>,
        farmer dude <farmerduderl@yahoo.com>
Subject: Re: dd failure odd sectors, block addressing of 1024 question
Date: Fri, 4 Jan 2002 08:28:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020104054648.77014.qmail@web14311.mail.yahoo.com> <20020103234558.K12868@lynx.no>
In-Reply-To: <20020103234558.K12868@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MOlw-0001B4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 07:45 am, Andreas Dilger wrote:
> On Jan 03, 2002  21:46 -0800, farmer dude wrote:
> > I have a question regarding the use gnufileutils 'dd'
> > wherein it fails to image completely in certain
> > circumstances.  I've tossed this around a bit, and so
> > far the best answer seems to be not a DD problem, but
> > rather block addressing within the kernel itself
> > (currently it is 1024bytes???).  Someone has suggested
> > I post to this list to see a) if this is a known issue
> > and/or b) what is being done to correct it (say,
> > changing to 512bytes for example)?
> 
> Yes, this is a long standing and well known issue with Linux.  As you
> mention later in your email, this does not affect Linux directly, because
> it never uses the last sector of odd-sized disks or partitions.  The only
> place it has been noticed is with the Linux NTFS driver (which is unable
> to store the MFT backup in the last sector of the partition) and the NT
> LDM driver which breaks when odd-sized volumes are concatenated together
> (one sector is missing out of the middle of the volume).
>
> [...]
>
> In the end, this has been discussed several times on l-k, and while
> people have expressed a desire to fix it, it has never been done.
> This is probably because anyone who knows enough about Linux to fix
> it uses Linux all the time, and at that point they don't need to fix
> it anymore...

It's definitely on the radar.

--
Daniel
