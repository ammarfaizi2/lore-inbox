Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJEQUK>; Sat, 5 Oct 2002 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSJEQUK>; Sat, 5 Oct 2002 12:20:10 -0400
Received: from mail1.dac.neu.edu ([129.10.1.75]:8198 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id <S262410AbSJEQUI>;
	Sat, 5 Oct 2002 12:20:08 -0400
Message-ID: <3D9F1346.4020501@ccs.neu.edu>
Date: Sat, 05 Oct 2002 12:28:54 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021004
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: Sipos Ferenc <sferi@mail.tvnet.hu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: offtopic: patch for nvidia drivers
References: <1033291640.1535.3.camel@zeus.city.tvnet.hu> <3D96CC7B.7060801@drugphish.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
...
> -    /* finally, let's do it! */
> -    err = remap_page_range( (size_t) uaddr, (size_t) start, size_bytes, 
> +    /* finally, let's do it! */ 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
> +    err = remap_page_rage( (size_t) uaddr, (size_t) start, size_bytes,
> +                          PAGE_SHARED);    
> +#else

That remap_page_rage should be remap_page_range as noted in a
previous thread.  Just a reminder.

-Stan



