Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280932AbRKKFV0>; Sun, 11 Nov 2001 00:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280951AbRKKFVR>; Sun, 11 Nov 2001 00:21:17 -0500
Received: from mail.terry.uga.edu ([128.192.28.146]:520 "EHLO
	ember.terry.uga.edu") by vger.kernel.org with ESMTP
	id <S280932AbRKKFVA>; Sun, 11 Nov 2001 00:21:00 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org (Linux kernel)
Subject: Re: test SYN cookies (was Re: SYN cookies security bugfix?)
In-Reply-To: <E162giG-0007cI-00@the-village.bc.nu>
From: Ed L Cashin <ecashin@terry.uga.edu>
Date: 11 Nov 2001 00:17:30 -0500
Message-ID: <m3ofm9evit.fsf@terry.uga.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you much for the reply.

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Is there anyone who has any evidence that SYN cookies do anything in
> > kernel 2.2.x?  If so, how did you get that evidence, because I would
> > like to reproduce it.
> 
> They work fine for me in 2.2.19/2.2.20. 

That was reassuring enough that I persisted and found that the problem
was this: my home-spun SYN-flooder wasn't changing the TCP sequence
number, and so the "victim" was discarding the packets.  

The three-second pause I observed previously was a red herring that
went away when I started using separate hosts for flooding and
connection-testing. 

Now I see a night-and-day difference between with and without SYN
cookies (although when tcp_max_syn_backlog is set to more than a five
it takes a long time to fill the queue).

Thanks again.

-- 
--Ed Cashin                   PGP public key:
  ecashin@terry.uga.edu       http://www.terry.uga.edu/~ecashin/pgp/

