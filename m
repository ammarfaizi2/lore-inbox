Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270712AbRIFN3l>; Thu, 6 Sep 2001 09:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270748AbRIFN3a>; Thu, 6 Sep 2001 09:29:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:63497 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270712AbRIFN3U>;
	Thu, 6 Sep 2001 09:29:20 -0400
Date: Thu, 6 Sep 2001 10:29:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kurt Garloff <garloff@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <E15ezCY-00087e-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0109061028430.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Alan Cox wrote:

> > Just use two limits:
> > * Time: After some time (say two seconds), we can always afford to write it
> >   out=20
> > * Queue filling: After it has a certain size, it's worth doing a writing.
>
> Both debatable and both I can find counter cases for - think about a
> shared memory database with multiple game clients using it (eg the
> older AberMUD codebase). Writing that to disk is counterproductive

This is only for pages on the inactive_dirty list, though;
ie pages we want to evict from memory with the minimal amount
of work possible ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

