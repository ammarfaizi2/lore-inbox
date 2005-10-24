Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVJXUcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVJXUcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJXUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:32:13 -0400
Received: from gold.veritas.com ([143.127.12.110]:28787 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751263AbVJXUcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:32:11 -0400
Date: Mon, 24 Oct 2005 21:31:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
 broken
In-Reply-To: <Pine.LNX.4.64.0510242012120.24138@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0510242107580.6860@goblin.wat.veritas.com>
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
 <7872.1130167591@warthog.cambridge.redhat.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
 <Pine.LNX.4.61.0510241648170.4338@goblin.wat.veritas.com>
 <Pine.LNX.4.64.0510242012120.24138@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 20:32:09.0952 (UTC) FILETIME=[0217EE00:01C5D8DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> On Mon, 24 Oct 2005, Hugh Dickins wrote:
> 
> Now you got me completely confused.  Just when I thought I was 
> understanding things.  (-;  Let me repeat what you say with some questions 
> thrown in...  Please bear with me and help me beat some clue into my 
> head...  (-:

Sorry for confusing you.  I can't answer many of your questions, because
I don't know what you're doing or intending to do.  But you expressed an
aversion to allocating pages unnecessarily.  Probably that made me think
of memory allocation where you meant disk allocation.

Cutting a lot of questions...

> If your answer above is that the pages are normal page cache pages, then:

Nothing special needs doing if you choose to use normal page cache pages
even for the holes.

> If your answer above was ZERO_PAGE(), then:
> 
> Is it to get rid of the zero page and replace it with the _real_, now 
> allocated and writable page?

Yes.

> I have now read filemap_xip.c as it is in Linus kernel and see the 
> ZERO_PAGE().  I guess that that is what you were talking about above all 
> along and not normal page cache pages that happen to be zero.  Correct?

Yes.

> In which case am I correct in saying that as long as I use 
> filemap_nopage() and filemap_populate(), I can ignore your comment about 
> updating mms as ZERO_PAGE() will _never_ be mapped and in fact just 
> normal page cache pages containing zeroes will be mapped?

Yes.

> If that is correct then great.  Otherwise I have missed the plot and would 
> be very grateful if you were to impart some clue upon me.  (-:
> 
> Thanks a lot for your help!  Much appreciated!

Sorry for the confusion: I was just trying to warn you of some difficulties
and their solution, if you were intending to pursue an alternative path.

Hugh
