Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318154AbSHDL2A>; Sun, 4 Aug 2002 07:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSHDL2A>; Sun, 4 Aug 2002 07:28:00 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38660 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318154AbSHDL17>; Sun, 4 Aug 2002 07:27:59 -0400
Message-ID: <3D4D1070.1020802@namesys.com>
Date: Sun, 04 Aug 2002 15:30:56 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
References: <200208041308.51638.agruen@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you ensure that caches have their (internal) aging hands pushed 
at a speed that is proportional to their memory usage, or is your design 
susceptible to all the usual complaints the unified memory manager crowd 
has about separate caches?

Hans

Andreas Gruenbacher wrote:

>Hello,
>
>Currently there is no way for modules to define dynamically sized caches that 
>shrink upon memory pressure. We need this for implementing Extended Attribute 
>caches on ext2, ext3, and ReiserFS. Other caches could also make use of the 
>same mechanism (e.g., nfsd's permission cache, dcache, icache, dqache).
>
>I propose this patch, which adds the register_cache() and unregister_cache() 
>functions. They allow to register a callback which is invoked on memory 
>pressure. This callback shall then try to free some memory; the parameters 
>and semantics are similar to the other shrink functions in mm/vmscan.c.
>
>
>Regards,
>Andreas.
>
>------------------------------------------------------------------
> Andreas Gruenbacher                                SuSE Linux AG
> mailto:agruen@suse.de                     Deutschherrnstr. 15-19
> http://www.suse.de/                   D-90429 Nuernberg, Germany
>
>
>  
>


-- 
Hans



