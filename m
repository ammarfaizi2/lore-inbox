Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266516AbRGGSGB>; Sat, 7 Jul 2001 14:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266518AbRGGSFv>; Sat, 7 Jul 2001 14:05:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7691 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266516AbRGGSFq>; Sat, 7 Jul 2001 14:05:46 -0400
Date: Sat, 7 Jul 2001 15:05:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH #2] OOM kill trigger
In-Reply-To: <3B466FF7.81138181@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L.0107071504460.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Jeff Garzik wrote:
> Rik van Riel wrote:
> > +       cache_mem = atomic_read(&page_cache_size);
> > +       cache_mem += atomic_read(&buffermem_pages);
> > +       cache_mem -= swapper_space.nrpages;
> > +       limit = (page_cache.min_percent + buffer_mem.min_percent);
>
> Don't you need extra protection around swapper_space.nrpages?
> A barrier right above it?

No. It's just a heuristic.

Besides, all that could change is the VALUE of
swapper_space.nrpages and it won't change by all
that much...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

