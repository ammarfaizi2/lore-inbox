Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSJRW0P>; Fri, 18 Oct 2002 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSJRW0P>; Fri, 18 Oct 2002 18:26:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48372 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265369AbSJRW0N>;
	Fri, 18 Oct 2002 18:26:13 -0400
Message-ID: <3DB08BD4.50607@us.ibm.com>
Date: Fri, 18 Oct 2002 15:31:48 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
References: <3DB08620.40004@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> * stack checking (3/3)
>    - use gcc's profiling features to check for stack overflows upon
>      entry to functions.
>    - Warn if the task goes over 4k.
>    - Panic if the stack gets within 512 bytes of overflowing.
>    - use kksymoops information, if available
> 
> This won't apply cleanly without the irqstack patch, but the conflict is 
> easy to resolve.  It requires the thread_info cleanup.

Greg KH just pointed out that someone else snuck in an overflow check. 
  However, they take completely different approaches.  The Ben LaHaise 
one that I posted uses GCC features to check the stack on entry to all 
functions.  The one in the tree now is much, much simpler than Ben's, 
but only works only for detecting problems at the time that an 
interrupt actually occurs.

-- 
Dave Hansen
haveblue@us.ibm.com

