Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290981AbSBGXbP>; Thu, 7 Feb 2002 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291013AbSBGXbG>; Thu, 7 Feb 2002 18:31:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1799 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290981AbSBGXa5>;
	Thu, 7 Feb 2002 18:30:57 -0500
Date: Thu, 7 Feb 2002 21:30:36 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shawn Starr <shawn.starr@datawire.net>
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: Problem with rmap-12c
In-Reply-To: <1013121170.226.0.camel@unaropia>
Message-ID: <Pine.LNX.4.33L.0202072129190.17850-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2002, Shawn Starr wrote:
> On Thu, 2002-02-07 at 17:12, Rik van Riel wrote:
> > On 7 Feb 2002, Louis Garcia wrote:
> >
> > > I tried rmap-12c and had lots of swap usage. I when back to 12a and
> > > everything calmed down. Is their a known problem with 12c?
> >
> > Nope, but the RSS limit enforcing stuff is a possible
> > suspect.
> >
> > It turns out I used a "struct pte_t" in over_rss_limit(),
> > which turned into a compiler warning, for which I didn't
> > spot the cause ;)

> Please do :)
>
> I've been noticing those same results.

OK, uploaded.  I'd love to hear if this stupid extra
'struct' statement was causing the trouble or if there's
a more fundamental problem with 12c.

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

