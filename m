Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbWFIPXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbWFIPXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWFIPXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:23:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8638 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965285AbWFIPXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:23:14 -0400
Message-ID: <4489925C.4010508@us.ibm.com>
Date: Fri, 09 Jun 2006 08:23:08 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <200606090240.k592enXj009395@turing-police.cc.vt.edu>
In-Reply-To: <200606090240.k592enXj009395@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 08 Jun 2006 18:20:54 PDT, Mingming Cao said:
> 
>>Current ext3 filesystem is limited to 8TB(4k block size), this is
>>practically not enough for the increasing need of bigger storage as
>>disks in a few years (or even now).
>>
>>To address this need, there are co-effort from RedHat, ClusterFS, IBM
>>and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
>>expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
>>ext3 is build on top of extent map changes for ext3, originally from
>>Alex Tomas. In short, the new ext3 on-disk extents format is:
> 
> 
> which implies matching changes to mkfs.ext2 and possibly mount..
> 
> 
Alexandre Ratchov and Laurent Vivier from BULL have been done some work 
in e2fsprog to support extents and 48/64 bit ext3, although the patches 
have not been thoroughly reviewed and discussed yet...

http://marc.theaimsgroup.com/?l=ext2-devel&m=114848122624510&w=2

>>Appreciate any comments and feedbacks!
> 
> 
> Somebody else was recently discussing a set of patches to ext3 for
> extents+delalloc+mballoc patches - is this work compatible with that?
> 
Yes, the extents patch you mentioned is the same one included in the 
series. The delalloc (support delayed allocation for ext3) and mballoc ( 
support multiple block allocation based on extents) are considered a 
future to add, as this series is intend to address the capability issue 
and on-disk format only.

> Also, a pointer to the matching userspace patches would help anybody
> who's gung-ho enough to test the code....
>

Thanks for your interest!

We have tested patch 1-4 (which basically not touching any on-disk 
format) and they have been in mm tree. Extent patch itself have been 
tested for a long time by ClusterFS and IBM, as it's actually being 
posted a while back.

At this point the whole series pass compile, but not being tested yet. 
This post as a RFC is intend to collect comments and feedbacks. BULL 
team has done some test on the 2.6.16 version of the series with the 
e2fsprog changes they posted though. I will upload the matching 
e2fsprogs changes to ext2.sf.net/48bitsext3 shortly..

Mingming

