Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTLYGLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 01:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTLYGLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 01:11:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21211 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263466AbTLYGLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 01:11:39 -0500
Message-ID: <3FEA7F9A.60604@namesys.com>
Date: Thu, 25 Dec 2003 09:11:38 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Lea <keith@cs.oswego.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 data loss
References: <3FEA0C3C.9090601@cs.oswego.edu>
In-Reply-To: <3FEA0C3C.9090601@cs.oswego.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Lea wrote:

> Hello, I'm not subscribed to this list. This is not a help request, 
> and not really a bug report, I just thought someone should know about 
> this.
>
> I installed the 2.6.0-beta11-mm kernel last week, and the other day my 
> computer locked up (this is normal on my laptop with every kernel 
> version I've tried, this isn't the problem I'm posting about). When I 
> restarted, many, many files that had been open when it locked up were 
> filled with garbage, or the contents of totally unrelated files. For 
> example, my syslog contained some KDE header file code, and 
> /sbin/modprobe contained 82kb of data that seemed like random noise. I 
> think each file was the same size as it was originally, just with 
> different data, but I'm not sure.
>
> The corruption happened on two separate partitions on a single IDE 
> laptop drive, and both were ReiserFS 3.6 partitions. I don't know if 
> this is a kernel bug or a Reiser bug or something else, but I thought 
> the kernel developers should know about this, and be on the lookout 
> for similar things (hopefully with more informative bug reports than 
> mine). I'm sorry I don't have more information, but if anyone wants to 
> know more about my system I'd be glad to help.
>
> -Keith Lea
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>
>
please read about the difference between metadata journaling, data 
journaling, and atomic filesystems, and all will become clear. also note 
the ordered writes option for version 3.6 of reiserfs which is probably 
what you want until atomic reiser4 is fully stable.

-- 
Hans


