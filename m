Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTATVa1>; Mon, 20 Jan 2003 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTATVa1>; Mon, 20 Jan 2003 16:30:27 -0500
Received: from adsl-b3-75-90.telepac.pt ([213.13.75.90]:19597 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id <S266983AbTATVaZ>; Mon, 20 Jan 2003 16:30:25 -0500
Message-ID: <3E2C6C92.6060505@vgertech.com>
Date: Mon, 20 Jan 2003 21:39:30 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: "'Rik van Riel'" <riel@conectiva.com.br>,
       "'Jean-Eric Cuendet'" <jean-eric.cuendet@linkvest.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Disabling file system caching
References: <004001c2c0bc$d1e69750$3640a8c0@boemboem>
In-Reply-To: <004001c2c0bc$d1e69750$3640a8c0@boemboem>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Folkert van Heusden wrote:
>>>Is it possible to disable file caching for a given partition or mount?
>>
>>No, if you do that mmap(), read(), write() etc. would be impossible.
> 
> 
> Hmmm, maybe there's some way to explicitly flush the read/write-cache?
> Ok, sync will do nice for the write-cache, but for the read-one?

AFAIK, you simply can't... I'm trying to do this for several months and 
no luck. Linux simply caches everything it can in the read-cache. For 
99% of all cases this is very good but, for some situations, this is not 
desireable.

For the write cache, you can minimize memory usage playing with 
/proc/sys/vm (see Documentation/filesystems/proc.txt).

Regards,
Nuno Silva

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

