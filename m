Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276680AbRJBUxx>; Tue, 2 Oct 2001 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276677AbRJBUxm>; Tue, 2 Oct 2001 16:53:42 -0400
Received: from chiara.elte.hu ([157.181.150.200]:22022 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276679AbRJBUxd>;
	Tue, 2 Oct 2001 16:53:33 -0400
Date: Tue, 2 Oct 2001 22:51:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15oQYt-0004r1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110022246300.2543-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Oct 2001, Alan Cox wrote:

> What you really care about is limiting the total amount of CPU time
> used for interrupt processing so that usermode progress is made.
> [...]

exactly. The estimator in -D9 tries to achieve precisely this, both
hardirqs and softirqs are measured.

> Silencing a specific target cannot be done by IRQ masking, you have to
> ask the controller to shut up. It may be the default "shut up" handler
> is disable_irq but that is non optimal.

this could be done later on, but i think this is out of question for 2.4,
as it needs extensive changes in irq handler and network driver API.

	Ingo

