Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264676AbRFQBdK>; Sat, 16 Jun 2001 21:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbRFQBdA>; Sat, 16 Jun 2001 21:33:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22491 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264676AbRFQBcw>;
	Sat, 16 Jun 2001 21:32:52 -0400
Message-ID: <3B2C08C2.6CC5D144@mandrakesoft.com>
Date: Sat, 16 Jun 2001 21:32:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Pringlemeir <bpringle@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <m2d78352do.fsf@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Pringlemeir wrote:
> [main.c, line 175]
> 
>         for (count = 0; count < sizeof(card->digmix) / sizeof(card->digmix[0]); count++) {
> 
> Isn't there some sort of `ALEN' macro available, or is this
> considered to muddy things by using a macro?

Yes, we have array size

> [main.c, line 223]
>         if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL))
> 
> Why is the struct type referenced for the allocation size?  Why not,
> 
>         if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))

because then you would be allocating the size of a pointer, not the size
of a structure


> Why aren't all the gobs of constant data in this driver declared as
> constant?  Do it give a performance advantage by having the data in a
> different MMU section and better cache effects or something?

Marking data const is usually a good idea.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
