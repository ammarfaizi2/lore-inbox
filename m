Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRLFRxD>; Thu, 6 Dec 2001 12:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281692AbRLFRwz>; Thu, 6 Dec 2001 12:52:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5384 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281691AbRLFRwh>; Thu, 6 Dec 2001 12:52:37 -0500
Date: Thu, 6 Dec 2001 15:52:16 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, <lm@bitmover.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <Pine.LNX.4.40.0112060922060.1603-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L.0112061551220.2283-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Davide Libenzi wrote:

> > Machines get dragged down by _uncontended_ locks, simply
> > due to cache line ping-pong effects.
>
> Rik, i think you're confused about lockless algos.
> It's not an rwlock where the reader has to dirty a cacheline in any case,
> the reader simply does _not_ write any cache line accessing the
> list/hash/tree or whatever you use.

Hmmm indeed, so the cache lines can be shared as long
as the data is mostly read-only. I think I see it now.

However, this would only work for data which is mostly
read-only, not for anything else...

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

