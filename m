Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274140AbRISTVY>; Wed, 19 Sep 2001 15:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274142AbRISTVO>; Wed, 19 Sep 2001 15:21:14 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:30685 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274140AbRISTVE>; Wed, 19 Sep 2001 15:21:04 -0400
Date: Wed, 19 Sep 2001 15:21:21 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010919152121.A9952@devserv.devel.redhat.com>
In-Reply-To: <3EDB9E14576@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EDB9E14576@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Sep 19, 2001 at 09:15:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 09:15:17PM +0000, Petr Vandrovec wrote:
> On 19 Sep 01 at 19:55, Arjan van de Ven wrote:
> > 
> > Ok but that part is simple:
> > 
> > run
> > 
> > http://www.fenrus.demon.nl/athlon.c
> 
> Small question - is it OK that 'faster_copy' is faster than
> 'even_faster'? 

Yeah; both are "new style" with a minor variation, "even_faster" is
basically my test victim, and faster_ is the "last known good" one.

> clear_page function '2.4 MMX version'    took 8508 cycles per page
> clear_page function 'faster_clear_page'  took 4016 cycles per page
> clear_page function 'even_faster_clear'  took 3916 cycles per page

Yup, > 2x improvement, that's expected

> 
> copy_page() tests 
> copy_page function '2.4 MMX version'     took 15163 cycles per page
> copy_page function 'faster_copy'     took 8569 cycles per page
> copy_page function 'even_faster'     took 8805 cycles per page

same here

If it were only 5%, I would vote for disabling the optimisation given the
number of problems; however it's 2x _and_ you can trigger the bug as normal 
user from userspace too... so we need to fix the hardware/bios.

Greetings,
   Arjan van de Ven
