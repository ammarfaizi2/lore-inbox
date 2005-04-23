Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVDWLcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVDWLcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 07:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDWLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 07:32:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261557AbVDWLcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 07:32:19 -0400
Date: Sat, 23 Apr 2005 07:31:41 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] non-resident page management
In-Reply-To: <1114255557.10805.2.camel@localhost>
Message-ID: <Pine.LNX.4.61.0504230730560.26710@chimarrao.boston.redhat.com>
References: <1114255557.10805.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2005, Pekka Enberg wrote:
> On 4/23/05, Rik van Riel <riel@redhat.com> wrote:
> > Note that this code could use an actual hash function.
> 
> How about this? It computes hash for the two longs and combines them by
> addition and multiplication as suggested by [Bloch01].

I've thought about it, but ...

> @@ -23,7 +23,7 @@
>  #error Define GOLDEN_RATIO_PRIME for your wordsize.
>  #endif

... include/linux/hash.c appears to only work right for
32 bit words, not 64 bit ones ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
