Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293463AbSBZB6Q>; Mon, 25 Feb 2002 20:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSBZB6E>; Mon, 25 Feb 2002 20:58:04 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:7186 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293439AbSBZB5y>;
	Mon, 25 Feb 2002 20:57:54 -0500
Date: Mon, 25 Feb 2002 22:57:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <20020225.174911.82037594.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0202252254380.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, David S. Miller wrote:

>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Mon, 25 Feb 2002 22:47:00 -0300 (BRT)
>
>    Please apply for 2.4.19-pre2.
>
> Please fix the atomic_t assumptions in init_page_count() first.
> You should be using atomic_set(...).

Why ?   You'll see init_page_count() is _only_ used from
free_area_init_core(), when nothing else is using the VM
yet.

This exact same code has been in -rmap for a few months
and went into 2.5 just over a week ago.  It doesn't seem
to give any problems ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

