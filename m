Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbTH2OR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTH2ORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:17:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46000 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261244AbTH2ORW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:17:22 -0400
Date: Fri, 29 Aug 2003 09:17:10 -0500
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030828131019.69a9f3b9.akpm@osdl.org>
Message-Id: <7AB2E883-DA2B-11D7-BFD3-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Aug 28, 2003, at 15:10 US/Central, Andrew Morton wrote:
>
> --- 25/include/asm-i386/processor.h~disable-athlon-prefetch	2003-08-23 
> 13:48:16.000000000 -0700
> +++ 25-akpm/include/asm-i386/processor.h	2003-08-23 13:48:16.000000000 
> -0700
> @@ -578,6 +578,8 @@ static inline void rep_nop(void)
>  #define ARCH_HAS_PREFETCH
>  extern inline void prefetch(const void *x)
>  {
> +	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
> +		return;
>  	alternative_input(ASM_NOP4,
>  			  "prefetchnta (%1)",
>  			  X86_FEATURE_XMM,

Without a comment explaining the problem?

-- 
Hollis Blanchard
IBM Linux Technology Center

