Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316145AbSEJWND>; Fri, 10 May 2002 18:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316146AbSEJWNC>; Fri, 10 May 2002 18:13:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4797 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316145AbSEJWNC>;
	Fri, 10 May 2002 18:13:02 -0400
Message-ID: <3CDC45EF.9000506@us.ibm.com>
Date: Fri, 10 May 2002 15:13:03 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020504
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
In-Reply-To: <3CDC4037.8040104@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus pointed out, a semaphore is probably the wrong way to go. 
The only things that really needs to be protected are the list 
operations themselves.

> No, I really think the code should use a spinlock for the global list, and
> then on a per-lock basis something like a reference count and a blocking
> lock (which might be a semaphore).


-- 
Dave Hansen
haveblue@us.ibm.com

