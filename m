Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbREOJDv>; Tue, 15 May 2001 05:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbREOJDl>; Tue, 15 May 2001 05:03:41 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:15886 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262685AbREOJDd>;
	Tue, 15 May 2001 05:03:33 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105150902.NAA29079@ms2.inr.ac.ru>
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
To: andrewm@uow.edu.au (Andrew Morton)
Date: Tue, 15 May 2001 13:02:55 +0400 (MSK DST)
Cc: jgarzik@mandrakesoft.com, davem@redhat.COM, linux-kernel@vger.kernel.org
In-Reply-To: <3B006F84.C1427EB3@uow.edu.au> from "Andrew Morton" at May 15, 1 09:51:32 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It protects the as-yet-unchanged PCI and Cardbus drivers from a
> fatal race.

Fatal race remained.

Andrew, you start again the story about white bull. 8)
We have already discussed this. Device cannot stay in device list
uninitialzied. Period.

I am sorry, but no compromise is possible. With Jeff's approach all
the references to init_etherdev and dev_probe_lock must be eliminated
in 2.4.


> and sys_ioctl() both do lock_kernel().  If xxx_probe() drops the BKL,

Again, BKL has nothing to do with this (and ioctl does not hold it)
It looks like you forgot all the discussion around your own patch. 8)

If you want I can retransmit the mails which resulted in your patch?

Alexey
