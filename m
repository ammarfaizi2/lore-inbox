Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317771AbSGVSCk>; Mon, 22 Jul 2002 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317770AbSGVSCk>; Mon, 22 Jul 2002 14:02:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48007 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317771AbSGVSCi>;
	Mon, 22 Jul 2002 14:02:38 -0400
Date: Mon, 22 Jul 2002 20:04:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
In-Reply-To: <3D3C48D7.4B36F14E@mvista.com>
Message-ID: <Pine.LNX.4.44.0207222003310.19622-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, george anzinger wrote:

> But schedule and signal code does return with interrupts enabled, so a
> cli is still needed here.  Also at least some of the trap code returns
> with interrupts enabled.

the change only affects the ret_from_intr path, which is IRQ-only. The
signal and schedule path is still disabling interrupts.

	Ingo

