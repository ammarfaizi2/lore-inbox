Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRFQPy3>; Sun, 17 Jun 2001 11:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbRFQPyT>; Sun, 17 Jun 2001 11:54:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5598 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S261347AbRFQPyJ>;
	Sun, 17 Jun 2001 11:54:09 -0400
Message-ID: <3B2CD29E.948D6BF2@mandrakesoft.com>
Date: Sun, 17 Jun 2001 11:54:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Flynn <Dave@keston.u-net.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk> <0106171701100P.00879@starship> <3B2CC7DC.EEAF3253@mandrakesoft.com> <00c301c0f743$9da4d9f0$1901a8c0@node0.idium.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Flynn wrote:
> 
> > Daniel Phillips wrote:
> > > Yep, the only thing left to resolve is whether Jeff had coffee or not.
> ;-)
> > >
> > > -       if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout),
> GFP_KERNEL))
> > > +       if ((card->mpuout = kmalloc(sizeof(*card->mpuout), GFP_KERNEL))
> >
> > Yeah, this is fine.  The original posted omitted the '*' which was not
> > fine :)
> 
> The only other thing left to ask, is which is easier to read when glancing
> through the code, and which is easier to read when maintaining the code.
> imho, ist the former for reading the code, i dont know about maintaing the
> code since i dont do that, however in my own projects i prefere the former
> when maintaing the code.

It's the preference of the maintainer.  It's a tossup:  using the type
in the kmalloc makes the type being allocated obvious.  But using
sizeof(*var) is a tiny bit more resistant to change.

Neither one sufficiently affects long term maintenance AFAICS, so it's
personal preference, not any sort of kernel standard one way or the
other...

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
