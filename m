Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLWVkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTLWVkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:40:12 -0500
Received: from adsl-b3-74-194.telepac.pt ([213.13.74.194]:25777 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S262116AbTLWVjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:39:40 -0500
Message-ID: <3FE8B765.6000907@vgertech.com>
Date: Tue, 23 Dec 2003 21:45:09 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 breaks vmware
References: <1072202167.8127.15.camel@localhost>
In-Reply-To: <1072202167.8127.15.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Shawn wrote:
> Forgive my line-wraps, but the following (among other do_mmap_pgoff
> related snippets) break vmware.
> 
> Couple questions out of this:
> 1. Does anyone care enough to produce a patch for vmware's module?
> 2. What does this change accomplish for reiser4?
> 
> diff -ruN linux-2.6.0-test9/arch/i386/kernel/sys_i386.c
> linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c 
> --- linux-2.6.0-test9/arch/i386/kernel/sys_i386.c       Sat Oct 25
> 22:44:51 2003 
> +++ linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c       Thu Nov
> 13 15:39:47 2003 
> @@ -56,7 +56,7 @@ 
>         } 
> 
>         down_write(&current->mm->mmap_sem); 
> -       error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff); 
> +       error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags,
> pgoff); 
>         up_write(&current->mm->mmap_sem); 
> 
>         if (file)

I'd say that namesys is using UML (user-mode-linux.sf.net) to develop 
raiser4 (smart guys, uml rocks).

These are probably left overs from UML's SKAS-host patch. If I'm correct 
you may try to reverse the SKAS patch from that tree (the patch is 
located at UML's site). It won't do any harm, anyway...

Regards,
Nuno Silva


