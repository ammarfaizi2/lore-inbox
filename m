Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTLWTVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLWTVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:21:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:51899 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262192AbTLWTVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:21:08 -0500
Message-ID: <3FE895A2.5080208@namesys.com>
Date: Tue, 23 Dec 2003 22:21:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn <core@enodev.com>, nikita@namesys.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 breaks vmware
References: <1072202167.8127.15.camel@localhost>
In-Reply-To: <1072202167.8127.15.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn wrote:

>Forgive my line-wraps, but the following (among other do_mmap_pgoff
>related snippets) break vmware.
>
>Couple questions out of this:
>1. Does anyone care enough to produce a patch for vmware's module?
>2. What does this change accomplish for reiser4?
>
>diff -ruN linux-2.6.0-test9/arch/i386/kernel/sys_i386.c
>linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c 
>--- linux-2.6.0-test9/arch/i386/kernel/sys_i386.c       Sat Oct 25
>22:44:51 2003 
>+++ linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c       Thu Nov
>13 15:39:47 2003 
>@@ -56,7 +56,7 @@ 
>        } 
>
>        down_write(&current->mm->mmap_sem); 
>-       error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff); 
>+       error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags,
>pgoff); 
>        up_write(&current->mm->mmap_sem); 
>
>        if (file)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
thanks Shawn.  Nikita will answer (tomorrow).

-- 
Hans


