Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289359AbSAVTEU>; Tue, 22 Jan 2002 14:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289358AbSAVTEF>; Tue, 22 Jan 2002 14:04:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:4101 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289355AbSAVTDU>;
	Tue, 22 Jan 2002 14:03:20 -0500
Date: Tue, 22 Jan 2002 17:03:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Hans Reiser <reiser@namesys.com>, Andreas Dilger <adilger@turbolabs.com>,
        Chris Mason <mason@suse.com>, Shawn Starr <spstarr@sh0n.net>,
        <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DB256.172F8D6A@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0201221649430.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Andrew Morton wrote:
> Hans Reiser wrote:
> >
> > So is there a consensus view that we need 2 calls, one to write a
> > particular page, and one to exert memory pressure, and the call to write
> > a particular page should only be used when we really need to write that
> > particular page?
>
> Note that writepage() doesn't get used much.  Most VM-initiated
> filesystem writeback activity is via try_to_release_page(), which
> has somewhat more vague and flexible semantics.

We may want to change this though, or at the very least get
rid of the horrible interplay between ->writepage and
try_to_release_page() ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

