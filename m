Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281907AbRKUPj5>; Wed, 21 Nov 2001 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281909AbRKUPji>; Wed, 21 Nov 2001 10:39:38 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:23306 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281907AbRKUPje>; Wed, 21 Nov 2001 10:39:34 -0500
Date: Wed, 21 Nov 2001 13:39:18 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "David S. Miller" <davem@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <Pine.LNX.4.21.0111211515210.1357-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0111211338330.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Hugh Dickins wrote:

> > In that case, why can't we just take the next mm from
> > init_mm and just "roll over" our mm to the back of the
> > list once we're done with it ?
>
> No.  That's how it used to be, that's what I changed it from.
>
> fork and exec are well ordered in how they add to the mmlist,
> and that ordering (children after parent) suited swapoff nicely,
> to minimize duplication of a swapent while it's being unused;
> except swap_out randomized the order by cycling init_mm around it.

Urmmm, so the code was obfuscated in order to optimise
swapoff() ?

Exactly how bad was the "mmlist randomising" for swapoff() ?

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

