Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSBHQ5A>; Fri, 8 Feb 2002 11:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291649AbSBHQ4u>; Fri, 8 Feb 2002 11:56:50 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:11315 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S291637AbSBHQ4h>;
	Fri, 8 Feb 2002 11:56:37 -0500
Date: Fri, 8 Feb 2002 16:59:47 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <20020208110930.C1429@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0202081645170.1359-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Arjan van de Ven wrote:
> If you need even more in your code (I assume you do otherwise you wouldn't
> have done the work) then I really suggest you take a long hard look and fix
> the obvious bugs or the design....

Arjan, I completely agree with you, but please do not overlook one obvious
thing -- sometimes (well, most of the time) in order to fix those stack
corruption issues you _first_ need to apply this patch and then it becomes
obvious that the reason for this "random" corruption is the stack
overflow. A kernel panic is not shouting like "I am a stack overflow!"
(yes, I know of Andrea's IKD of course, but sometimes it is preferrable to
apply a small non-intrusive patch instead)

So, I found this patch useful at least for debugging. Moreover, I think it
would be very useful to have it in Linus' kernel as a CONFIG_ option so
that if people complain about random memory corruption then they can try
to reproduce it with larger stack and then (with aid of /proc/stack) the
offender is found and fixed. I cc'd Alan; if he thinks this is a bad idea
I would be interested to know why.

Regards,
Tigran




