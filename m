Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSBSVLn>; Tue, 19 Feb 2002 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290218AbSBSVLe>; Tue, 19 Feb 2002 16:11:34 -0500
Received: from viper.haque.net ([66.88.179.82]:44716 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S290216AbSBSVLS>;
	Tue, 19 Feb 2002 16:11:18 -0500
Date: Tue, 19 Feb 2002 16:11:17 -0500
Subject: Re: e2fsck compatibility problem with 2.4.17?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: linux-kernel@vger.kernel.org
To: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <3C725D1C.3060001@huhepl.harvard.edu>
Message-Id: <36BA29EA-257D-11D6-ADDC-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, February 19, 2002, at 09:11 , Joao Guimaraes da Costa wrote:

>
> Hi,
>
> I am having a problem that might be due to an incompatibility between
> e2fsck and kernel 2.4.17.
>
> My machine has a redhat kernel 2.4.3-12 and a kernel 2.4.17 I have 
> recently built from source.
>
> While doing a routine filesystem check at boot time (running kernel 
> 2.4.17), e2fsck found a problem with one of the partitions (I am using 
> e2fsck 1.25 from the redhat rawhide rpm  e2fsprogs-1.25-2.i386.rpm).
>
> I decided not to fix the problem and checked it with a different kernel
> and version 1.19 of e2fsck. In both cases, the partition was clean.
>
> So, I get:
>
> kernel     e2fsck    result
> 2.4.17      1.25     problem
> 2.4.3-12    1.25      OK
> 2.4.3-12    1.19      OK
>
> Are there any know incompatibilities between kernel 2.4.17 and e2fsck
> 1.25? Right now, I am not sure if the filesystem is damaged or not!
>
> The error I get is the following:
> 1) e2fsck gets stuck after only checking 2.5% of the partition. It stays
>   there for about 5 minutes doing clik-clak noises until starting giving
> errors
> 2) First error is:
> Block 32783 - 32791 (attempt to read block from filesystem resulted in
> short read) while doing inode scan.
> 3) Then in Pass 2:
> resources in /src/linux-2.4.3/drivers/acpi (1894) has deleted/unused
> inode 16435.
> And it keeps giving many similar messages....
>
> If it is useful I can try to get the full output. This has been 100% 
> reproducible in my system.

I just lost my system running 2.4.17/ext3 w/ e2fsprogs 1.25 last week 
with similar reports from e2fsck. Though I attributed my problem to my 
hard drive trying to tell me it was about to die because I got the same 
errors when booted into rescue mode from a RH 7.2 CD.

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://www.themes.org/
                                                batmanppc@themes.org
=====================================================================

