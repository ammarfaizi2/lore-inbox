Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSATVcl>; Sun, 20 Jan 2002 16:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSATVcb>; Sun, 20 Jan 2002 16:32:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33297 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284305AbSATVc0>;
	Sun, 20 Jan 2002 16:32:26 -0500
Date: Sun, 20 Jan 2002 19:32:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B35AB.4040801@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201931250.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:
> Mark Hahn wrote:
> >On Sun, 20 Jan 2002, Hans Reiser wrote:
> >
> >>Write clustering is one thing it achieves.   When we flush a slum, the
> >
> >sure, that's fine.  when the VM tells you to write a page,
> >you're free to write *more*, but you certainly must give back
> >that particular page.  afaicr, this was the conclusion
> >of the long-ago thread that you're referring to.
>
> This is bad for use with internal nodes.  It simplifies version 4 a
> bunch to assume that if a node is in cache, its parent is also.  Not
> sure what to do about it, maybe we need to copy the node.  Surely we
> don't want to copy it unless it is a DMA related page cleaning.

DMA isn't a special case, this thing can happen with ANY
memory zone.

Unless of course you decide to make reiserfs unsupported
for NUMA machines...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

