Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTBFGFa>; Thu, 6 Feb 2003 01:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTBFGFa>; Thu, 6 Feb 2003 01:05:30 -0500
Received: from [209.195.52.121] ([209.195.52.121]:40579 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S261701AbTBFGF3>; Thu, 6 Feb 2003 01:05:29 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Larry McVoy <lm@work.bitmover.com>, Ben Collins <bcollins@debian.org>,
       Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@e-mind.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 5 Feb 2003 22:14:40 -0800 (PST)
Subject: Re: openbkweb-0.0
In-Reply-To: <20030206060223.GB6859@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0302052213070.29263-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remember that any bk repository will have all the info in it, so just
access that instead of bkbits.org (yes this will require someone to run
the evil propriatary software ;-), but it will avoid the load on Larry's
server)

David Lang

On Thu, 6 Feb 2003, Willy Tarreau wrote:

> Date: Thu, 6 Feb 2003 07:02:23 +0100
> From: Willy Tarreau <willy@w.ods.org>
> To: Larry McVoy <lm@work.bitmover.com>, Ben Collins <bcollins@debian.org>,
>      Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@e-mind.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: openbkweb-0.0
>
> On Wed, Feb 05, 2003 at 08:37:37PM -0800, Larry McVoy wrote:
> > > You may want to enable mod_deflate, and then scripts can easily make use
> > > of gzip compressed data. May not be an end-all, but something to
> > > consider.
> >
> > Gzip will give 4:1 what these scripts are doing is more like 1000:1.
> > So gzipping the data gets you down to 250:1.  That's still way more
> > bandwidth, way too much to be acceptable.
>
> Larry, would it be acceptable/possible to regularly push some data/metadata
> to sites like kernel.org that people already consult for kernel development ?
> This way, Andrea's tool would only have to check kernel.org, and not bkbits.net.
>
> Another solution is to fetch from a reverse proxy-cache on a high-bandwidth
> site, provided that we know what to cache, of course. This could even reduce
> your current HTTP usage since nearly everything should be cacheable for a very
> long period.
>
> You know, sometimes I fetch changesets from bkbits.net with my browser, and
> I later convert them from html to text with a very trivial sed script. And it
> happens that I remember you saying that the bandwidth costs you very much, then
> I feel a bit guilty (although about once a week may not be too much) and I
> wonder what would happen if everyone did the same regularly.
>
> You may also try to cap the bandwidth from the web server, to dissuade people
> from using it, but still not closing it. This could also help you not to pay
> for the extra bytes.
>
> Just some suggestions, of course. I wouldn't like your http service to be
> closed since I sometimes use it.
>
> Cheers,
> Willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
