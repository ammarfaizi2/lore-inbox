Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWARPTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWARPTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWARPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:19:54 -0500
Received: from host233.omnispring.com ([69.44.168.233]:52447 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1030337AbWARPTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:19:54 -0500
Message-ID: <43CE5C7A.5060608@cfl.rr.com>
Date: Wed, 18 Jan 2006 10:19:22 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com> <43CDED23.5060701@fastmail.co.uk>
In-Reply-To: <43CDED23.5060701@fastmail.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2006 15:20:10.0511 (UTC) FILETIME=[ABF669F0:01C61C42]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14213.000
X-TM-AS-Result: No--4.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right, the kernel does not know how many disks are in the array, so it 
can't automatically increase the readahead.  I'd say increasing the 
readahead manually should solve your throughput issues.

Max Waterman wrote:
> 
> I left the stripe size at the default, which, I believe, is 64K bytes; 
> same as your fakeraid below.
> 
> I did play with 'blockdev --setra' too.
> 
> I noticed it was 256 with a single disk, and, with s/w raid, it 
> increased by 256 for each extra disk in the array. IE for the raid 0 
> array with 4 drives, it was 1024.
> 
> With h/w raid, however, it did not increase when I added disks. Should I 
> use 'blockdev --setra 320' (ie 64 x 5 = 320, since we're now running 
> RAID5 on 5 drives)?
> 

