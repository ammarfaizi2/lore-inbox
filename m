Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHGRx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHGRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHGRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:53:26 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:49362 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263893AbUHGRxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:53:23 -0400
Message-ID: <41151715.5090001@namesys.com>
Date: Sat, 07 Aug 2004 10:53:25 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Increasing number of inodes after format?
References: <40C62F2F.4090801@techsource.com> <1086811650.26565.50.camel@shaggy.austin.ibm.com>
In-Reply-To: <1086811650.26565.50.camel@shaggy.austin.ibm.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>On Tue, 2004-06-08 at 16:27, Timothy Miller wrote:
>  
>
>>I was involved in a discussion a while back where it was explained that 
>>ext2/3 allocate a certain maximum number of inodes at format time, and 
>>you cannot increase that number later.
>>
>>It was also mentioned that one or more of the journaling file systems 
>>(XFS, JFS, Reiser, etc.) either dynamically allocated inodes or could 
>>increase the maximum later if the pre-allocated set got used up.
>>
>>Could someone please repeat for me which filesystems have dynamic 
>>maximum inode counts?
>>    
>>
>
>JFS dynamically allocates inodes as needed.  An inode extent (consisting
>of 32 inodes) will also be freed if all of its inodes are freed.
>  
>
reiserfs V3 and V4 have stat data not on disk inodes, and they are 
dynamically allocated.
