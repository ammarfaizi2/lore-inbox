Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSBZBlZ>; Mon, 25 Feb 2002 20:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSBZBlJ>; Mon, 25 Feb 2002 20:41:09 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:24337 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293373AbSBZBkx>;
	Mon, 25 Feb 2002 20:40:53 -0500
Date: Mon, 25 Feb 2002 22:40:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Shawn Starr <spstarr@sh0n.net>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <4360000.1014687125@flay>
Message-ID: <Pine.LNX.4.33L.0202252238250.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Martin J. Bligh wrote:

> > Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> > on this P200 w/ 64MB ram.
>
> rmap still sucks on large systems though. I'd love to see rmap
> in the main kernel, but it needs to get the scalability fixed first.
> The main problem seems to be pagemap_lru_lock ... Rik & crew
> know about this problem, but let's give them some time to fix it
> before rmap gets put into mainline ....

This isn't very near on my TODO list though, I've got
the following big items coming up shortly:

rmap 13:   O(1) page_launder    <- working on it now

rmap 14:   pte-highmem support

In addition to this I'm merging some small pieces of code
with both Linus and Marcelo.

Making the locking more scaleable wrt. the pagemap_lru_lock
could be either a simple change or a rework of the way the
VM does locking. I'm not sure which way to go...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

