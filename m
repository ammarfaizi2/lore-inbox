Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTBFF7V>; Thu, 6 Feb 2003 00:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTBFF7V>; Thu, 6 Feb 2003 00:59:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:63504 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265382AbTBFF7T>;
	Thu, 6 Feb 2003 00:59:19 -0500
Date: Thu, 6 Feb 2003 07:02:23 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Larry McVoy <lm@work.bitmover.com>, Ben Collins <bcollins@debian.org>,
       Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@e-mind.com>,
       linux-kernel@vger.kernel.org
Subject: Re: openbkweb-0.0
Message-ID: <20030206060223.GB6859@alpha.home.local>
References: <20030206021029.GW19678@dualathlon.random> <20030206030908.GA26137@work.bitmover.com> <20030206042303.GB523@phunnypharm.org> <20030206043737.GA27374@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206043737.GA27374@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 08:37:37PM -0800, Larry McVoy wrote:
> > You may want to enable mod_deflate, and then scripts can easily make use
> > of gzip compressed data. May not be an end-all, but something to
> > consider.
> 
> Gzip will give 4:1 what these scripts are doing is more like 1000:1.  
> So gzipping the data gets you down to 250:1.  That's still way more
> bandwidth, way too much to be acceptable.

Larry, would it be acceptable/possible to regularly push some data/metadata
to sites like kernel.org that people already consult for kernel development ?
This way, Andrea's tool would only have to check kernel.org, and not bkbits.net.

Another solution is to fetch from a reverse proxy-cache on a high-bandwidth
site, provided that we know what to cache, of course. This could even reduce
your current HTTP usage since nearly everything should be cacheable for a very
long period.

You know, sometimes I fetch changesets from bkbits.net with my browser, and
I later convert them from html to text with a very trivial sed script. And it
happens that I remember you saying that the bandwidth costs you very much, then
I feel a bit guilty (although about once a week may not be too much) and I
wonder what would happen if everyone did the same regularly.

You may also try to cap the bandwidth from the web server, to dissuade people
from using it, but still not closing it. This could also help you not to pay
for the extra bytes.

Just some suggestions, of course. I wouldn't like your http service to be
closed since I sometimes use it.

Cheers,
Willy

