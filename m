Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSEGLpo>; Tue, 7 May 2002 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEGLpn>; Tue, 7 May 2002 07:45:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65288 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315421AbSEGLpC>; Tue, 7 May 2002 07:45:02 -0400
Message-ID: <3CD7AF7A.6040705@evision-ventures.com>
Date: Tue, 07 May 2002 12:42:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Osamu Tomita <tomita@cinet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE CD-ROM PIO mode
In-Reply-To: <3CD79586.63E17164@cinet.co.jp> <3CD7A500.8030509@evision-ventures.com> <20020507124109.A32573@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Christoph Hellwig napisa?:
> On Tue, May 07, 2002 at 11:57:20AM +0200, Martin Dalecki wrote:
> 
>>>@@ -962,7 +962,7 @@
>>> 
>>> 	/* First, figure out if we need to bit-bucket
>>> 	   any of the leading sectors. */
>>>-	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
>>>+	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
>>
> 
> What about a s/MIN/min/g in the idea driver to easily catch such bugs?

Good idea partially already implemented :-).
At least the generic code and the host chip driver code are alread
switched to using those "chatch them" macros.

