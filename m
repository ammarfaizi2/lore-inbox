Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSAUPl1>; Mon, 21 Jan 2002 10:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSAUPlR>; Mon, 21 Jan 2002 10:41:17 -0500
Received: from colorfullife.com ([216.156.138.34]:5394 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287149AbSAUPlM>;
	Mon, 21 Jan 2002 10:41:12 -0500
Message-ID: <3C4C3680.39DD06D8@colorfullife.com>
Date: Mon, 21 Jan 2002 16:40:48 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [sched] [patch] migration-fixes-2.5.3-pre2-A1
In-Reply-To: <Pine.LNX.4.33.0201202254440.14434-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> So i think the P6 documentation is a pessimisation of the true situation,
> and that we can very well have multiple interrupts on the same priority
> level even on older APICs - as long as the local timer interrupt is not
> amongst them.
>
You are right.
I tried to reproduce it (force cpu1 to priority 15, send 4 ipis to
priority 14 from cpu0, check that all arrive), and it seems that the
pIII doesn't drop ipi messages.

--
	Manfred
