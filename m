Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSLQRjQ>; Tue, 17 Dec 2002 12:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSLQRjQ>; Tue, 17 Dec 2002 12:39:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265063AbSLQRjP>; Tue, 17 Dec 2002 12:39:15 -0500
Date: Tue, 17 Dec 2002 09:47:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.3.95.1021217112402.25749A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0212170946240.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, 17 Dec 2002, Richard B. Johnson wrote:
> On Mon, 16 Dec 2002, Linus Torvalds wrote:
> >
> > instruction for a system call just do a
> >
> > 	call 0xfffff000
>
> So you are going to do a system-call off a trap instead of an interrupt.

No no. The kernel maps a magic read-only page at 0xfffff000, and there's
no trap involved. The code at that address is kernel-generated for the CPU
in question, and it will do whatever is most convenient.

No traps. They're slow as hell.

		Linus

