Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSFDJHV>; Tue, 4 Jun 2002 05:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSFDJHU>; Tue, 4 Jun 2002 05:07:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45574 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316577AbSFDJHT>; Tue, 4 Jun 2002 05:07:19 -0400
Message-ID: <3CFC7591.2010201@evision-ventures.com>
Date: Tue, 04 Jun 2002 10:08:49 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: fix 2.5.20 ramdisk
In-Reply-To: <20020603180627.A23056@flint.arm.linux.org.uk> <20020604083525.GA2512@suse.de> <20020604094532.A30552@flint.arm.linux.org.uk> <3CFC7226.2010101@evision-ventures.com> <20020604095427.B30552@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jun 04, 2002 at 09:54:14AM +0200, Martin Dalecki wrote:
> 
>>>--- orig/drivers/block/rd.c	Wed May 29 21:40:26 2002
>>>+++ linux/drivers/block/rd.c	Tue Jun  4 09:44:21 2002
>>>@@ -144,6 +144,7 @@
>>> {
>>> 	struct address_space * mapping;
>>> 	unsigned long index;
>>>+	unsigned int vec_offset;
>>
>>Just a small nit. Shouldn't taht be size_t ?
> 
> 
> I really don't see where you got that thought from.  A bio_vec is:
> 
> struct bio_vec {
>         struct page     *bv_page;
>         unsigned int    bv_len;
>         unsigned int    bv_offset;
> };
> 
> bv_offset is unsigned int.  Therefore, vec_offset should be likewise.

Ahh. Of course I see. Thank you for explaining.

