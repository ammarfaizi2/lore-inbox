Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289566AbSAVXfq>; Tue, 22 Jan 2002 18:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289573AbSAVXff>; Tue, 22 Jan 2002 18:35:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:25363 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289564AbSAVXfS>;
	Tue, 22 Jan 2002 18:35:18 -0500
Date: Tue, 22 Jan 2002 21:34:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DE825.1030406@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201222132550.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Hans Reiser wrote:

> Let's try a non-reiserfs sub-cache example.  Suppose you have a cache
> of objects that are smaller than a page.

> Suppose that there is absolutely no correlation in access between the
> objects that are on the same page.  Suppose that this subcache has
> methods for freeing however many of them it wants to free, and it can
> squeeze them together into fewer pages whenever it wants to.

In this case I absolutely agree with you.

In this case it is also _possible_ because all access
to these data structures goes through the filesystem
code, so the filesystem knows exactly which object is
a candidate for freeing and which isn't.

I think the last messages from the thread were a
miscommunication between us -- I was under the impression
that you wanted per-filesystem freeing decisions for things
like page cache pages.

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

