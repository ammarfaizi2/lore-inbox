Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265587AbUEZNVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUEZNVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265585AbUEZNVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:21:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56326 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265616AbUEZNNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:13:14 -0400
Message-ID: <40B49871.7010102@aitel.hist.no>
Date: Wed, 26 May 2004 15:15:29 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265475AbUEZKhK/20040526103710Z+1487@vger.kernel.org>
In-Reply-To: <S265475AbUEZKhK/20040526103710Z+1487@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:

>>Hi Buddy,
>>Even for systems that don't *need* the extra memory space, swap can
>>actually provide performance improvements by allowing unused memory
>>to be replaced with often-used memory.
>>    
>>
>
>  
>
>>For example, I have 57MB swapped right now. It allows me to instantly
>>grep the kernel tree. If I turned swap off, each grep would probably
>>take 30 seconds.
>>    
>>
>
>Your analogy is flawed. There are many reasons why this doesn't work in the
>real world.
>
>I don't think any modern and popular OS contains mechanisms that silently
>stage old pages to disk.
>
Linux is modern and popular . . .

> The constant twitching of the hard drive this
>causes for no apparent reason drives people insane 
>
Stupid people then. If they really expect the disk to work
only when they hit save or start up something.  Sheesh.

>and drains precious
>battery life on laptops. (see description for the pages_min, pages_low and
>pages_high watermarks for clarity)
>  
>
This is a valid concern. Laptop users may want to sacrifice performance
for battery life. Linux can be tweaked quite a bit for this, more
development is probably a good idea. We who use AC power don't
want a performance loss on our machines though, so any such tweaks
must be optional.


[...]

>One thing that can be done to minimize the problem where heavy filesystem
>I/O flushes important pages from memory like pages from shared libraries and
>executables only for them to fault back in as soon as they become runnable,
>is to implement something similar to what Sun implemented in Solaris 8
>called the cyclical page cache. The idea is that the pagecache pages against
>itself and is actually considered free memory from an anonymous memory
>perspective. The pagecache is free to grow all it wants, but since it is
>counted as free memory, anonymous memory allocation will cause the pagecache
>to shrink because it is considered free memory.
>  
>
Linux counts cache as free memory too, of course. 
Allocate memory, and cache will go away.
It has been like this for many years.

Helge Hafting
