Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275348AbTHMTWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHMTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:22:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58108 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S275348AbTHMTWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:22:14 -0400
Message-ID: <3F37DFDC.6080308@mvista.com>
Date: Mon, 11 Aug 2003 11:26:36 -0700
From: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
References: <20030809203943.3b925a0e.akpm@osdl.org> <200308101941.33530.schlicht@uni-mannheim.de>
In-Reply-To: <200308101941.33530.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:
> Hi,
> 
> 
>>kgdb-ga.patch
>>  kgdb stub for ia32 (George Anzinger's one)
>>  kgdbL warning fix
> 
> 
> that patch sets DEBUG_INFO to y by default, even if whether DEBUG_KERNEL nor 
> KGDB is enabled. The attached patch changes this to enable DEBUG_INFO by 
> default only if KGDB is enabled.

Looks good to me, but.... just what does this turn on?  Its been a 
long time and me thinks a wee comment here would help me remember next 
time.

-g

> 
> Please apply...
> 
> Best regards
>    Thomas Schlichter
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.0-test3-mm1/arch/i386/Kconfig.orig	Sun Aug 10 14:25:13 2003
> +++ linux-2.6.0-test3-mm1/arch/i386/Kconfig	Sun Aug 10 14:25:56 2003
> @@ -1462,6 +1462,7 @@
>  
>  config DEBUG_INFO
>  	bool
> +	depends on KGDB
>  	default y
>  
>  config KGDB_MORE

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

