Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbRL1XNI>; Fri, 28 Dec 2001 18:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284289AbRL1XM7>; Fri, 28 Dec 2001 18:12:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22287 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284305AbRL1XMs>; Fri, 28 Dec 2001 18:12:48 -0500
Date: Fri, 28 Dec 2001 15:10:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <esr@thyrsus.com>, Legacy Fishtank <garzik@havoc.gtf.org>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <E16K6BQ-00029u-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112281504210.23482-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Dec 2001, Alan Cox wrote:
>
> It would certainly fit nicely with the existing metadata. We already rip out
> code comments via kernel-doc, and extending it to rip out
>
> 	-	Help text
> 	-	Web site
...

No no no.

The comments can at least be helpful to programmers, whether ripped out or
not.

Extra stuff is not helpful to anybody, and is just really irritating. I
personally despise source trees that start out with one page of copyright
statement crap, it just detracts from the real _point_ of the .c file,
which is to contain C code. Making it a comment requirement is

 - stupid:
	we have a filesystem, guys

 - slow:
	we don't need to parse every C file we encounter when we can just
	open another file based on filename

 - nonsensical:
	many config options are _not_ limited to one C file

 - hard to parse and read:
	why limit ourself to C comments, when just keeping the thing
	logically separated means that we don't have to.

Having per-function comment blocks, in contrast, makes sense to have
inline:

 - you read the comment when you read the function

 - you might even update the comment when you update the function

 - you have a reasonable 1:1 relationship.

_None_ of those are sensible for config file entries.

		Linus

