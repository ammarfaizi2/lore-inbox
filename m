Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJMF2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTJMF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:28:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24527 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261463AbTJMF2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:28:52 -0400
Message-ID: <3F8A3813.7070503@namesys.com>
Date: Mon, 13 Oct 2003 09:28:51 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS causing kernel panic?
References: <FNmF.1ky.9@gated-at.bofh.it> <FNFZ.1JI.3@gated-at.bofh.it> <FP59.3H0.17@gated-at.bofh.it> <FVkc.42S.5@gated-at.bofh.it> <3F89D567.6080901@softhome.net>
In-Reply-To: <3F89D567.6080901@softhome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:

> Hans Reiser wrote:
>
>> reiserfs is not warranted to work on corrupted hdds.....
>
>
>   Is there any kind of error statistics for hard drives?
>
>   Geometry is known.
>   I suspect that structure of damages, caused by contact of plates 
> surface with head, can be classified. 

>
>
>   It may be possible to classify manufacturing glitches. I think HD 
> producers have this kind of classification/statistics - to improve 
> quality, keeping price low.
>
>   Actually what I'm thinking of: some kind of design rules for file 
> systems, how to minimize crashing due to hdd glitches.
>   Let's say, if some of hdd regions are know to be more error prone - 
> desing fs to use those regions less.
>   If hdd damages used to have some specific structure - design file 
> system to keep renundant data in regions which are less likely to be 
> lost both at the same time. So renundancy would make sense.
>
>   Is there any thing like this?
>
>   Or file systems now do outlive hard drives?-)
>


Block allocation policies affect performance a lot, and keeping them 
simple is important.    I would however be interested in knowing what 
the distribution function for errors by geometry is.  If it turned out 
that, say, errors were higher at the platter edges, I could make some 
format changes....

I think that for users it is best to think about how to mask drive 
errors in the device layer or the device using RAID and mirroring.

-- 
Hans


