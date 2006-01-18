Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWARPtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWARPtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWARPtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:49:17 -0500
Received: from host233.omnispring.com ([69.44.168.233]:60387 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1030354AbWARPtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:49:16 -0500
Message-ID: <43CE6363.2020402@cfl.rr.com>
Date: Wed, 18 Jan 2006 10:48:51 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Max Waterman <davidmaxwaterman@fastmail.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk>  <43CDAFE3.8050203@fastmail.co.uk>  <43CDC44E.6080808@wolfmountaingroup.com> <1137576064.25819.11.camel@localhost.localdomain>
In-Reply-To: <1137576064.25819.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2006 15:49:39.0585 (UTC) FILETIME=[CA69AF10:01C61C46]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14213.000
X-TM-AS-Result: No--6.140000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was going to say, doesn't the kernel set the FUA bit on the write 
request to push important flushes through the disk's write-back cache?  
Like for filesystem journal flushes?


Alan Cox wrote:
> Not always. If you have a cache flush command and the OS knows about
> using it, or if you don't care if the data gets lost over a power
> failure (eg /tmp and swap) it makes sense to force it.
>
> The raid controller drivers that fake scsi don't always fake enough of
> scsi to report that they support cache flushes and the like. That
> doesn't mean the controller itself is neccessarily doing one thing or
> the other.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>   

