Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319633AbSIMMn6>; Fri, 13 Sep 2002 08:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319635AbSIMMn6>; Fri, 13 Sep 2002 08:43:58 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:26274 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319633AbSIMMn5> convert rfc822-to-8bit; Fri, 13 Sep 2002 08:43:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Ivan Ivanov <ivandi@vamo.orbitel.bg>, linux-kernel@vger.kernel.org
Subject: Re: XFS?
Date: Fri, 13 Sep 2002 07:47:54 -0500
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
In-Reply-To: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130747.54730.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 02:47 am, Ivan Ivanov wrote:
> I think that you missed the main problem with all this new "great"
> filesystems. And the main problem is potential data loss in case of a
> crash. Only ext3 supports ordered or journal data mode.
>
> XFS and JFS are designed for large multiprocessor machines powered by UPS
> etc., where the risk of power fail, or some kind of tecnical problem is
> veri low.
>
> On the other side Linux works in much "risky" environment - old
> machines, assembled from "yellow" parts, unstable power suply and so on.
>
> With XFS every time when power fails while writing to file the entire file
> is lost. The joke is that it is normal according FAQ :)

Also note, it has been my experience that the blocks allocated to the file are
also lost. It takes a fsck operation to recover that.

I had a raided XFS filesystem that lost power at 3am every night... IRIX 
panic/crash/dead. After the third one in a row half of the raid volume was
missing. I noticed that when the aviailable space was exausted. It took an
xfs_repair to rebuild the free space. (power failure due to overloaded circuit
and somebody turned on a monitor...)

> JFS has the same problem.
> With ReiserFS this happens sometimes, but much much rarely. May be v4 will
> solve this problem at all.
>
> The above three filesystems have problems with badblocks too.
>
> So the main problem is how usable is the filesystem. I mean if a company
> spends a few tousand $ to provide a "low risky" environment, then may be
> it will use AIX or IRIX, but not Linux.
> And if I am running a <$1000 "server" I will never use XFS/JFS.
>
> -----------------
> Best Regards
> Ivan

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
