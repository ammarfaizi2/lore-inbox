Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWARANN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWARANN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWARANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:13:13 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:36514 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S964955AbWARANM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:13:12 -0500
In-Reply-To: <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D62A7AD5-0954-4FA9-8E20-0E026A3E765A@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Date: Tue, 17 Jan 2006 19:12:57 -0500
To: Michael Loftis <mloftis@wgops.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 17, 2006, at 18:27, Michael Loftis wrote:
> --On January 17, 2006 1:35:46 PM -0600 Cynbe ru Taren  
> <cynbe@muq.org> wrote:
>> Just in case the RAID5 maintainers aren't aware of it:
>>
>> The current Linux kernel RAID5 implementation is just too fragile  
>> to be used for most of the applications where it would be most  
>> useful.
>>
>> In principle, RAID5 should allow construction of a disk-based  
>> store which is considerably MORE reliable than any individual drive.
>
> Absolutely not.  The more spindles the more chances of a double  
> failure. Simple statistics will mean that unless you have mirrors  
> the more drives you add the more chance of two of them (really)  
> failing at once and choking the whole system.

The most reliable RAID-5 you can build is a 3-drive system.  For each  
byte of data, you have a half-byte of parity, meaning that half the  
data-space (not including the parity) can fail without data loss.   
I'm ignoring the issue of rotating parity drive for simplicity, but  
that only affects performance, not the algorithm.  If you want any  
kind of _real_ reliability and speed, you should buy a couple good  
hardware RAID-5 units and mirror them in software.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



