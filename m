Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUIGVax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUIGVax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIGV3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:29:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:10666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268663AbUIGV2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:28:11 -0400
Date: Tue, 7 Sep 2004 14:26:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, hch@infradead.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/1] uml: no extraversion in
 arch/um/Makefile for mainline
Message-Id: <20040907142613.2ab5775e.akpm@osdl.org>
In-Reply-To: <200409072016.01749.blaisorblade_spam@yahoo.it>
References: <20040906173524.EE034B977@zion.localdomain>
	<20040906193620.A8502@infradead.org>
	<200409072016.01749.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
>
> On Monday 06 September 2004 20:36, Christoph Hellwig wrote:
>  > Could you please fix UML to not use ghash.h and remove that one before
>  > playing with new toys?  This has been requested a few times now.
>  Yes, I can try - but I'd like to know the exact reason (I'm not developing UML 
>  as long as Jeff does).
> 
>  My idea is that ghash.h is just trivial boilerplate which does not deserve 
>  generalized code, so that even rewriting the same exact code without using 
>  those macros (and maybe embedding some assumptions about this usage) would be 
>  a fine solution; also, there is just one user of it 
>  (arch/um/kernel/physmem.c, with just one hash defined), so it shouldn't be 
>  hard.
> 
>  However, if the problem with ghash.h is different, I need more explainations.

Take one look at ghash.h and you'll see why we don't want it in the tree.

ghash was removed for a while and it was not intended that it come back -
it snuck back by accident.  Please, rewrite that piece of UML so we can
again remove ghash.h.

