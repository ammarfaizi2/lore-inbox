Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVAKHoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVAKHoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVAKHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:44:00 -0500
Received: from mserv1.uoregon.edu ([128.223.142.40]:55188 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S262475AbVAKHmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:42:33 -0500
Date: Mon, 10 Jan 2005 23:42:30 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Anton Blanchard <anton@samba.org>
cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
In-Reply-To: <20050111035810.GG14239@krispykreme.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu>
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com>
 <20050111035810.GG14239@krispykreme.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Anton Blanchard wrote:

>
>> I am trying to understand how NetApp can be so much
>> better at NFS servicing than my quad Opteron 250 SAN
>> attached machine.  So I need some help and some
>> pointers to understand how I can make my opteron
>> machine come on par (or within 70% NFS performance
>> range) as that of my NetApp R200.  I have run through
>> the NFS-how-to's and have heard "that is why they cost
>> so much more", but I really have to consider that
>> probably most of the ideas that are in the NetApp are
>> common knowldge (just not in my head).
>>
>> Can anyone shed some light on this?

you have to quantify what sort of hardware you're benchmarking in either 
case and how its configured before you can reasonably conclude to much... 
I spent quite a bit of time benchmarking filers and linux configurations 
recently and while I can say with some certainty that while netapp makes 
some very fast and well balanced filers they don't by any means have a 
lock on building a high-performance nfs box.

> Definitely sounds like something is wrong. You can do your own
> comparisons of Linux 2.6 vs Netapp here (the OpenPower 720 is a ppc64
> Linux box):
>
> http://www.spec.org/sfs97r1/results/sfs97r1.html

In actually using sfs97r1 published benchmarks to compare to hardware I 
was benchmarking (from emc, netapp and several roll-your own linux boxes) 
I found the published benchmark information alsmost entirely useless given 
that vendors tend to provide wildly silly hardware configurations. In the 
case of the openpower 720 (to use that for an example) the benchmarked 
machine has 70 15k rpm disks spread across 12 fibre channel controllers, 
64GB of ram, 12GB of nvram and 7 network interfaces...

> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

