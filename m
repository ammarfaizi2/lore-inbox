Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbREZEsT>; Sat, 26 May 2001 00:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbREZEsK>; Sat, 26 May 2001 00:48:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29714 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262600AbREZEsB>;
	Sat, 26 May 2001 00:48:01 -0400
Date: Sat, 26 May 2001 01:47:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260137140.30264-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105260146280.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Rik van Riel wrote:

> 1) normal user allocation
> 2) buffer allocation (bounce buffer + bufferhead)
> 3) allocation from interrupt (for device driver)

Hmmmm, now that I think of it, we always need to be able
to guarantee _both_ 2) and 3).  For different allocators
and interrupts.  I guess the only long-term solution is
to have real memory reservation strategies, like the one
in Ben's patch.

That might be a 2.5 thing, though ... Ben?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

