Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUIEWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUIEWRU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUIEWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:17:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59820 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267294AbUIEWRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:17:18 -0400
Message-ID: <413B9060.9060500@redhat.com>
Date: Sun, 05 Sep 2004 18:17:04 -0400
From: Neil Horman <nhorman@redhat.com>
Reply-To: nhorman@redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: Quick Syscall question
References: <200409051317.42691.eric@cisu.net> <20040905113114.313efdf2.rddunlap@osdl.org>
In-Reply-To: <20040905113114.313efdf2.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Sun, 5 Sep 2004 13:17:42 -0500 Eric Bambach wrote:
>
>| Hello,
>| 
>| 	This may seem like a silly question, however we were all beginning 
>| programmers once ;)
>| 
>| 	I want to do some manipulating of network interfaces and routing and such. I 
>| am reading through some of the linux net sources but am confused on what are 
>| internal, kernel-only functions and what are externally visable syscalls. How 
>| can I tell from the source what is user-space visable that I can hook into 
>| and what is intternel stuff? Should I just be looking at headers or do I have 
>| to delve into the .c sources? I can do either, I just need a pointer on where 
>| to start and what I should be looking for.
>
>Most syscalls are listed in include/linux/syscalls.h.
>Also look in include/asm-*/unistd.h.
>Also in entry.S in arch/*/ (various sub-directory levels).
>
>--
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Also, if you're looking into writing kernel modules, anything listed in 
arch/*ksyms.c as a symbol inside an EXPORT_SYMBOL block is accessible, 
although that may not mean its available from user space.
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

