Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWCWTSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWCWTSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCWTSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:18:22 -0500
Received: from fmr21.intel.com ([143.183.121.13]:63878 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751398AbWCWTSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:18:21 -0500
Date: Thu, 23 Mar 2006 11:18:19 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-ID: <20060323191819.GA13794@agluck-lia64.sc.intel.com>
References: <20060323164623.699f569e.sfr@canb.auug.org.au> <20060323185234.GA13486@agluck-lia64.sc.intel.com> <20060323190922.GA13695@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323190922.GA13695@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:09:22AM -0800, Luck, Tony wrote:
> -	data8 sys_ni_syscall	/* adjtimex */
> +	data8 sys32_adjtimex

-ENOCOFFEE

Of course that should be:


diff --git a/arch/ia64/ia32/ia32_entry.S b/arch/ia64/ia32/ia32_entry.S
index 95fe044..a32cd59 100644
--- a/arch/ia64/ia32/ia32_entry.S
+++ b/arch/ia64/ia32/ia32_entry.S
@@ -334,7 +334,7 @@ ia32_syscall_table:
 	data8 sys_setdomainname
 	data8 sys32_newuname
 	data8 sys32_modify_ldt
-	data8 sys_ni_syscall	/* adjtimex */
+	data8 compat_sys_adjtimex
 	data8 sys32_mprotect	  /* 125 */
 	data8 compat_sys_sigprocmask
 	data8 sys_ni_syscall	/* create_module */
