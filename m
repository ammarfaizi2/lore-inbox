Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbRENSlY>; Mon, 14 May 2001 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbRENSlO>; Mon, 14 May 2001 14:41:14 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:4872 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262372AbRENSlB>;
	Mon, 14 May 2001 14:41:01 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105141840.WAA16086@ms2.inr.ac.ru>
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 14 May 2001 22:40:15 +0400 (MSK DST)
Cc: andrewm@uow.edu.au, davem@redhat.COM, linux-kernel@vger.kernel.org
In-Reply-To: <3B002001.AEEEE415@mandrakesoft.com> from "Jeff Garzik" at May 14, 1 02:12:17 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Note that using dev->name during probe was always incorrect.  Think
> about the error case:
...
> So, using interface name in this manner was always buggy because it
> conveys no useful information to the user.

I used to think about cases of success. 8)
In any case the question follows: do we have some another generic
unique human-readable identifier? Only if device is PCI?


Actually, I am puzzled mostly with Andrew's note about "simplicity".
Andrew's patch was evidently much __simpler__ than yours, at least,
it required one liner for each device and surely was not a "2.5 material".



> I'm all for removing it...  I do not like removing it in a so-called
> "stable" series, though.  alloc_etherdev() was enough to solve the race
> and flush out buggy drivers using dev->name during probe.  Notice I did
> not remove init_etherdev and fix it properly -- IMHO that is 2.5
> material.

Nope, guy. Fixing fatal bug is always material of released kernel.

In any case the question remains: what is the sense of dev_probe_lock now?

Alexey
