Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVAYQxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVAYQxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVAYQxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:53:08 -0500
Received: from pat.uio.no ([129.240.130.16]:21461 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261978AbVAYQwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:52:34 -0500
Subject: Re: [patch 1/13] Qsort
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olaf Kirch <okir@suse.de>
Cc: Andi Kleen <ak@muc.de>, Andreas Gruenbacher <agruen@suse.de>,
       Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
In-Reply-To: <20050125120507.GH19199@suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 08:52:00 -0800
Message-Id: <1106671920.11449.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.319, required 12,
	autolearn=disabled, AWL 0.32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 25.01.2005 Klokka 13:05 (+0100) skreiv Olaf Kirch:
> On Tue, Jan 25, 2005 at 01:00:23PM +0100, Andi Kleen wrote:
> > group initialization is not time critical, it typically only happens
> > at login.  Also it's doubleful you'll even be able to measure the difference.
> 
> nfsd updates its group list for every request it processes, so you don't want
> to make that too slow.

So here's an iconoclastic question or two:

  Why can't clients sort the list in userland, before they call down to
the kernel?

  If clients are sorting their lists, why would we need to sort the same
list on the server side. Detecting out-of-order list entries is much
less of a hassle than actually sorting, so if the protocol calls for
sorted elements, you can return an EINVAL or something in the case where
some client sends an unsorted list.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

