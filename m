Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUCMTO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUCMTO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:14:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17283 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263165AbUCMTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:14:25 -0500
Date: Sat, 13 Mar 2004 19:14:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.58.0403131048340.900@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0403131902070.3730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, Linus Torvalds wrote:
> 
> The absolute _LAST_ thing we want to have is a "remnant" rmap 
> infrastructure that only gets very occasional use. That's a GUARANTEED way 
> to get bugs, and really subtle behaviour.

On Sat, 13 Mar 2004, Linus Torvalds wrote:
> 
> I just think that if mremap() causes so many problems for reverse mapping,
> we should make _that_ the expensive operation, instead of making
> everything else more complicated.

Friday's Linus has a good point, but I agree more with Saturday's:
mremap MAYMOVE is a very special case, and I believe it would hurt
the whole to put it at the centre of the design.  But all power to
Andrea to achieve that.

Hugh

