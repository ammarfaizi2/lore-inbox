Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288452AbSAVUVg>; Tue, 22 Jan 2002 15:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSAVUVZ>; Tue, 22 Jan 2002 15:21:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:522 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288452AbSAVUVK>;
	Tue, 22 Jan 2002 15:21:10 -0500
Date: Tue, 22 Jan 2002 18:20:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DB36F.4090306@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201221818140.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Hans Reiser wrote:
> Rik van Riel wrote:
> >On Tue, 22 Jan 2002, Chris Mason wrote:

> >>The FS doesn't know how long a page has been dirty, or how often it
> >>gets used,
> >
> >In an efficient system, the FS will never get to know this, either.
>
> I don't understand this statement.  If dereferencing a vfs op for
> every page aging is too expensive, then ask it to age more than one
> page at a time.  Or do I miss your meaning?

Please repeat after me:

 "THE  FS  DOES  NOT  SEE  THE  MMU  ACCESSED  BITS"

Also, if a piece of data is in the page cache, it is accessed
without calling the filesystem code.


This means the filesystem doesn't know how often pages are or
are not used, hence it cannot make the decisions the VM make.

Or do you want to have your own ReiserVM and ReiserPageCache ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

