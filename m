Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbULKT66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbULKT66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbULKT66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:58:58 -0500
Received: from brown.brainfood.com ([146.82.138.61]:6587 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262006AbULKT64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:58:56 -0500
Date: Sat, 11 Dec 2004 13:58:45 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <20041211173317.GA28382@thunk.org>
Message-ID: <Pine.LNX.4.58.0412111358150.2173@gradall.private.brainfood.com>
References: <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org>
 <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org>
 <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org>
 <20041210182804.GT8876@waste.org> <20041210212815.GB25409@thunk.org>
 <20041210222306.GV8876@waste.org> <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com>
 <20041211173317.GA28382@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Theodore Ts'o wrote:

> On Fri, Dec 10, 2004 at 06:22:37PM -0600, Adam Heath wrote:
> >
> > Actually, I think this is a security issue.  Since any plain old program can
> > read from /dev/urandom at any time, an attacker could attempt to read from
> > that device at the same moment some other program is doing so, and thereby
> > gain some knowledge as to the other program's state.
>
> It could be a potential exploit, but....
>
> 	(a) it only applies on SMP machines
> 	(b) it's not a remote exploit; the attacker needs to have
> 		the ability to run arbitrary programs on the local
> 		machine
> 	(c) the attacker won't get all of other programs' reads of
> 		/dev/urandom, and
> 	(d) the attacker would have to have a program continuously
> 		reading from /dev/urandom, which would take up enough
> 		CPU time that it would be rather hard to hide.
>
> That's not to say that we shouldn't fix it at our earliest
> convenience, and I'd urge Andrew to push this to Linus for 2.6.10 ---
> but I don't think we need to move heaven and earth to try to
> accelerate the 2.6.10 release process, either.

Is it a problem for other kernel versions?  2.4?  Shouldn't this patch be
pushed out separately to distributions?
