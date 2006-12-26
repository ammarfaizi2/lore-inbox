Return-Path: <linux-kernel-owner+w=401wt.eu-S932739AbWLZR7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWLZR7D (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWLZR7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:59:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43006 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbWLZR7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:59:01 -0500
Date: Tue, 26 Dec 2006 17:58:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061226175843.GM17561@ftp.linux.org.uk>
References: <20061224005752.937493c8.akpm@osdl.org> <1166962478.7442.0.camel@localhost> <20061224043102.d152e5b4.akpm@osdl.org> <1166978752.7022.1.camel@localhost> <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org> <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com> <Pine.LNX.4.64.0612241131570.3671@woody.osdl.org> <1166991054.7033.2.camel@localhost> <Pine.LNX.4.64.0612241224140.3671@woody.osdl.org> <20061226175155.GK17561@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226175155.GK17561@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2006 at 05:51:55PM +0000, Al Viro wrote:
> On Sun, Dec 24, 2006 at 12:24:46PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Sun, 24 Dec 2006, Andrei Popa wrote:
> > > 
> > > Hash check on download completion found bad chunks, consider using
> > > "safe_sync".
> > 
> > Dang. Did you get any warning messages from the kernel?
> > 
> > 		Linus
> 
> BTW, rmap.c patch is broken - needs at least

... but that doesn't affect most of the architectures - only sparc64 and
some of powerpc.  So it's definitely not enough.
