Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289998AbSAWThP>; Wed, 23 Jan 2002 14:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289999AbSAWThE>; Wed, 23 Jan 2002 14:37:04 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:45838 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289998AbSAWTg4>;
	Wed, 23 Jan 2002 14:36:56 -0500
Date: Wed, 23 Jan 2002 17:36:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap VM, version 12
In-Reply-To: <20020123.112837.112624842.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201231735540.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:

>    If there is some specific magic I'm missing, could you
>    please point me to the code I'm overlooking ? ;)
>
> Look at what get_pgd_slow() in pgalloc.h does, this is the
> case where it isn't going to the cache and it is really allocating the
> memory.

> Hmmm... maybe the "we can fault on kernel mappings" thing takes
> care of this because kernel PMDs can only appear, not go away.

OK, so only the _pgd_ quicklist is questionable and the
_pte_ quicklist is fine ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

