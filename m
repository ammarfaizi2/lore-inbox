Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277144AbRJDG65>; Thu, 4 Oct 2001 02:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277145AbRJDG6r>; Thu, 4 Oct 2001 02:58:47 -0400
Received: from chiara.elte.hu ([157.181.150.200]:30729 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S277144AbRJDG6f>;
	Thu, 4 Oct 2001 02:58:35 -0400
Date: Thu, 4 Oct 2001 08:56:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, jamal <hadi@cyberus.ca>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.3.96.1011004015444.25623C-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110040854410.2166-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Oct 2001, Jeff Garzik wrote:

> On Wed, 3 Oct 2001, Ben Greear wrote:
> > That requires re-writing all the drivers, right?
>
> NAPI? [...]

Ben is talking about the long-planned "irq_action->handler() returns a
code that indicates progress" approach Linus talked about. *that* needs
the changing of every driver, since every IRQ handler prototype that is
'void' now needs to be changed to return 'int'. (the change is trivial,
but intrusive.)

	Ingo

