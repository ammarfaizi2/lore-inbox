Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbRFQKpn>; Sun, 17 Jun 2001 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbRFQKpd>; Sun, 17 Jun 2001 06:45:33 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39940 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264715AbRFQKpR>; Sun, 17 Jun 2001 06:45:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Bill Pringlemeir <bpringle@sympatico.ca>
Subject: Re: Newbie idiotic questions.
Date: Sun, 17 Jun 2001 12:48:01 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2d78352do.fsf@sympatico.ca> <3B2C08C2.6CC5D144@mandrakesoft.com>
In-Reply-To: <3B2C08C2.6CC5D144@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <0106171248010N.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 June 2001 03:32, Jeff Garzik wrote:
> Bill Pringlemeir wrote:
> > Why is the struct type referenced for the allocation size?  Why not,
> >
> >         if ((card->mpuout = kmalloc(sizeof(card->mpuout), GFP_KERNEL))
>
> because then you would be allocating the size of a pointer, not the size
> of a structure

Whoops Jeff, you didn't have your coffee yet:

	struct foo { int a; int b; };
	struct { struct foo foo; } *foobar;

	int main (void)
	{
		printf("%i\n", sizeof(struct foo));
		printf("%i\n", sizeof(foobar->foo));
		printf("%i\n", sizeof(&foobar->foo));
	}

Prints:

	8
	8
	4
--
Daniel
