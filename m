Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288983AbSAFQRP>; Sun, 6 Jan 2002 11:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288984AbSAFQRG>; Sun, 6 Jan 2002 11:17:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8087 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288983AbSAFQQx>;
	Sun, 6 Jan 2002 11:16:53 -0500
Date: Sun, 6 Jan 2002 19:14:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: O(1) scheduler, 2.5.2-pre9-B1 results
In-Reply-To: <20020106124927.GA30292@krispykreme>
Message-ID: <Pine.LNX.4.33.0201061643560.4651-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Anton Blanchard wrote:

> communication latencies: Pipe, AF, TCP slightly up (BAD)

this is mainly because i have not made the O(1) scheduler fully aware of
synchronous wakeups yet. I'm working on this part now that the bugs are
fixed. If you remove synchronous wakeups from the stock kernel then you'll
see processes distributed to different CPUs but bad lmbench latencies.

> So far things look good. Next up I'll look at how it scales on the 12
> way.

thanks!

	Ingo


