Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280682AbRKBNPB>; Fri, 2 Nov 2001 08:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280683AbRKBNOw>; Fri, 2 Nov 2001 08:14:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:55560 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280682AbRKBNOk>;
	Fri, 2 Nov 2001 08:14:40 -0500
Date: Fri, 2 Nov 2001 11:14:21 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: safemode <safemode@speakeasy.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: graphical swap comparison of aa and rik vm
In-Reply-To: <20011102130750.1760138C77@perninha.conectiva.com.br>
Message-ID: <Pine.LNX.4.33L.0111021110000.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, safemode wrote:

> I'll try it with more swap later on today after work.  But realize,
> though, the fact that you need much more swap to do the same thing
> (compared to aa's)  is not helping any adoption of the VM.

Uhhh ... this is nothing but a classical speed/size tradeoff.

The fact that under my VM swap space stays reserved for the
program on swapin means that if the page isn't dirtied, we
can just drop it without having to write it to disk again.

In situations where there is enough swap available, this
should be a win (and it has traditionally been a big win).

Andrea's VM always frees swap space on swapin, so even if
the process doesn't write to its memory at all, the data
still needs to be written out to disk again.

Only in the one corner-case where my VM runs out of swap
space and Andrea's VM doesn't yet run out of swap you'll
find situations where the tactic used by Andrea's VM has
its advantages, but I consider this to be a rare situation.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

