Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288613AbSADMPy>; Fri, 4 Jan 2002 07:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMPp>; Fri, 4 Jan 2002 07:15:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6149 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288607AbSADMPi>; Fri, 4 Jan 2002 07:15:38 -0500
Date: Fri, 4 Jan 2002 10:15:17 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Harald Holzer <harald.holzer@eunet.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <Pine.LNX.4.21.0201041206290.16016-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0201041012520.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Hugh Dickins wrote:
> On Thu, 3 Jan 2002, Rik van Riel wrote:
> > On Thu, 3 Jan 2002, Alan Cox wrote:
> > > A lot of it is the page structs (64bytes per page - which really
> > > should be nearer the 32 some rival Unix OS's achieve on x86)
> >
> > The 2.4 kernel has the page struct at 52 bytes in size,
> > William Lee Irwin and I have brought this down to 36.
>
> Please restate those numbers, Rik: I share Alan's belief that the
> current standard 2.4 kernel has page struct at 64 bytes in size.

Indeed, I counted wrong ... substracted the waitqueue when counting
the first time, then substracted it again ;)

The struct page in the current kernel is indeed 64 bytes. In
the rmap VM it's also 64 bytes (60 bytes if highmem is disabled).

After removal of the waitqueue, that'll be 52 bytes, or 48 if
highmem is disabled.

kind regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

