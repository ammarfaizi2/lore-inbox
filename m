Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSBGMm5>; Thu, 7 Feb 2002 07:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBGMms>; Thu, 7 Feb 2002 07:42:48 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287676AbSBGMmf>;
	Thu, 7 Feb 2002 07:42:35 -0500
Date: Thu, 7 Feb 2002 10:42:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <Ulrich.Weigand@de.ibm.com>,
        <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The IBM order relaxation patch
In-Reply-To: <20020207.042903.71864726.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0202071041560.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Thu, 7 Feb 2002 10:16:22 -0200 (BRST)
>
>    The only problem is that it doesn't.  It won't try to free
>    pages once you have enough free pages, which means you'll
>    just end up in a livelock.
>
> It always calls balance_classzone which always calls try_to_free_pages
> which always will try to free SWAP_CLUSTER_MAX pages.

Duh, indeed.  It seems Linus' free_plenty() checks were
removed somewhere along the way.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

