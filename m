Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRKECJJ>; Sun, 4 Nov 2001 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280106AbRKECJA>; Sun, 4 Nov 2001 21:09:00 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33019
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280107AbRKECIt>; Sun, 4 Nov 2001 21:08:49 -0500
Date: Sun, 4 Nov 2001 18:08:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_swap_full
Message-ID: <20011104180840.A16017@mikef-linux.matchmail.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011104152341.A4C289E898@oscar.casa.dyndns.org> <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111041436020.2963-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 02:36:34PM -0200, Rik van Riel wrote:
> On Sun, 4 Nov 2001, Ed Tomlinson wrote:
> 
> > -/* Swap 50% full? Release swapcache more aggressively.. */
> > -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
> > +/* Free swap less than inactive pages? Release swapcache more aggressively.. */
> > +#define vm_swap_full() (nr_swap_pages < nr_inactive_pages)
> 
> > Comments?
> 
> Makes absolutely no sense for systems which have more
> swap than RAM, eg. a 64MB system with 200MB of swap.
> 

How does the inactive list get bigger than physical ram?

If swap is bigger than ram, there is *no* possibility of the inactive list
being bigger than swap, and thus no aggressive swapping...

Mike
