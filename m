Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276525AbRJCQyG>; Wed, 3 Oct 2001 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJCQx4>; Wed, 3 Oct 2001 12:53:56 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:3091 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276525AbRJCQxk>;
	Wed, 3 Oct 2001 12:53:40 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110031653.UAA13938@ms2.inr.ac.ru>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: mingo@elte.hu
Date: Wed, 3 Oct 2001 20:53:58 +0400 (MSK DST)
Cc: hadi@cyberus.ca, linux-kernel@vger.kernel.org, Robert.Olsson@data.slu.se,
        bcrl@redhat.com, netdev@oss.sgi.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.33.0110031702280.7221-100000@localhost.localdomain> from "Ingo Molnar" at Oct 3, 1 05:28:08 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In a generic computing environment i want to spend cycles doing useful
> work, not polling.

Ingo, "polling" is wrong name. It does not poll. :-)
Actually, this misnomer is the worst thing whic I worried about.

Citing my old explanation:

>"Polling" is not a real polling in fact, it just accepts irqs as
>events waking rx softirq with blocking subsequent irqs.
>Actual receive happens at softirq.
>
>Seems, this approach solves the worst half of livelock problem completely:
>irqs are throttled and tuned to load automatically.
>Well, and drivers become cleaner.

Alexey
