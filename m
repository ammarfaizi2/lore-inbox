Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDPOTs>; Mon, 16 Apr 2001 10:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDPOTi>; Mon, 16 Apr 2001 10:19:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43794 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S131498AbRDPOTb>;
	Mon, 16 Apr 2001 10:19:31 -0400
Date: Mon, 16 Apr 2001 11:18:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Pavel Machek <pavel@suse.cz>
Cc: george anzinger <george@mvista.com>, SodaPop <soda@xirr.com>,
        alexey@datafoundation.com, linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
In-Reply-To: <20010412235144.A43@(none)>
Message-ID: <Pine.LNX.4.21.0104161118180.14442-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Pavel Machek wrote:

> > One rule of optimization is to move any code you can outside the loop. 
> > Why isn't the nice_to_ticks calculation done when nice is changed
> > instead of EVERY recalc.?  I guess another way to ask this is, who needs
> 
> This way change is localized very nicely, and it is "obviously right".

Except for two obvious things:

1. we need to load the nice level anyway
2. a shift takes less cycles than a load on most
   CPUs

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

