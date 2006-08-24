Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWHXM3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWHXM3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWHXM3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:29:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:15585 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751195AbWHXM3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:29:37 -0400
Subject: Re: [Ext2-devel] [RFC][PATCH] Manage jbd allocations from its own
	slabs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 07:29:33 -0500
Message-Id: <1156422573.7908.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 16:08 -0700, Badari Pulavarty wrote:
> Hi,
> 
> Here is the fix to "bh: Ensure bh fits within a page" problem
> caused by JBD.
> 
> BTW, I realized that this problem can happen only with 1k, 2k
> filesystems - as 4k, 8k allocations disable slab debug 
> automatically. But for completeness, I created slabs for those
> also.

With a larger base page size, you could run into the same problems for
4K and 8K allocations, so it's a good thing to do them all.

> What do you think ? I ran basic tests and things are fine.

Looks sane to me.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

