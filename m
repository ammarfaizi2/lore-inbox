Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbTERS5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTERS5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 14:57:07 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:11018 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id S262162AbTERS5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 14:57:06 -0400
Date: Sun, 18 May 2003 21:09:54 +0200
Message-Id: <200305181909.h4IJ9sK02186@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: recursive spinlocks. Shoot.
X-Newsgroups: linux.kernel
In-Reply-To: <20030518182010$0541@gated-at.bofh.it>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030518182010$0541@gated-at.bofh.it> you wrote:
> On Sun, 18 May 2003, Peter T. Breuer wrote:
>> Here's a before-breakfast implementation of a recursive spinlock. That

> A looong time ago I gave to someone a recursive spinlock implementation
> that they integrated in the USB code. I don't see it in the latest
> kernels, so I have to guess that they found a better solution to do their
> things. I'm biased to say that it must not be necessary to have the thing
> if you structure your code correctly.

Well, you can get rid of anything that way. The question is if the
interface is an appropriate one to use or not - i.e. if it makes for
better code in general, or if it make errors of programming less
likely.

I would argue that the latter is undoubtedly true - merely that
userspace flock/fcntl works that way would argue for it, but there
are a couple of other reasons too. 

Going against is the point that it may be slower.  Can you dig out your
implementation and show me it?  I wasn't going for assembler in my hasty
example.  I just wanted to establish that it's easy, so that it becomes
known that its easy, and folks therefore aren't afraid of it.  That both
you and I have had to write it implies that it's not obvious code to
everyone.


Peter
