Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289301AbSA1SC1>; Mon, 28 Jan 2002 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSA1SCR>; Mon, 28 Jan 2002 13:02:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39687 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289301AbSA1SCF>;
	Mon, 28 Jan 2002 13:02:05 -0500
Date: Mon, 28 Jan 2002 16:01:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201281558100.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Linus Torvalds wrote:

> I am, for example, very interested to see if Rik can get the overhead of
> the rmap stuff down low enough that it's not a noticeable hit under
> non-VM-pressure. I'm looking at the issue of doing COW on the page tables
> (which really is a separate issue), because it might make it more
> palatable to go with the rmap approach.

I'd be interested to know exactly how much overhead -rmap is
causing for both page faults and fork   (but I'm sure one of
the regular benchmarkers can figure that one out while I fix
the RSS limit stuff ;))

About page table COW ... I've thought about it a lot and it
wouldn't surprise me if the 4 MB granularity of page tables
is too large to be of a real benefit since the classic path
of fork+exec would _still_ get all 3 page tables of the
typical process copied.

OTOH, it wouldn't surprise me at all if it was a win ;))

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

