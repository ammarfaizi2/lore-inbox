Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUDNRst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUDNRst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:48:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51482 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261468AbUDNRss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:48:48 -0400
Date: Wed, 14 Apr 2004 18:48:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking objrmap under memory pressure
In-Reply-To: <20040414162700.GS2150@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404141836570.3975-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Andrea Arcangeli wrote:
> 
> BTW, I've no idea idea why you used an UP machine for this, (plus if you
> can load kde on it it'd be better because kde is extremely smart at
> optimizing the ram usage with cow anonymous memory, the thing anon-vma
> can optimize and anonmm not, plus kde may use even mremap on this
> anonymous ram, and the very single reason it was impossible for me to
> take anonmm in production is that there's no way I can preodict which
> critical app is using mremap on anonymous COW memory to save ram). You
> definitely should use your 32-way booted with mem=512m to run this test
> or there's no way you'll ever botice the additional boost in scalability
> that anon-vma provides compared to anonmm, and that anonmm will never be
> able to reach.

This is just your guess at present, isn't it, Andrea?  Any evidence?

Our current intention is to merge anonmm into mainline in a day or two.
The current consensus (in your absence!) seemed to be that anonmm is
likely to be good enough, no obvious need to go beyond it.

We'll happily replace it with anon_vma once we see the practical
problems which anon_vma solves and anonmm cannot, so long as the
greater cost of anon_vma (in complexity, memory usage, and vma
merge limitations) is worth it.  Can happen just days later,
but would need evidence.

Hugh

