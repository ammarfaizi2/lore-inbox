Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWACUEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWACUEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWACUEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:04:14 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:56784 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932406AbWACUEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:04:14 -0500
Message-ID: <43BAD8AE.2070709@liberouter.org>
Date: Tue, 03 Jan 2006 21:03:58 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Avishay Traeger <atraeger@cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_page_count
References: <1136317294.21485.5.camel@rockstar.fsl.cs.sunysb.edu>
In-Reply-To: <1136317294.21485.5.camel@rockstar.fsl.cs.sunysb.edu>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avishay Traeger napsal(a):
> Hello all,
> 
> I sent this to linux-mm, but haven't gotten a response - hope it's OK to
> send here.  I believe the set_page_count() macro is broken, and should
> have parentheses around the 'v' in the second argument (otherwise more
> complex arguments will break).  Here is a patch to 2.6.15 - I haven't
> really tested it, but it looks simple enough.  Any objections?  Anything
> else I need to do?
You should cc somebody (maybe Andrew Morton) and add signed-off-by line if you
want it to be merged. For both, see SubmittingPatches in Documentation.
Also read the whole document, not only those 2 parts...
> 
> Thanks,
> Avishay Traeger
> http://www.fsl.cs.sunysb.edu/~avishay/
> 
> 
> diff -Naur linux-2.6.15/include/linux/mm.h
> linux-2.6.15-mod/include/linux/mm.h
> --- linux-2.6.15/include/linux/mm.h     2006-01-02 22:21:10.000000000
> -0500
> +++ linux-2.6.15-mod/include/linux/mm.h 2006-01-03 11:28:19.000000000
> -0500
> @@ -308,7 +308,7 @@
>   */
>  #define get_page_testone(p)    atomic_inc_and_test(&(p)->_count)
> 
> -#define set_page_count(p,v)    atomic_set(&(p)->_count, v - 1)
> +#define set_page_count(p,v)    atomic_set(&(p)->_count, (v) - 1)
>  #define __put_page(p)          atomic_dec(&(p)->_count)
> 
>  extern void FASTCALL(__page_cache_release(struct page *));
> 

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
