Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRCFCkM>; Mon, 5 Mar 2001 21:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130879AbRCFCkC>; Mon, 5 Mar 2001 21:40:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:33259 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130873AbRCFCjq>;
	Mon, 5 Mar 2001 21:39:46 -0500
Date: Mon, 5 Mar 2001 21:39:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J . A . Magallon" <jamagallon@able.es>,
        Sergey Kubushin <ksi@cyberbills.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <E14a6sE-0008GS-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0103052133490.27373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Mar 2001, Alan Cox wrote:

> > Yuck. Build-dependency on libdb-dev is not pretty. What is it used for,
> > anyway? Assembler in need of libdb. Mind boggleth...
> 
> Could it perhaps be persuaded to use Tridge's tdb, which at < 1000 lines could
> simply be included with it...

Alan, AFAICS they never remove entries, they only do adds and lookups by
string key and they keep the whole thing in memory all the time. Oh, and
they don't give it too hard use, to put it mildly.

IOW, I'm pretty sure that even a LRU list will be sufficient. Hash definitely
will be enough. Any *db is an overkill here - it's a symbol table, for fsck
sake...
							Cheers,
								Al

