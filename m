Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290011AbSAPWpD>; Wed, 16 Jan 2002 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290015AbSAPWoy>; Wed, 16 Jan 2002 17:44:54 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:60033 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290011AbSAPWoi>; Wed, 16 Jan 2002 17:44:38 -0500
Message-ID: <3C460255.4020805@reviewboard.com>
Date: Wed, 16 Jan 2002 23:44:37 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020115
X-Accept-Language: en,nl
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020116200459.E835@athlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Test hardware:
> 4 way Dell, 4 GB physical RAM, SCSI/RAID subsystem,
> DB runs on FS.

Can we first make sure that the other factors dont plat a rol in this 
benchmark? I have a couple (14+) Dell servers here, and i know for a 
fact that most of their RAID systems are heavely borked in the 
performance department.

All kernels upto 2.4.1x performed horibly, and all kernels after 2.4.16 
or so perform horibly again! Somewhere inbetween some magic seemed to 
happen in the block layer / elevator code / etc, that caused performance 
to increase upto 100% on the Dell PERC adapters. (started @ the first 
release of the AA VM). However after a few small releases, the 
performance went down to the same old horible level again.

So it might well be (very likely actualy) that the tested redhat 2.4.14 
is a performance 'sweet spot' kernel, where kernels  < 2.4.13 and > 
2.4.15 or 16 are definatly not.

The raid performance is a whole issue on its self. part seems to be 
block IO / Elevator / driver related, and a part seems to be adapter 
firmware related. (And adaptec refusing to release their drivers).

However since both 2.4.17 and 2.4.7 have the same horible RAID 
performance, i do not think the VM is responcible for that part ;-)

A good test would be to configure those disks on a normal AIC7xxx 
adapter, and software raiding them together. The performance of that is 
'equal' between those different kernels, and much much higher then the 
hardware raid. Benchmarking with this would give much better results for 
benchmarking VM's

    -- Chris




