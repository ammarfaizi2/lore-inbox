Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291624AbSBHQDo>; Fri, 8 Feb 2002 11:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291626AbSBHQDg>; Fri, 8 Feb 2002 11:03:36 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:39358 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S291624AbSBHQDU>;
	Fri, 8 Feb 2002 11:03:20 -0500
Date: Fri, 8 Feb 2002 16:06:35 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
Message-ID: <Pine.LNX.4.33.0202081559240.1359-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

> Also it's the wrong approach. The right approach (as done by Manfred and
> David) is
> to put "current" no longer on this stack just a pointer to current.

Can you clarify this, please (because by default your statement sounds
like nonsense, sorry).

You are saying that the right approach is to move "current" off the stack.
The right approach to what? Surely not to saving kernel stack because
"current" (being merely a struct task_struct) is not a major eater of the
stack. Those functions which declare 5-6k of local variables are (if
there are still any left). Speaking of which, I will also answer Rik --
the offenders (that "VERY VERY sick code" Arjan refers to) we found were
in LKCD so it's been fixed ages ago.

So, moving struct task_struct is irrelevant, really. Unless you meant
something completely different and if so I look forward to your
clarifications.

Regards,
Tigran

