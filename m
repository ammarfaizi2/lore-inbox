Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVBYE2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVBYE2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 23:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVBYE2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 23:28:52 -0500
Received: from holomorphy.com ([66.93.40.71]:4009 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262438AbVBYE23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 23:28:29 -0500
Date: Thu, 24 Feb 2005 20:28:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Adam Litke <agl@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Hugepage hash flushing bugfix
Message-ID: <20050225042810.GK15648@holomorphy.com>
References: <20050225041446.GC10725@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225041446.GC10725@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 03:14:46PM +1100, David Gibson wrote:
> Andrew, Linus, please apply:
> Fix a potentially bad (although very rarely triggered) bug in the
> ppc64 hugepage code.  hpte_update() did not correctly calculate the
> address for hugepages, so pte_clear() (which we use for hugepage ptes
> as well as normal ones) would not correctly flush the hash page table
> entry.  Under the right circumstances this could potentially lead to
> duplicate hash entries, which is very bad.
> davem's upcoming patch to pass the virtual address directly to
> set_pte() and its ilk will obsolete this, but this is bad enough it
> should probably be fixed in the meantime.
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Very clear explanation. I second the motion for a rapid merge.

Acked-by: William Irwin <wli@holomorphy.com>
