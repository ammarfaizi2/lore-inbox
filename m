Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSDDPVl>; Thu, 4 Apr 2002 10:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313194AbSDDPVb>; Thu, 4 Apr 2002 10:21:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6665 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313190AbSDDPVQ>;
	Thu, 4 Apr 2002 10:21:16 -0500
Date: Thu, 4 Apr 2002 12:21:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ingo Molnar <mingo@redhat.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44L.0204041217290.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Ingo Molnar wrote:

> I consider 'abuse' for example a kernel derivative with a 'modified'
> scheduler. The day it will be possible to put a binary-only sched.o into
> the kernel i'll stop doing Linux. I am not here to develop some 'lite'
> version of the OS, where all the interesting stuff happens behind closed
> doors. I'm not here either to see the quality of the OS degrade due to
> sloppy programming in widely used binary-only modules, without being able
> to fix it.

Absolutely agreed.  I've already seen it happen a few times that
a user needed _2_ binary-only modules, modules which weren't even
available for the same kernel version.

As it stands right now it is IMPOSSIBLE to support binary only
drivers and I can only see two ways out of this situation:

(1) don't allow binary only modules at all

(2) have a stable ABI for binary only modules and don't allow
    these binary only modules to use other symbols, so people
    in need of binary only modules won't be locked to one
    particular version of the kernel (or have two binary only
    modules locked to _different_ versions of the kernel)



kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

