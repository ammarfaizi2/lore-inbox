Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUCYA2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbUCYAZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:25:50 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:11461 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262854AbUCYAWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:22:13 -0500
Date: Wed, 24 Mar 2004 17:22:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 9/22] __early_param for ia64
Message-ID: <20040325002211.GO7126@smtp.west.cox.net>
References: <20040324235904.JMM2477.fed1mtao01.cox.net@localhost.localdomain> <16482.9133.536372.808784@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16482.9133.536372.808784@napali.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 04:11:25PM -0800, David Mosberger wrote:
> >>>>> On Wed, 24 Mar 2004 18:59:04 -0500, trini@kernel.crashing.org said:
> 
>   trini> CC: davidm@hpl.hp.com - Remove saved_command_line (and saving
>   trini> of the command line).  - Call parse_early_options - Convert
>   trini> mem= to __early_param.
> 
> This part looks OK to me, except that you should also delete this line:
> 
> #define COMMAND_LINE_SIZE	512
> 
> from arch/ia64/kernel/setup.c.

Done, depending on the first ia64 patch:
--- linux-2.6-early_setup-trini/arch/ia64/kernel/setup.c	2004-03-24 16:15:07.160575311 -0700
+++ linux-2.6-early_setup-trini/arch/ia64/kernel/setup.c	2004-03-24 17:21:09.374245052 -0700
@@ -88,8 +88,6 @@
 unsigned long ia64_max_iommu_merge_mask = ~0UL;
 EXPORT_SYMBOL(ia64_max_iommu_merge_mask);
 
-#define COMMAND_LINE_SIZE	512
-
 /*
  * We use a special marker for the end of memory and it uses the extra (+1) slot
  */

-- 
Tom Rini
http://gate.crashing.org/~trini/
