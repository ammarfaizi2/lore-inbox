Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWIWLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIWLfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWIWLfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:35:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:30649 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750712AbWIWLfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:35:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jFc1uu12ofr/LrhPk5321vgMUDDjEbjMh9rDaEcRrvjyxLWdHrh0Pa1OU8p0yeXCfipWvOteqpdqR4cmh4O4IWJSDN/30+i3rMtdfXy56I2CgBdHZJMV+qtCzDQKwfVmw4xZwBPSQjzQp6JF5Xrq7/X3qQs+8hPeBcDf5xEuPUs=
Message-ID: <8bd0f97a0609230435k702806e6h38578258dcfefc85@mail.gmail.com>
Date: Sat, 23 Sep 2006 07:35:38 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Matthieu CASTET" <castet.matthieu@free.fr>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ef35o5$vo4$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
	 <ef35o5$vo4$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/06, Matthieu CASTET <castet.matthieu@free.fr> wrote:
> On Sat, 23 Sep 2006 02:50:02 -0400, Mike Frysinger wrote:
> >> It would be nice if you could use a generic way to pass this partition data
> >> to the kernel from the mtd medium, instead of hardcoding it here.
> >
> > i often wish for such things myself :)
> >
> > unfortunately, the boot loader we utilize (u-boot) isnt exactly
> > friendly to the idea of managing flash partitions like redboot, and
> > what we have here is the current standard method for defining flash
> > partitions with mtd
>
> humm you could use cmdlinepart [1] and pass the partition as a kernel
> string with uboot.
>
> That's what we are doing and it works perfectly.

yes, that is an option ... we find that utilizing the board files "better" as:
 - the boot syntax tends to be a little unwieldy
 - embedded boards dont change, so if you're defining so much
board-specific information in the boards file, the partition map makes
sense there as well
 - the dynamic partitioning aspect of declaring the map at runtime is
unnecessary due to the previous comment

but each to their own i guess
-mike
