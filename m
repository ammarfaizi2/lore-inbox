Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSBGFsa>; Thu, 7 Feb 2002 00:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSBGFsU>; Thu, 7 Feb 2002 00:48:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S276424AbSBGFsF>;
	Thu, 7 Feb 2002 00:48:05 -0500
Message-ID: <3C6214F0.A66C89CF@zip.com.au>
Date: Wed, 06 Feb 2002 21:47:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>,
		<Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Feb 06, 2002 at 07:06:01PM +0000 <20020207000930.A17125@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Wed, Feb 06, 2002 at 07:06:01PM +0000, Hugh Dickins wrote:
> > Sorry, no solution, but maybe another oops in __free_pages_ok might help?
> 
> I haven't seen the original oops, but if this patch goes in, it
> reintroduces the problem where network drivers / others release
> pages from irq context causing a BUG().  See sendpage.
> 

Calling lru_cache_del from interrupt is a bug, so Hugh's patch
is valid.

Are you sure that the pages are being released from interrupt context?

-
