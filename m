Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270549AbRHISyD>; Thu, 9 Aug 2001 14:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270552AbRHISxx>; Thu, 9 Aug 2001 14:53:53 -0400
Received: from [200.10.161.32] ([200.10.161.32]:54499 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S270549AbRHISxk>;
	Thu, 9 Aug 2001 14:53:40 -0400
Message-ID: <3B72DC28.D0ED99B2@inti.gov.ar>
Date: Thu, 09 Aug 2001 15:53:28 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [RFC] Get selection to buffer addition
In-Reply-To: <3B66A90D.789A90A8@inti.gov.ar> <3B66DDEB.1EA1FEC@inti.gov.ar> <20000101012446.B27@(none)> <20010808222106.C22093@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> On Sat, Jan 01, 2000 at 01:24:46AM +0000, Pavel Machek wrote:

[snip]

> > > What I'm looking for:
> > >   I'm looking for comments and approval for a small addition to the console
> > > driver (drivers/char/console.c).

[snip]

> > Looks good to me. Now, all I want is utility to share clipboard between
> > X and text console...
>
> Umm, silly question, but why not put this stuff into something similar to
> gpm, rather than have unswappable kernel memory sucked up just for cut and
> paste (possibly very large cut and paste under X).

According to James Simmons (he is maintaining a console development CVS tree in
Sourge Force) the selection stuff will go away in 2.5.x series and the code will
be moved to user space (gpm) as Russell sugest.
As things will be changing in 2.5.x I don't think we should introduce my change.
My idea was towards what Pavel says: adding some kind of clipboard facility, after
all it was already there but not accesible. I sent this patch first and already
designed the IOCTL calls for the reverse: set the selection buffer.
When I started it I thinked this was part of gpm. I was very surprised when I
discovered the kernel was doing the real job.
As the 2.5.x code will remove it I don't know if we should add features that will
go away. The only problem for me is how many time I'll must wait before 2.6.x is
released and the users of my text editor will enjoy this facility (a clipboard
between consoles and different applications).

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set-soft@bigfoot.com set@computer.org
                    set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



