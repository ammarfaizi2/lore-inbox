Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUG0Na4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUG0Na4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUG0Na4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:30:56 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:22653 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265812AbUG0Naq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:30:46 -0400
Message-ID: <41065902.20909@yahoo.com.au>
Date: Tue, 27 Jul 2004 23:30:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Jens Axboe <axboe@suse.de>, Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au> <20040727100724.GA11189@suse.de> <41065748.8050107@comcast.net>
In-Reply-To: <41065748.8050107@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:

> I tried it, i dont slow down or crash when burning the cd the first 
> time. It's a small cd that doesn't take up my entire ram size, but the 
> memory is still not freed. If i tried it again i would be rebooting 
> right now.  I only have 70MB out of 650MB free after burning the cd.  
> Cache only takes up 122MB, and buf takes up 1MB.  and i'm using 100MB of 
> swap. I will run vmstat when i do it when i get home later today.
> It's not so much that the kernel is leaking memory, I think it thinks 
> it's handling a pointer to data it's supposed to write to disk, but it's 
> writing the wrong data, either a slightly misaligned offset or mangled 
> pointer because the audio cd did write but the audio it wrote is 
> unintelligable.  It almost sort of sounds like it should but it's 
> completely fubared.  And i've done this with swab on and off before 
> thinking the drive automatically wrote audio with SWAB on and cdrecord's 
> swab was countering it or something but that was not the case.  The 
> audio source files were ripped from a cd using the same drive and they 
> sound good on the harddrive.  The drive seems to have no real problem 
> ripping audio. Just writing it.  Normal cds show no problem as i've 
> previously mentioned.
> If this is a vfs problem then i'd like to know what audio writing has to 
> do with filesystems since it's raw data.  Even ignoring the mem leak 
> problem that appears to manifest in different ways on different 
> computers, this OOM situation only happens to me when burning audio cds, 
> not data.
>

OK so it does sound like a different problem.

I didn't follow your other thread closely... does /proc/slabinfo
show any evidence of a leak?
