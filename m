Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271276AbRHZF0P>; Sun, 26 Aug 2001 01:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271286AbRHZF0F>; Sun, 26 Aug 2001 01:26:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2317 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271276AbRHZFZu>; Sun, 26 Aug 2001 01:25:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 07:28:03 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "Marc A. Lehmann" <pcg@goof.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108260032490.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108260032490.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826052500Z16213-32383+1412@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 05:40 am, Rik van Riel wrote:
> On Sat, 25 Aug 2001, John Stoffel wrote:
> 
> > Ummm... is this really more of an agreement that Daniel's used-once
> > patch is a good idea on a system.  Keep a page around if it's used
> > once, but drop it quickly if only used once?
> 
> There's a very big difference, though.  With use-once we'll
> also quickly drop the pages we have not yet used, that is,
> the pages we _are about to use_.

You're really complaining about the treatment of readahead pages, not the 
used-once pages.  We can arrange things so that readahead pages get higher 
priority than used-once pages, then become used-once pages when... they get 
used once.  Simple idea, but not a one-line implementation.

> Drop-behind specifically drops the pages we have already
> used, giving better protection to the pages we are about
> to use.
> 
> http://linux-mm.org/wiki/moin.cgi/StreamingIo

How will you know not to drop the pages of that header file that is used 
constantly by the compiler?

--
Daniel
