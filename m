Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBPCZC>; Thu, 15 Feb 2001 21:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129138AbRBPCYx>; Thu, 15 Feb 2001 21:24:53 -0500
Received: from HSE-Montreal-ppp103309.qc.sympatico.ca ([64.230.176.130]:11027
	"EHLO mx1.lcis.net") by vger.kernel.org with ESMTP
	id <S129107AbRBPCYg>; Thu, 15 Feb 2001 21:24:36 -0500
Date: Thu, 15 Feb 2001 21:24:10 -0500 (EST)
From: "Gord R. Lamb" <glamb@lcis.dyndns.org>
X-X-Sender: <glamb@localhost.localdomain>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Samba performance / zero-copy network I/O
In-Reply-To: <982190431.3a8b095f4b3c4@eargle.com>
Message-ID: <Pine.LNX.4.32.0102152111210.1074-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Tom Sightler wrote:

> Quoting "Gord R. Lamb" <glamb@lcis.dyndns.org>:
>
> > On Wed, 14 Feb 2001, Jeremy Jackson wrote:
> >
> > > "Gord R. Lamb" wrote:
> > > > in etherchannel bond, running
> > linux-2.4.1+smptimers+zero-copy+lowlatency)
>
> Not related to network, but why would you have lowlatency patches on
> this box?

Well, I figured it might reduce deadweight time between the different
operations (disk reads, cache operations, network I/O) at the expense of a
little throughput.  It was just a hunch and I don't fully understand the
internals (of any of this, really).  Since I wasn't saturating the disk or
network controller, I thought the gain from quicker response time (for
packet acknowledgement, etc.) would outweigh the loss of individual
throughputs.  Again, I could be misunderstanding this completely. :)

> My testing showed that the lowlatency patches abosolutely destroy a
> system thoughput under heavy disk IO.  Sure, the box stays nice and
> responsive, but something has to give.  On a file server I'll trade
> console responsivness for IO performance any day (might choose the
> opposite on my laptop).

Well, I backed out that particular patch, and it didn't seem to make much
of a difference either way.  I'll look at it in more detail tomorrow
though.

Cya.

> My testing wasn't very complete, but heavy dbench and multiple
> simultaneous file copies both showed significantly lower performance
> with lowlatency enabled, and returned to normal when disabled.
>
> Of course you may have had lowlatency disabled via sysctl but I was
> mainly curious if your results were different.
>
> Later,
> Tom
>

