Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJQTS6>; Thu, 17 Oct 2002 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261974AbSJQTS6>; Thu, 17 Oct 2002 15:18:58 -0400
Received: from quark.didntduck.org ([216.43.55.190]:59908 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S261972AbSJQTS6>; Thu, 17 Oct 2002 15:18:58 -0400
Message-ID: <3DAF0E81.4000101@didntduck.org>
Date: Thu, 17 Oct 2002 15:24:49 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Barton <eric@bartonsoftware.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel vaddr -> struct page
References: <200210171911.g9HJBHk02456@bartonsoftware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Barton wrote:
> Hi,
> 
> I'm trying to turn a kernel virtual address into a struct page that I can
> then pass to tcp_sendpage().  
> 
> The kernel virtual address could be {kmalloc(),vmalloc(),kmap()}-ed memory,
> and I guarantee that this memory will not be {kfree(),vfree(),kunmap()}-ed
> until the socket has done with the page (i.e. all the data has been acked).
> 
> I'd have thought that vmalloc_to_page(kvaddr) should give me a page I could
> use, since it is walking the page tables to find the pte for 'kvaddr', and
> checking that the physical page is present.
> 
> However I find I'm sending garbage when I use this method.
> 
> Can anyone help me understand?
> 

virt_to_page()

--
				Brian Gerst

