Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWILIyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWILIyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWILIyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:54:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751372AbWILIyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:54:37 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> 
References: <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>  <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> 
To: Aubrey <aubreylee@gmail.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 12 Sep 2006 09:54:08 +0100
Message-ID: <30943.1158051248@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey <aubreylee@gmail.com> wrote:

> OK. Here is the patch and work properly on my side.
> Welcome any suggestions and comments.

It looks reasonable.  Don't forget to sign off the patch.

> void kmem_cache_init(void)
> {
> +#if 0
> 	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
> 
> 	if (p)
> 		free_page((unsigned long)p);
> +#endif

Any idea what that's about?

David
