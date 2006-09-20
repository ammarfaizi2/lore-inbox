Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWITP6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWITP6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWITP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:58:41 -0400
Received: from xenotime.net ([66.160.160.81]:51122 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751643AbWITP6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:58:40 -0400
Date: Wed, 20 Sep 2006 08:46:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] do_no_pfn()
Message-Id: <20060920084638.900c9a69.rdunlap@xenotime.net>
In-Reply-To: <yq0u033c84a.fsf@jaguar.mkp.net>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
	<yq0u033c84a.fsf@jaguar.mkp.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Sep 2006 03:25:25 -0400 Jes Sorensen wrote:

>  include/linux/mm.h |    7 +++++
>  mm/memory.c        |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 64 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h

> @@ -625,6 +626,12 @@ static inline int page_mapped(struct pag
>  #define NOPAGE_OOM	((struct page *) (-1))
>  
>  /*
> + * Error return values for the *_nopfn functions
> + */
> +#define NOPFN_SIGBUS	((unsigned long) -1)
> +#define NOPFN_OOM	((unsigned long) -2)

Is there any difference in the above and

#define NOPFN_SIGBUS		-1UL
#define NOPFN_OOM		-2UL

?
---
~Randy
