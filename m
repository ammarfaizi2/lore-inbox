Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWDJGLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWDJGLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDJGLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:11:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4332
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750767AbWDJGLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:11:12 -0400
Date: Sun, 09 Apr 2006 23:10:34 -0700 (PDT)
Message-Id: <20060409.231034.116564710.davem@davemloft.net>
To: prasanna@in.ibm.com
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, systemtap@sources.redhat.com
Subject: Re: [PATCH] [5/5] Switch Kprobes inline functions to __kprobes for
 sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060410060128.GD23879@in.ibm.com>
References: <20060410055938.GB23879@in.ibm.com>
	<20060410060035.GC23879@in.ibm.com>
	<20060410060128.GD23879@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Date: Mon, 10 Apr 2006 11:31:28 +0530

> Andrew Morton pointed out that compiler might not inline the functions
> marked for inline in kprobes. There by allowing the insertion of probes
> on these kprobes routines, which might cause recursion. This patch
> removes all such inline and adds them to kprobes section there by
> disallowing probes on all such routines. Some of the routines can
> even still be inlined, since these routines gets executed after
> the kprobes had done necessay setup for reentrancy.
> 
> Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
