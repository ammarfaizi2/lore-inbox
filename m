Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVB1UzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVB1UzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVB1UzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:55:22 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:52789 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261737AbVB1UzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:55:11 -0500
Date: Mon, 28 Feb 2005 20:53:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Chris Wright <chrisw@osdl.org>
cc: Darren Hart <dvhltc@us.ibm.com>, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
In-Reply-To: <20050228203307.GL15867@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0502282051100.28577@goblin.wat.veritas.com>
References: <421E74B5.3040701@us.ibm.com> 
    <20050225171122.GE28536@shell0.pdx.osdl.net> 
    <20050225220543.GC15867@shell0.pdx.osdl.net> 
    <Pine.LNX.4.61.0502261626330.20871@goblin.wat.veritas.com> 
    <20050228203307.GL15867@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Chris Wright wrote:
> 
> Successive mlock/munlock calls can leave fragmented vmas because they can
> be split but not merged.  Give mlock et. al. full vma merging support.
> While we're at it, move *pprev assignment above first split_vma in
> mprotect_fixup to keep it in step with mlock_fixup (which for mlockall
> ignores errors yet still needs a valid prev pointer).
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>

Acked-by: Hugh Dickins <hugh@veritas.com>
