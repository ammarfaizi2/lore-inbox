Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVEUCTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVEUCTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 22:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVEUCTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 22:19:17 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:59016 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261640AbVEUCTL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 22:19:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QsaL2Zqgi6tmaC1xNARtxyfQTMqUrBxonXjsaeT+mB64C95UUKkji+E+ged1rbinO9clGBbCLQeDQr1VFMziwE8r9e4MWurbGWGmklwwnkmgWUMkSffHy1FSb0QAacqwN6WZz5C9bZf0VeJnE8HTMJF5A9QlgZgs40Sr2Pp8Vrk=
Message-ID: <3f250c7105052019194934be66@mail.gmail.com>
Date: Fri, 20 May 2005 22:19:11 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc4-mm2: proc-pid-smaps.patch broke nommu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050516191827.GG5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050516021302.13bd285a.akpm@osdl.org>
	 <20050516191827.GG5112@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

How did you get this error? What is your configuration?

I would like to replicate it.

BR,

Mauricio Lin.

On 5/16/05, Adrian Bunk <bunk@stusta.de> wrote:
> It seems proc-pid-smaps.patch is guilty for this nommu breakage in -mm:
> 
> <--  snip  -->
> 
> ...
>   LD      vmlinux
> fs/built-in.o(.text+0x32b08): In function `smaps_open':
> /usr/src/ctest/mm/kernel/fs/proc/base.c:560: undefined reference to `_proc_pid_smaps_op'
> make[1]: *** [vmlinux] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
> --
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
>
