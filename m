Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbUKXKcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUKXKcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUKXKcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:32:15 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:35342 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262599AbUKXKcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:32:07 -0500
Message-ID: <41A4632D.4060608@hist.no>
Date: Wed, 24 Nov 2004 11:32:13 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amit Gud <amitgud1@gmail.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com>	 <41A1FFFC.70507@hist.no> <2c59f003041122222038834d7e@mail.gmail.com>
In-Reply-To: <2c59f003041122222038834d7e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud wrote:

>On Mon, 22 Nov 2004 16:04:28 +0100, Helge Hafting <helge.hafting@hist.no> wrote:
>
>  
>
>>You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
>>1. .tar and .tar.gz are complicated formats, and are therefore better
>>   left to userland.  
>>    
>>
>
>Agreed that .tar.gz is a complicated format, but zlib is already in
>the kernel. It _should_ simplify inflate and deflate of files. And as
>compared to .gz format, .tar is much simpler, I guess.
>
>  
>
>>   It is hard to make a guaranteed bug-free decompressor that
>>   is efficient and works with a finite amount of memory.  The kernel
>>   needs all that - userland doesn't.
>>    
>>
>
>I think, finite amount of memory is the concern of worry, not the rest
>... if we could rely on zlib.
> 
>  
>
>>2. Both .tar and .gz  file formats may improve with time.  Getting a new
>>    version of tar og gunzip is easy enough - getting another compression
>>    algorithm into the kernel won't be that easy.
>>    
>>
>
>Doesn't zlib in the kernel gets updated as the formats change? If not,
>.tar formats would be worth trying first as proof of concept.
>
This is not so easy, as you have to audit the new version for
correctness.  It is not the end of the world if tar or gzip
occationally crashes on some corner case.   The kernel
must not do that though.

And then there is the much more complicated issues when
writing into such an archive.  You skipped that part, or
are you looking for a read-only solution only?

Helge Hafting
