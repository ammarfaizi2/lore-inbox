Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbRAOJJd>; Mon, 15 Jan 2001 04:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRAOJJX>; Mon, 15 Jan 2001 04:09:23 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:25474 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129733AbRAOJJU>; Mon, 15 Jan 2001 04:09:20 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <17493.979513222@ocs3.ocs-net> 
In-Reply-To: <17493.979513222@ocs3.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Jan 2001 09:09:02 +0000
Message-ID: <18565.979549742@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
> That is a lot of work for a very few special cases.  OTOH, you could
> just add a few lines of __initcall code in two source files (which I
> did when I wrote inter_module_xxx) and swap the order of 3 lines in
> drivers/mtd/Makefile.  Guess which alternative I am going for? 

I've already worked round it for the 2.[024] case by reintroducing the
ifdefs. I assume here that we're planning for 2.5. As part of the many
changes that are going to be introduced during 2.5, this shouldn't be too
intrusive.

Once it's actually usable for the common case, it won't just be 'a very few 
special cases' any more. But that's all 2.5 material.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
