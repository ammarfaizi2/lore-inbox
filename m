Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136785AbREBA3L>; Tue, 1 May 2001 20:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136784AbREBA3A>; Tue, 1 May 2001 20:29:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49932 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S136782AbREBA2q>;
	Tue, 1 May 2001 20:28:46 -0400
Date: Tue, 1 May 2001 21:28:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <20010501140003.A28747@redhat.com>
Message-ID: <Pine.LNX.4.21.0105012119110.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Stephen C. Tweedie wrote:

> The right fix is to reclaim such pages only when we need to.  To
> disable swap caching when we still have enough swap free would hurt
> users who have the spare swap to cope with it.

That's easy enough. When we are:
1. almost out of swap and
2. need swap space

Then we will be scanning through memory looking for something to
swap out (otherwise we'd not be in need of swap space, right?).
At this point we can simply free up swap entries while scanning
through memory looking for stuff to swap out.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

