Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUIJNTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUIJNTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 09:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIJNTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 09:19:50 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35425 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267401AbUIJNTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 09:19:48 -0400
Date: Fri, 10 Sep 2004 14:19:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Hirokazu Takata <takata@linux-m32r.org>
cc: akpm@osdl.org, <wli@holomorphy.com>, <kaigai@ak.jp.nec.com>,
       <takata.hirokazu@renesas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc1-mm4] [m32r] atomic_inc_return for m32r (Re:
    atomic_inc_return)
In-Reply-To: <20040910.184533.350532260.takata.hirokazu@renesas.com>
Message-ID: <Pine.LNX.4.44.0409101337210.16637-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Hirokazu Takata wrote:
> 
> Here's a patch for m32r atomic.h against 2.6.9-rc1-mm4.
> Please apply this.
> 
> 	* include/asm-m32r/atomic.h:
> 	- Add atomic_inc_return(), atomic_dec_return(), atomic_add_return(),
> 	  atomic_sub_return() and atomic_clear_mask().
> 
> 	- Change atomic_sub_and_test(), atomic_inc_and_test() and 
> 	  atomic_dec_and_test() from functions to macros.
> 
> 	- Update comments, etc.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>

Thanks a lot for doing this.

I don't know your architecture and asm so cannot properly comment on it.

There does seem to be a lot of code duplication in there.  I can imagine
it may be optimal to have a separate atomic_inc and atomic_dec, the
most common operations.  But do you really need atomic_add, atomic_sub,
atomic_add_return, atomic_sub_return, atomic_inc_return, atomic_dec_return
all with their own code blocks?  Maybe, but looks excessive to an outsider.

Perhaps "and return it" rather than just "and return"
in those function comments?

Hugh

