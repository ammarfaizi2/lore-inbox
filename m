Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUBQU5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUBQU5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:57:17 -0500
Received: from mail.shareable.org ([81.29.64.88]:6789 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266550AbUBQU5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:57:13 -0500
Date: Tue, 17 Feb 2004 20:57:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040217205707.GF24311@mail.shareable.org>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xr7wtcz0n.fsf@ford.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> > I'd like a way to type something like "touch zöe.txt" on an ordinary
> > latin1 terminal and get a UTF-8 filename in my filesystem.  Thanks :)
> 
> Then hack either bash (or whatever shell you use) or touch to do just that.

Hacking touch is obviously useless - I'd need to hack all the other
2000 shell utilities to get any useful behaviour.

Hacking bash -- actually readline -- is a much better idea.  Then you
can enter names and they'll be created right.  The only flaw in this
is that "ls" won't be useful, so that'll need to be hacked as well. etc.

No, I think hacking the terminal I/O is the best bet here.  Then _all_
programs which currently work with UTF-8 terminals, which is rapidly
becoming most of them, will work the same with both kinds of terminal,
and the illusion of perfection will be complete and beautiful.

-- Jamie
