Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSBIRrs>; Sat, 9 Feb 2002 12:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBIRrj>; Sat, 9 Feb 2002 12:47:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289051AbSBIRr1>; Sat, 9 Feb 2002 12:47:27 -0500
Date: Sat, 9 Feb 2002 11:32:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Ingo Molnar <mingo@elte.hu>,
        Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
        Martin Wirth <Martin.Wirth@dlr.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        haveblue <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <20020208214012.26611@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0202091131320.8508-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Benjamin Herrenschmidt wrote:
>
> At least PPC32 can't do that without a spinlock_irq

We don't need to be irq-safe for this, though. Just specify it to be
process safe - which means that on UP it boils down to at most maybe
having to protect against preemption.

		Linus

