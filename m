Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282495AbRLAX1J>; Sat, 1 Dec 2001 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282487AbRLAX1A>; Sat, 1 Dec 2001 18:27:00 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:43020 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282495AbRLAX0q>; Sat, 1 Dec 2001 18:26:46 -0500
Date: Sat, 1 Dec 2001 15:37:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Shuji YAMAMURA <yamamura@flab.fujitsu.co.jp>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <E16A6lc-0006cV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112011350120.1696-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Alan Cox wrote:

> > The point is why store kernel pointers in global registers when You can
> > achieve the same functionality, with a smaller patch, that does not need
> > to be recoded for each CPU, without using global registers.
>
> Because it is much much much faster

We'll see how much faster is the global register allocation against code
like :

movl %esp, %eax
andl $-8192, %eax
movl (%eax), %eax

Because you can justify a global register allocation only if this "much
much faster" translates to a number that has sense.




- Davide




