Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSATVlW>; Sun, 20 Jan 2002 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287882AbSATVlM>; Sun, 20 Jan 2002 16:41:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1042 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287279AbSATVlF>;
	Sun, 20 Jan 2002 16:41:05 -0500
Date: Sun, 20 Jan 2002 19:40:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4B3703.6080101@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201936340.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> >>and should otherwise check to see if the filesystem supports something
> >>like pressure_fs_cache(), yes?
> >
> >That's incompatible with the concept of memory zones.
>
> Care to explain more?

On basically any machine we'll have multiple memory zones.

Each of those memory zones has its own free list and each
of the zones can get low on free pages independantly of the
other zones.

This means that if the VM asks to get a particular page
freed, at the very minimum you need to make a page from the
same zone freeable.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

