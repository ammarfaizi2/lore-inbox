Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTLJVYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTLJVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:24:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:13477 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264134AbTLJVYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:24:21 -0500
Message-ID: <3FD78F03.7080205@namesys.com>
Date: Thu, 11 Dec 2003 00:24:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vitaly Fertman <vitaly@namesys.com>
CC: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: forwarded message from Jan De Luyck
References: <16343.2023.525418.637117@laputa.namesys.com> <200312101604.15299.vitaly@namesys.com> <3FD77A0E.7000909@namesys.com> <200312110002.29307.vitaly@namesys.com>
In-Reply-To: <200312110002.29307.vitaly@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Fertman wrote:

>On Wednesday 10 December 2003 22:54, Hans Reiser wrote:
>  
>
>>Vitaly Fertman wrote:
>>    
>>
>>>Hello,
>>>
>>>      
>>>
>>>>Hello,
>>>>
>>>>Today I discovered this in my syslogs, after something strange
>>>>happening to XFree86 (hung at startup, then dumped me back to the
>>>>console)
>>>>
>>>>is_leaf: free space seems wrong: level=1, nr_items=41, free_space=65224
>>>>rdkey vs-5150: search_by_key: invalid format found in block 283191. Fsck?
>>>>vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find
>>>>stat data of [11 12795 0x0 SD] is_leaf: free space seems wrong: level=1,
>>>>nr_items=41, free_space=65224 rdkey vs-5150: search_by_key: invalid
>>>>format found in block 283191. Fsck? vs-13070:
>>>>reiserfs_read_locked_inode: i/o failure occurred trying to find stat
>>>>data of [11 12798 0x0 SD]
>>>>        
>>>>
>>>this all about fs corruptions. fsck is needed.
>>>      
>>>
>>is this a failure due to bad sector on the drive?
>>    
>>
>
>No, we return EIO in many places if some data corruption is found 
>even if the hardware has worked ok. A stat data has not been found
>here and EIO is returned.
>
>--
>Thanks,
>Vitaly Fertman
>
>
>  
>
fix the code to have a more accurate description.  This is not what I 
would consider an IO error, and it should not describe itself to users 
that way.

Also, please attempt to determine if this is happening on a file system 
that has only had a recent kernel running on it.  I am concerned that we 
might have a bug in recent V3.

-- 
Hans


