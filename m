Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293471AbSBZCJX>; Mon, 25 Feb 2002 21:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSBZCJS>; Mon, 25 Feb 2002 21:09:18 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39442 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293471AbSBZCH6>;
	Mon, 25 Feb 2002 21:07:58 -0500
Date: Mon, 25 Feb 2002 23:07:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <20020225.180122.120462472.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0202252305170.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, David S. Miller wrote:
>  From: Rik van Riel <riel@conectiva.com.br>
>    On Mon, 25 Feb 2002, David S. Miller wrote:
>
>    > Please fix the atomic_t assumptions in init_page_count() first.
>    > You should be using atomic_set(...).
>
>    Why ?   You'll see init_page_count() is _only_ used from
>    free_area_init_core(), when nothing else is using the VM
>    yet.
>
> Rik, not every architecture has a "counter" member of
> atomic_t, that is the problem.  This is a hard bug, please
> fix it.  It is an opaque type, accessing its' implementation
> directly is therefore illegal in the strongest way possible.

OK, agreed.   I'm making a new patch right now.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

