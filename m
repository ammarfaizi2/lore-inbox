Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUKIWuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUKIWuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUKIWuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:50:11 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:21899 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261747AbUKIWrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:47:12 -0500
Message-ID: <419148EB.4090907@verizon.net>
Date: Tue, 09 Nov 2004 17:47:07 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@redhat.com
Subject: Re: [PATCH] md: Documentation/md.txt update
References: <20041109042030.11446.55146.88799@localhost.localdomain> <16784.20533.56739.384864@cse.unsw.edu.au>
In-Reply-To: <16784.20533.56739.384864@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.16.226.208] at Tue, 9 Nov 2004 16:47:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Monday November 8, james4765@verizon.net wrote:
> 
>>Update status of superblock formats and fix misspellings in Documentation/md.txt
> 
> 
> Thanks but ....
> 
> 
>> 
>>-The kernel does *NOT* autodetect which format superblock is being
>>-used. It must be told.
>>+The kernel will autodetect which format superblock is being used.
> 
> 
> This is an incorrect change.  The kernel does *NOT* autodetect
> superblock format.  I'm you really think it does, please point me at
> the code.
> 
> 

AFAICT, mddev_t->major_version is used to indicate the superblock format.  That 
form is used in add_new_disk(), but not in autostart_array().

It looks like the autostart_array function is set up to only work with the 0.90.0 
superblock format, but the add_new_disk function calls the proper 
superblock-handling form using super_types[] to switch between the type 0 and type 
1 superblock formats.

OTOH, I could be wrong.

>> 
>>-One started with RUN_ARRAY, uninitialised spares can be added with
>>+One started with RUN_ARRAY, uninitialized spares can be added with
> 
> 
> You corrected the wrong part of this line.
> "One" at the beginning should be "Once".

Oops.  Missed that.

> "uninitialised" is correct  - in the Locale of the author.
> 

Do we go for Queen's English, American English, or what?  Just so I can set up the 
spell-checker in the proper locale.



