Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSEYSYO>; Sat, 25 May 2002 14:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSEYSYN>; Sat, 25 May 2002 14:24:13 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:43282 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S315227AbSEYSYM>; Sat, 25 May 2002 14:24:12 -0400
Message-ID: <3CEFD65A.ED871095@opersys.com>
Date: Sat, 25 May 2002 14:22:18 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
>  - I think the microkernel approach is fundamentally broken. Karim claims
>    there is no priority inversion, but he must have his blinders on. Every
>    single spinlock in the kernel assumes that the kernel isn't preempted,
>    which means that user apps that can preempt the kernel cannot use them.

Blinders ehh... Well, if you would care to ask I would answer.

In reality, what you point out is actually a non-issue since the hard-rt
user-land tasks are not allowed to call on normal Linux services. They
can only call on RTAI services which are exported by an extra soft-int.
These services are hard-rt, so there's no problem there.

Please, download the thing and play with it. Or, at the very least, ask
about how it works and we'll be glad to explain.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
