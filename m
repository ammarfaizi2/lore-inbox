Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288940AbSAISDg>; Wed, 9 Jan 2002 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSAISD0>; Wed, 9 Jan 2002 13:03:26 -0500
Received: from mustard.heime.net ([194.234.65.222]:49613 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288940AbSAISDH>; Wed, 9 Jan 2002 13:03:07 -0500
Date: Wed, 9 Jan 2002 19:02:13 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files :-)
In-Reply-To: <Pine.LNX.4.33L.0201091201330.2985-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.30.0201091901120.8463-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, guys!

This actually solved the problem, and even gave me a little increase in
read speed as a bonus.

Is this somehow planned for a 2.4 merge?

roy

On Wed, 9 Jan 2002, Rik van Riel wrote:

> On Wed, 9 Jan 2002, Roy Sigurd Karlsbakk wrote:
>
> > > you really should try akpm's "[patch, CFT] improved disk read latency"
> > > patch.  it sounds almost perfect for your application.
>
> > It seemed like it helped first, but after a while, some 99 processes
> > went Defunct, and locked. After this, the total 'bi' as reported from
> > vmstat went down to ~ 900kB per sec
> >
> > What should I do?
>
> I've done a little bit of low memory testing with my -rmap
> VM patch, the system seems to be working just fine with 8MB
> of RAM ...
>
> If you have the time, could you try the following patch ?
>
> 	http://surriel.com/patches/2.4/2.4.17-rmap-11a
>
>
> regards,
>
> Rik
> --
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
>
> http://www.surriel.com/		http://distro.conectiva.com/
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

