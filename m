Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWEWHhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWEWHhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWEWHhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:37:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:43244 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932095AbWEWHhC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:37:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GcwRhWrtHQSn8XS+J1fO4mstVqcKAQjasfScJ5KgVwj4z2eLg7Rjno2bRsw+7c75/Wv9VVj0/RXFgZJ71dAiZeE/q6j41vyqGi9QgsQIWrCvz6mAMf5Yprveh7D9IQFW8wmLijwzaNMJsYPIG17Nyqaa92efnSE1MMF4jROzmwU=
Message-ID: <cf5433040605230037h42d36b60k37e1f7fd576688f9@mail.gmail.com>
Date: Tue, 23 May 2006 07:37:01 +0000
From: "Rainer Shiz" <rainer.shiz@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: RAID Sync Speeds
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17522.15942.232530.954548@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
	 <17522.15942.232530.954548@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Neil and Chris for your quick replies.

Neil, well when you say 'detectable activity' what do you exactly refer to.
Because my system is for all purposes 'idle'. It is not on the network,
just booted it up, no apps running, only linux got booted and I am
logging in through console (text only mode - no X). So I wish the sync
speeds were atleast somewhere inbetween min and max values.
But I see it hovering around min (min being 5000, speed was around 5320 kb/s).
My max was around 250000.

But once I changed min value to 20000, my speeds were around 10000kb/s.
Max being same 250000.
I heard that speed values are averaged out for about 5 minutes or so.
Hence I did try these experiments for about 1 hour each.

This is what made me wonder if there is anything in the 2.6.12 kernel which is
causing this behavior!

One more question while I am at it, if a RAID Set is newly created and
syncing, and now I change the /proc/sys/dev/raid/speed_limit_min and
max values will this reflect on new RAID Sets that are created henceforth
or even the existing RAID Sets which are being synced currently?

And Chris, you are right - I understand that doing any other extraneous
disk I/o or fetching will cause the sync speeds to slow down or
in the extreme case there will be a limit on the SATA bus and how
many other hard disks share it and what i/o is happening on them too,
but in my case I am running these experiments keeping this in mind
and keeping all hard disk activity at almost zero levels.

And yes, I am too using Seagate hard drives. Does mixing up of
hard drives (vendors) affect this sync process.? (I presume not but please
correct me if I am wrong).

Thanks again.
Rainer

On 5/22/06, Neil Brown <neilb@suse.de> wrote:
> On Monday May 22, rainer.shiz@gmail.com wrote:
> >
> > So Is the 2.6 kernel designed to sync at speeds closer to min than max?
> >
>
> If there is other detectable activity, the sync speed will be kept at
> or below the min.
> If there no other activity, the sync speed will be kept at or below
> the max.
>
> NeilBrown
>
