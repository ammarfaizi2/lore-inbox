Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273929AbRIRWvf>; Tue, 18 Sep 2001 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273960AbRIRWvZ>; Tue, 18 Sep 2001 18:51:25 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:3386 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273929AbRIRWvP>; Tue, 18 Sep 2001 18:51:15 -0400
Subject: Re: Feedback on preemptible kernel patch xfs
From: Robert Love <rml@tech9.net>
To: jury gerold <geroldj@grips.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA72A80.6020706@grips.com>
In-Reply-To: <1000581501.32705.46.camel@phantasy> 
	<3BA72A80.6020706@grips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.17.07.08 (Preview Release)
Date: 18 Sep 2001 18:52:32 -0400
Message-Id: <1000853560.19365.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-18 at 07:05, jury gerold wrote:
> I used your patch on 2.4.10-pre10-xfs from the SGI cvs tree.
> 2 files had to be changed
> fs/xfs_support/atomic.h and fs/xfs_support/mutex.h
> needed a include sched.h

Thank you for reporting this.

I just made a diff against xfs-cvs-20010917 with your changes. 
Obviously I can't merge the changes into the main patch since not
everyone has XFS, but I will make the patch available.

> rootfilesystem is ext2 everything else is xfs
> athlon optimisation is switched on
> chipset is via
> the nvidia kernel module for OpenGL acceleration is running
> hisax isdn driver for internet access
> USB web cam
> 
> I have tried heavy filesystem operations (cp -ar x y && rm -rf y)
> with a big compile job -j2 and some OpenGL programs together with the 
> web cam

Good.  Then we can probably mark XFS as preempt safe (no reason to think
otherwise).  Those file operations were on the XFS partitions, right?

> on the USB side i had some "_comp parameters have gone AWOL" messages in 
> the syslog from the cpia driver
> but i remember them from a no preemtion kernel as well

Yah, probably from mainline kernel...

> so far everything is stable

excellent.

> i like the idea but i have not made any tests on the latency yet

if you do, please post.

thanks for the feedback,

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

