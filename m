Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136770AbREAXZy>; Tue, 1 May 2001 19:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136768AbREAXZq>; Tue, 1 May 2001 19:25:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:28426 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S136766AbREAXZb>;
	Tue, 1 May 2001 19:25:31 -0400
Date: Tue, 1 May 2001 20:25:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <m3n18xcral.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0105012020370.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2001, Christoph Rohland wrote:
> On Mon, 30 Apr 2001, Alan Cox wrote:
> >> paging in just released 2.4.4, but in previuos kernel, a page that
> >> was paged-out, reserves its place in swap even if it is paged-in
> >> again, so once you have paged-out all your ram at least once, you
> >> can't get any more memory, even if swap is 'empty'.
> > 
> > This is a bug in the 2.4 VM, nothing more or less. It and the
> > horrible bounce buffer bugs are forcing large machines to remain on
> > 2.2. So it has to get fixed
> 
> Yes, it is a bug. and thanks for stating this so clearly.

I finished my USENIX paper (yeah I know, exactly on the deadline ;))
so now I have time again. This bug is one of the more important ones
on my TODO list.

Let me see if I can cook up a race-free way of fixing this one.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

