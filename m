Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273644AbRIYVUq>; Tue, 25 Sep 2001 17:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273806AbRIYVUg>; Tue, 25 Sep 2001 17:20:36 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:60150 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S273502AbRIYVUY>; Tue, 25 Sep 2001 17:20:24 -0400
Date: Tue, 25 Sep 2001 17:20:16 -0400
From: Rick Haines <rick@kuroyi.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive pages
Message-ID: <20010925172016.B860@sasami.kuroyi.net>
In-Reply-To: <Pine.LNX.4.33.0109250849480.7353-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0109251311340.26091-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109251311340.26091-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 01:13:37PM -0300, Rik van Riel wrote:
> On Tue, 25 Sep 2001, Linus Torvalds wrote:
> > On Tue, 25 Sep 2001, Rik van Riel wrote:
> > > >
> > > > swap_out() will deactivate everything it finds to be not-recently used,
> > > > and that's how the inactive list ends up getting replenished.
> > >
> > > mlock()
> >
> > Hey, if you've mlock'ed more than your available memory, there's nothing
> > the VM layer can do. Except maybe a nice printk("Kiss your *ss goodbye");

Shouldn't there be a threshold where mlock will fail?
Or are you saying that in general mlocking lots of memory will screw the
VM?

> But if you've mlock()ed enough to clog up the inactive
> list, the VM could just move the pages it cannot free
> back to the active list and it will come across those
> pages which are freeable eventually.
> 
> Note that the maximum amount of mlock()ed memory is way
> higher than the maximum amount of pages the system puts
> on the inactive list.
> 
> (at least, it was last I looked at the maximum number
> of mlocked pages)
> 
> regards,
> 
> Rik
> --
> IA64: a worthy successor to the i860.
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Rick (rick@kuroyi.net)
http://dxr3.sourceforge.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
