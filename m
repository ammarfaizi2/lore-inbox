Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267169AbSKSTT6>; Tue, 19 Nov 2002 14:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSKSTT6>; Tue, 19 Nov 2002 14:19:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7175 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267169AbSKSTT5>; Tue, 19 Nov 2002 14:19:57 -0500
Date: Tue, 19 Nov 2002 11:26:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Oracle 9.2 OOMs again at startup in 2.5.4[78]
In-Reply-To: <3DDA8C18.1000903@oracle.com>
Message-ID: <Pine.LNX.4.44.0211191118300.2193-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, Alessandro Suardi wrote:
> 
> The web interface seems to be at fault (or is it your fingers ;)
>   from my saved mail with Linus and yourself I have...

No, what is at fault is thinking that the BK revision numbers mean 
anything. They don't.

A BK revision number is _purely_ local to the tree it was gotten off, and 
will be meaningless after a merge of two trees have happened. The only 
thing that really means anything in BK is the "ChangeSet key", which is a 
truly unique identifier, and is painful as hell to type because of that.

In this case, the key for the changeset that Alessandro was talking about 
is

	torvalds@home.transmeta.com|ChangeSet|20020529050157|61124

(currently revision 1.373.214.73 in my tree) and the key for the fix is 

	hugh@veritas.com|ChangeSet|20021001154212|00224

(currently 1.573.94.1 in my tree).

You can see the key's with "bk changes -k", or if you want to see a 
combination of keys etc you can do more fancy stuff (I used

	bk changes -d":KEY: ':REV:'\n:AUTHOR:\n:COMMENTS:\n" | less

to search for comments and key information, in case you care).

Thus endeth BK 101.

		Linus


