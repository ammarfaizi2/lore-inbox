Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267579AbUHTGPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267579AbUHTGPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUHTGPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:15:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:19328 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267579AbUHTGPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:15:45 -0400
Date: Fri, 20 Aug 2004 11:47:49 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820061749.GA30850@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040819014204.2d412e9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 08:49:17AM +0000, Andrew Morton wrote:
> ppc64-fix-v_regs-pointer-setup.patch
>   ppc64: Fix v_regs pointer setup

Paul rightly pointed out that is should be +15 and not +16. My mistake.
Updated ppc64-fix-v_regs-pointer-setup.patch below:


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

 
---

 linux-2.6.8.1-mm2-vatsa/arch/ppc64/kernel/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc64/kernel/signal.c~ppc64-fix-v_regs-pointer-setup arch/ppc64/kernel/signal.c
--- linux-2.6.8.1-mm2/arch/ppc64/kernel/signal.c~ppc64-fix-v_regs-pointer-setup	2004-08-20 11:43:05.000000000 +0530
+++ linux-2.6.8.1-mm2-vatsa/arch/ppc64/kernel/signal.c	2004-08-20 11:43:22.000000000 +0530
@@ -127,7 +127,7 @@ static long setup_sigcontext(struct sigc
 	 * v_regs pointer or not
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 16) & ~0xful);
+	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
 #endif
 	long err = 0;
 

_

_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
