Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVAXEsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVAXEsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAXEsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:48:10 -0500
Received: from fiura.inf.utfsm.cl ([200.1.19.5]:11400 "EHLO fiura.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261436AbVAXEsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:48:06 -0500
Message-Id: <200501240348.j0O3mjt5010461@laptop11.inf.utfsm.cl>
To: Andreas Gruenbacher <agruen@suse.de>
cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/13] Qsort 
In-Reply-To: Message from Andreas Gruenbacher <agruen@suse.de> 
   of "Sat, 22 Jan 2005 21:34:01 BST." <20050122203618.962749000@blunzn.suse.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 24 Jan 2005 00:48:45 -0300
From: Horst von Brand <vonbrand@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> said:
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> Acked-by: Olaf Kirch <okir@suse.de>

[...]

> +/* Order size using quicksort.  This implementation incorporates
> +   four optimizations discussed in Sedgewick:
> +
> +   1. Non-recursive, using an explicit stack of pointer that store the
> +      next array partition to sort.  To save time, this maximum amount
> +      of space required to store an array of SIZE_MAX is allocated on the
> +      stack.  Assuming a 32-bit (64 bit) integer for size_t, this needs
> +      only 32 * sizeof(stack_node) == 256 bytes (for 64 bit: 1024 bytes).
> +      Pretty cheap, actually.

Not really, given the strict size restrictions in-kernel.

Has there been any comparison between the original and this one? Code size,
stack use, speed, ...?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
