Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWIHShq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWIHShq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWIHShp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:37:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51867 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751018AbWIHSho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:37:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4501B82E.9060302@s5r6.in-berlin.de>
Date: Fri, 08 Sep 2006 20:36:30 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc6-mm1
References: <20060908011317.6cb0495a.akpm@osdl.org>	<4501ABB7.6030203@s5r6.in-berlin.de> <20060908110402.fd23e756.akpm@osdl.org>
In-Reply-To: <20060908110402.fd23e756.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 08 Sep 2006 19:43:19 +0200
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
...
>> 	kernel/signal.c:2742: warning: weak declaration of
>> 	'arch_vma_name' after first use results in unspecified behavior
...
> Thanks.   Does this fix it?
> 
> --- a/include/linux/mm.h~nommu-move-the-fallback-arch_vma_name-to-a-sensible-place-fix
> +++ a/include/linux/mm.h
> @@ -1266,7 +1266,7 @@ void drop_slab(void);
>  extern int randomize_va_space;
>  #endif
>  
> -const char *arch_vma_name(struct vm_area_struct *vma);
> +__attribute__((weak)) const char *arch_vma_name(struct vm_area_struct *vma);
>  
>  #endif /* __KERNEL__ */
>  #endif /* _LINUX_MM_H */

Yes. gcc approves.
-- 
Stefan Richter
-=====-=-==- =--= -=---
http://arcgraph.de/sr/
