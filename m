Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281754AbRLFSAY>; Thu, 6 Dec 2001 13:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRLFSAL>; Thu, 6 Dec 2001 13:00:11 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:28422 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281754AbRLFR7r>; Thu, 6 Dec 2001 12:59:47 -0500
Date: Thu, 6 Dec 2001 10:10:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, <lm@bitmover.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <Pine.LNX.4.33L.0112061551220.2283-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.40.0112061009291.1603-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Rik van Riel wrote:

> On Thu, 6 Dec 2001, Davide Libenzi wrote:
>
> > > Machines get dragged down by _uncontended_ locks, simply
> > > due to cache line ping-pong effects.
> >
> > Rik, i think you're confused about lockless algos.
> > It's not an rwlock where the reader has to dirty a cacheline in any case,
> > the reader simply does _not_ write any cache line accessing the
> > list/hash/tree or whatever you use.
>
> Hmmm indeed, so the cache lines can be shared as long
> as the data is mostly read-only. I think I see it now.
>
> However, this would only work for data which is mostly
> read-only, not for anything else...

yes of course, but in such case these methods could help solving cache
issues over traditional rwlocks.



- Davide


