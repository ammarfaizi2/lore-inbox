Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbRENTnw>; Mon, 14 May 2001 15:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262431AbRENTnm>; Mon, 14 May 2001 15:43:42 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:39176 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262425AbRENTnd>;
	Mon, 14 May 2001 15:43:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105141942.XAA16515@ms2.inr.ac.ru>
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 14 May 2001 23:42:46 +0400 (MSK DST)
Cc: andrewm@uow.edu.au, davem@redhat.COM, linux-kernel@vger.kernel.org
In-Reply-To: <3B0031A0.25C332D2@mandrakesoft.com> from "Jeff Garzik" at May 14, 1 03:27:28 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Each bus should 

Not all the device are bound to some "bus".



> Are you talking about his 140k patch?

Yes!

Size of patch and "simplicity" are orthogonal things.
It was simple like potatoe.


> I think a key point of my patch is that drivers now follow the method of
> other kernel drivers: perform all setup necessary, and then register the
> device in a single operation.

Nice. I agreed. I talk about other thing: after applying Andrew's patch
I saw good correct code. After you will fix all the devices, your patch will
be the same 140K or more due to killing refs t dev->name announced
to be illegal. 8)


>				 After register_foo(dev), all members of
> 'dev' are assumed to be filled in and ready for use.  This is not the
> case ....................... using dev->init()...

Sorry? Why?


> Tangent - IMHO having register_netdev call dev->init is ugly and unusual
> compared to other driver APIs in the kernel.  Your register function
> should not call out to driver functions, it should just register a new,
> already-set-up device in the subsystem and return.

Provided you teach me some way to generate unique identifiers, different
of device names.


> So you say a fatal bug remains in 2.4.5-pre1?  If so please elaborate...


Probably, I am looking into different code, but I found only 15 references
to new interface.

Alexey
