Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135978AbREBBbb>; Tue, 1 May 2001 21:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135990AbREBBbX>; Tue, 1 May 2001 21:31:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12815 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135978AbREBBbN>;
	Tue, 1 May 2001 21:31:13 -0400
Date: Tue, 1 May 2001 22:30:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Roger Larsson <roger.larsson@norran.net>
Cc: "David S. Miller" <davem@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200105020117.f421H9F03748@mailf.telia.com>
Message-ID: <Pine.LNX.4.21.0105012222360.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Roger Larsson wrote:
> On Wednesday 02 May 2001 02:43, Rik van Riel wrote:
> > On Tue, 1 May 2001, David S. Miller wrote:
> > > Rik van Riel writes:
> > >  > Then we will be scanning through memory looking for something to
> > >  > swap out (otherwise we'd not be in need of swap space, right?).
> > >  > At this point we can simply free up swap entries while scanning

> We could reclaim swap space for dirty pages. They have to be
> rewritten anyway...
> 
> Or would the fragmentation risk be too high?

I guess the fragmentation would get worse. Also, when you've got
more than enough swap left there's absolutely no reason to reclaim
the swap when pages get dirtied.

I just guess we should start reclaiming swap space as soon as the
free swap space gets below, say, 5%. We could go for a more complex
system of only reclaiming the swap space of dirty pages from a lower
threshold on, but I doubt that's worth the complexity.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

