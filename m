Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261257AbRELOoK>; Sat, 12 May 2001 10:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbRELOoA>; Sat, 12 May 2001 10:44:00 -0400
Received: from colorfullife.com ([216.156.138.34]:5645 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S261257AbRELOnr>;
	Sat, 12 May 2001 10:43:47 -0400
Message-ID: <3AFD4C2D.18095CC2@colorfullife.com>
Date: Sat, 12 May 2001 16:43:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] winbond-840 update
In-Reply-To: <3AFD0A27.49C11072@colorfullife.com> <3AFD49CC.655E3E4F@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Manfred Spraul wrote:
> > @@ -437,9 +439,9 @@
> >         if (option > 0) {
> >                 if (option & 0x200)
> >                         np->full_duplex = 1;
> > -               np->default_port = option & 15;
> > -               if (np->default_port)
> > -                       np->medialock = 1;
> > +               if (option & 15)
> > +                       printk(KERN_INFO "%s: ignoring user supplied media type %d",
> > +                               dev->name, option & 15);
> >         }
> >         if (find_cnt < MAX_UNITS  &&  full_duplex[find_cnt] > 0)
> >                 np->full_duplex = 1;
> 
> I'm not sure this part is something we want in the mainstream kernel...
>

The winbond driver always ignored the user supplied media type, I only
added a warning.
medialock and default_port were write-only variables ;-)

--	
	Manfred
