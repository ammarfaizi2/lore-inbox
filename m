Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVBPRvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVBPRvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVBPRvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:51:07 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:43525 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262016AbVBPRvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:51:01 -0500
Date: Wed, 16 Feb 2005 17:44:06 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, davem@davemloft.net,
       tony.luck@intel.com, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate the last compat sigvals
Message-ID: <20050216174406.GA12946@linux-mips.org>
References: <20050215154648.74e54fff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215154648.74e54fff.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 03:46:48PM +1100, Stephen Rothwell wrote:

> This patch just consolidates the last of the (what should have been)
> compat_sigval_ts.  It worries me that S390 has a sigval_t in its struct
> compat_siginfo, but I have left that for now.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> P.S. this patch has not even been compiled as I don't have acces to any of
> the platforms involved, but should be straight forward to fix if it breaks
> anything.

You missed one instance for MIPS.  Below patch makes MIPS build.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 signal32.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-oprof/arch/mips/kernel/signal32.c
===================================================================
--- linux-oprof.orig/arch/mips/kernel/signal32.c	2005-02-16 17:42:42.000000000 +0000
+++ linux-oprof/arch/mips/kernel/signal32.c	2005-02-16 17:43:46.000000000 +0000
@@ -78,7 +78,7 @@
 		struct {
 			timer_t _tid;		/* timer id */
 			int _overrun;		/* overrun count */
-			sigval_t32 _sigval;	/* same as below */
+			compat_sigval_t _sigval;/* same as below */
 			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
