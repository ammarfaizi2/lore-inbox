Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278241AbRJMCFB>; Fri, 12 Oct 2001 22:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278242AbRJMCEl>; Fri, 12 Oct 2001 22:04:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278241AbRJMCEj>; Fri, 12 Oct 2001 22:04:39 -0400
Date: Fri, 12 Oct 2001 19:04:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.40.0110121834150.1505-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0110121903031.8148-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Oct 2001, Davide Libenzi wrote:
>
> The problem is that even if cpu1 schedule the load of  p  before the
> load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
> even if from cpu2 the invalidation stream exit in order, cpu1 could see
> the value of  p  before the value of  *p  due a reordering done by the
> cache controller delivering the stream to cpu1.

Umm - if that happens, your cache controller isn't honouring the wmb(),
and you have problems quite regardless of any load ordering on _any_ CPU.

Ehh?

		Linus

