Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEBWaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEBWaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVEBWaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:30:10 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:13927 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261184AbVEBWaB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:30:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eu1jDewaC3wuD2F86ZYXUH8CGmZSI0YmmDOFGQxekQugjAFE0o3yxlH7TQ+i4v4bxEyNDxP3EcTXnGUhv1ex+Ar4qjduAWeWoSkWf5SygJXhmDKNvaSBgpK7rwqB1h5y4cG3iCjTV2+60QM0oTJNSCCB0k2emzYGggFD0BrG2E0=
Message-ID: <3f250c7105050215306de620ac@mail.gmail.com>
Date: Mon, 2 May 2005 18:30:01 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050501222916.GB3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <20050501222916.GB3592@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

I tried to replicate this warning but I did not get it on vanilla
kernel. I put the config as

CONFIG_HIGHPTE=y

as well, but no warning. Perhaps I have to try it with mm tree. Any comments?

What do you think Andrew?

BR,

Mauricio Lin.

On 5/1/05, Adrian Bunk <bunk@stusta.de> wrote:
> proc-pid-smaps.patch caused the following warnings with
> CONFIG_HIGHPTE=y:
> 
> <--  snip  -->
> 
> ...
>   CC      fs/proc/task_mmu.o
> fs/proc/task_mmu.c: In function `smaps_pte_range':
> fs/proc/task_mmu.c:177: warning: implicit declaration of function `kmap_atomic'
> fs/proc/task_mmu.c:207: warning: implicit declaration of function `kunmap_atomic'
> ...
> 
> <--  snip  -->
> 
> Unfortunately, I do not understand how to fix this properly.
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
