Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbRAPMiC>; Tue, 16 Jan 2001 07:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131403AbRAPMhw>; Tue, 16 Jan 2001 07:37:52 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20753 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131401AbRAPMhi>;
	Tue, 16 Jan 2001 07:37:38 -0500
Date: Tue, 16 Jan 2001 13:37:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Felix von Leitner <leitner@convergence.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010116114018.A28720@convergence.de>
Message-ID: <Pine.LNX.4.30.0101161334380.947-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Felix von Leitner wrote:

> I don't know how Linux does it, but returning the first free file
> descriptor can be implemented as O(1) operation.

only if special allocation patters are assumed. Otherwise it cannot be a
generic O(1) solution. The first-free rule adds an implicit ordering to
the file descriptor space, and this order cannot be maintained in an O(1)
way. Linux can allocate up to a million file descriptors.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
