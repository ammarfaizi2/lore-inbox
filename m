Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUCLNzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUCLNzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:55:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:492 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262122AbUCLNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:55:28 -0500
Date: Fri, 12 Mar 2004 13:55:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312132436.GT30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403121348070.4925-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Andrea Arcangeli wrote:
> On Fri, Mar 12, 2004 at 04:46:38AM -0800, William Lee Irwin III wrote:
> > 
> > The case where mremap() creates rmap_chains is so rare I never ever saw
> > it happen in 6 months of regular practical use and testing. Their
> > creation could be triggered only by remap_file_pages().
> 
> did you try specweb with apache? that's super heavy mremap as far as I
> know (and it maybe using anon memory, and if not I certainly cannot
> exclude other apps are using mremap on significant amounts of anymous
> ram).

anonmm has no problem with most mremaps: the special case is for
mremap MAYMOVE of anon vmas _inherited from parent_ (same page at
different addresses in the different mms).  As I said before, it's
quite conceivable that this case never arises outside our testing
(but I'd be glad to be shown wrong, would make effort worthwhile).

Hugh

