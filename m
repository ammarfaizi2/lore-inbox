Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278262AbRJMDag>; Fri, 12 Oct 2001 23:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278261AbRJMDaZ>; Fri, 12 Oct 2001 23:30:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23311 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278262AbRJMDaK>; Fri, 12 Oct 2001 23:30:10 -0400
Date: Fri, 12 Oct 2001 20:30:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.40.0110121921240.1505-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0110122027370.8217-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Oct 2001, Davide Libenzi wrote:
>
> Suppose that  p  and  *p  are on two different cache partitions and the
> invalidation order that comes from the wmb() cpu is 1) *p  2) p
> Suppose that the partition when  *p  lies is damn busy and the one where
> p  lies is free.
> The reader cpu could pickup the value of  p  before the value of  *p  by
> reading the old value of  a

Ahh.. I misunderstood. You are arguing for the rmb() even if the CPU
doesn't speculate addresses for loads. Yes, I agree.

		Linus

