Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136787AbREBAof>; Tue, 1 May 2001 20:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136784AbREBAo0>; Tue, 1 May 2001 20:44:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24845 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S136787AbREBAoK>;
	Tue, 1 May 2001 20:44:10 -0400
Date: Tue, 1 May 2001 21:43:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <15087.22036.811357.526981@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105012143000.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, David S. Miller wrote:
> Rik van Riel writes:
>  > Then we will be scanning through memory looking for something to
>  > swap out (otherwise we'd not be in need of swap space, right?).
>  > At this point we can simply free up swap entries while scanning
>  > through memory looking for stuff to swap out.
> 
> Sounds a lot like my patch I posted a few weeks ago:

Not really. Your patch only reclaims swap cache pages that
hang around after a process exit()s. What I want to do is
reclaim swap space of pages which have been swapped in so
we can use that swap space to swap something else out.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

