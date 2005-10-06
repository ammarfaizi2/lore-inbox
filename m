Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVJFPMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVJFPMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVJFPMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:12:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26001 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751078AbVJFPMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:12:06 -0400
Date: Thu, 6 Oct 2005 08:11:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, akpm@osdl.org, mel@csn.ul.ie, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/7] Fragmentation Avoidance V16: 001_antidefrag_flags
Message-Id: <20051006081128.62c9ab1f.pj@sgi.com>
In-Reply-To: <20051005144552.11796.52857.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	<20051005144552.11796.52857.sendpatchset@skynet.csn.ul.ie>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> +/* Allocation type modifiers, group together if possible */

Isn't that "if possible" bogus.  I thought these two bits
_had_ to be grouped together, at least with the current code.

What happened to the comment that Joel added to gpl.h:

+/* Allocation type modifiers, these are required to be adjacent
+ * __GPF_USER: Allocation for user page or a buffer page
+ * __GFP_KERNRCLM: Short-lived or reclaimable kernel allocation
+ * Both bits off: Kernel non-reclaimable or very hard to reclaim
+ * RCLM_SHIFT (defined elsewhere) depends on the location of these bits

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
