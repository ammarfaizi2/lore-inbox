Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVAYSId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVAYSId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVAYSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:08:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:4551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262041AbVAYSIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:08:31 -0500
Date: Tue, 25 Jan 2005 10:08:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Valdis.Kletnieks@vt.edu, John Richard Moser <nigelenki@comcast.net>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41F6816D.1020306@tmr.com>
Message-ID: <Pine.LNX.4.58.0501251006340.2342@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com>
 <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jan 2005, Bill Davidsen wrote:
> 
> No,perhaps it isn't clear. If A changes the way a lock is used (for 
> example), then all the places which were using the lock the old way have 
> to use it the new way, or lockups or similar bad behaviour occur.

Sure. Some patches are like that, but even then you can split it out so 
that one patch does _only_ that part, and is verifiable as doing only that 
part.

It's also pretty rare. We've had a few big ones like that, notably when 
moving a BKL around (moving it from the VFS layer down into each 
individual filesystem). And I can't see that really happening in a 
security-only patch.

		Linus
