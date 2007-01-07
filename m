Return-Path: <linux-kernel-owner+w=401wt.eu-S932414AbXAGGFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXAGGFw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 01:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbXAGGFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 01:05:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35589 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbXAGGFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 01:05:51 -0500
Date: Sat, 6 Jan 2007 22:05:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Tom Lanyon" <tomlanyon@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Martin Michlmayr" <tbm@cyrius.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20070106220526.4d15d39f.akpm@osdl.org>
In-Reply-To: <cd32a0620701061806y719fcf8bwd61daf05dac1bc3c@mail.gmail.com>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	<20061224005752.937493c8.akpm@osdl.org>
	<1166962478.7442.0.camel@localhost>
	<20061224043102.d152e5b4.akpm@osdl.org>
	<1166978752.7022.1.camel@localhost>
	<Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	<Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	<Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
	<4590F9E5.4060300@yahoo.com.au>
	<Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
	<cd32a0620701061806y719fcf8bwd61daf05dac1bc3c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 12:36:18 +1030
"Tom Lanyon" <tomlanyon@gmail.com> wrote:

> On 12/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > What would also actually be interesting is whether somebody can reproduce
> > this on Reiserfs, for example. I _think_ all the reports I've seen are on
> > ext2 or ext3, and if this is somehow writeback-related, it could be some
> > bug that is just shared between the two by virtue of them still having a
> > lot of stuff in common.
> >
> >                         Linus
> 
> I've been following this thread for a while now as I started
> experiencing file corruption in rtorrent when I upgraded to 2.6.19. I
> am using reiserfs.

reiserfs defaults to data=ordered, so it's quite possibly the same bug.

