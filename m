Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289766AbSAJXAA>; Thu, 10 Jan 2002 18:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289767AbSAJW7u>; Thu, 10 Jan 2002 17:59:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34831 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289766AbSAJW7i>; Thu, 10 Jan 2002 17:59:38 -0500
Date: Thu, 10 Jan 2002 15:04:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201110142160.12174-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201101501550.1493-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Ingo Molnar wrote:

> indeed. The question is, should we migrate processes around just to get
> 100% fairness in 'top' output? The (implicit) cost of a task migration
> (caused by the destruction & rebuilding of cache state) can be 10
> milliseconds easily on a system with big caches.

10 ms is exactly what i've observed while i was coding the BMQS balance
code. Leaving a cpu idle for more than 10ms will make real tests like
kernel builds to suffer performance degradation. By using 10ms i always
got the same time of the standard scheduler.




- Davide


