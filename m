Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbTF3JWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265819AbTF3JWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 05:22:23 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:25283 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265818AbTF3JWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 05:22:21 -0400
Message-ID: <3F0004A9.8080402@namesys.com>
Date: Mon, 30 Jun 2003 13:36:41 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
References: <200306300855.h5U8tNG2000475@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200306300855.h5U8tNG2000475@81-2-122-30.bradfords.org.uk>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tend to agree with the below.  I just want to add though that there 
are a lot of users who have one disk drive and and no decent network 
connection to somewhere with a lot of storage.  It would be nice to 
adapt tar to understand about the reiser4 resizer and mkreiser4 and the 
reiser3 resizer, and the partitioner (yah, at this point it would no 
longer really be tar, but.... ), and to have it shrink the V3 partition, 
create a reiser4 partition, copy some of the V3 partition to the V4 
partition, shrink the V3 partition some more, etc.....

Money will get us to do this.  Otherwise we will work on what we are 
contracted to do for DARPA.

Hans

John Bradford wrote:

>>>I typically call that 'tar' and it works great whenever I want to
>>>convert from one filesystem to another. I just haven't got a clue why
>>>you want to implement tar (or cpio) in the kernel as the userspace
>>>implementation is already pretty usable.
>>>
>>>      
>>>
>>tar --inplace --fs-convert --targetfs=reiserfs /dev/hda1
>>
>>.......  it doesn't like it
>>    
>>
>
>tar -cf - -C /old_filesystem | tar -xf - -C /newfilesystem
>
>Works fine, and copies symbolic links, and device files properly.  If
>you don't want sparse files expanded, you can use --sparse.
>
>Yes, it needs both old and new filesystems on-line at once.  That
>isn't a problem for a lot of users.
>
>It has the advantage over an on-line conversion utility that the files
>are layed out in the way they were intended to be by the filesystem,
>for performance, and anti-fragmentation reasons.
>  
>


