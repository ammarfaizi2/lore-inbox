Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162072AbWKOXjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162072AbWKOXjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162073AbWKOXjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:39:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162072AbWKOXjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:39:39 -0500
Date: Wed, 15 Nov 2006 15:36:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Message-Id: <20061115153614.a71f944d.akpm@osdl.org>
In-Reply-To: <20061115231626.GC31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061115231626.GC31879@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 00:16:26 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> Paravirt breaks CONFIG_X86_PAE=y compilation:
> 
> <--  snip  -->
> 
> ...
>   CC      init/main.o
> In file included from include2/asm/pgtable.h:245,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
>                  from 
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
> include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
> include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' was here
> include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
> include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' was here
> make[2]: *** [init/main.o] Error 1
> 

So it does.  Zach will save us.

How come allmodconfig doesn't select highmem?
