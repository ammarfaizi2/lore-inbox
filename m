Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBETzV>; Mon, 5 Feb 2001 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBETzL>; Mon, 5 Feb 2001 14:55:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:275 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129051AbRBETzE>; Mon, 5 Feb 2001 14:55:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:190!
Date: 5 Feb 2001 11:54:29 -0800
Organization: Transmeta Corporation
Message-ID: <95n0dl$uhk$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0102051942040.875-100000@wasyl.dom.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0102051942040.875-100000@wasyl.dom.pl>,
Jakub Wasielewski  <wasyl@infoland.com.pl> wrote:
>[1.] One line summary of the problem: kernel BUG at page_alloc.c:190!

I really need the symbolic oops information with the first oops piped
through ksymoops:

>kernel BUG at page_alloc.c:190!

This basically should happen only if the memory zone lists have become
nastily corrupted.  But I'd need to see the decode of this:

>Call Trace: [<c012e465>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c01137d4>]
>       [<c011d99f>] [<c0113d7a>] [<c01090dc>] [<c010002b>]

to get an idea of what was going on at the time.. The other oopses are
not interesting, they're just more result of the corrupted memory maps.

>[7.7.] Other information that might be relevant to the problem:
>Well,  as  you can see the procs are overclocked (433@541) but that never
>caused me problems. If my bug is caused by overclocking please accept  my
>apologies!

This is the likeliest explanation, though. A small amount of cache
corruption due to your quite radically overclocked CPU's can do
anything..

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
