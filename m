Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTKZSVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTKZSVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:21:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:60620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbTKZSVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:21:14 -0500
Date: Wed, 26 Nov 2003 10:21:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bruce Perens <bruce@perens.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal left blocked after signal handler.
In-Reply-To: <3FC4ED5F.4090901@perens.com>
Message-ID: <Pine.LNX.4.58.0311261018420.1524@home.osdl.org>
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org>
 <3FC4ED5F.4090901@perens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Nov 2003, Bruce Perens wrote:
>
> Sigsetjmp will save and restore the signal mask ONLY if its second
> argument is nonzero. The libc code is correct.

Oh, I didn't notice that part.

> The test program works properly under 2.4 .

What do you mean "properly"? If you're not saving/restoring the sigmasks,
then the 2.6.x behaviour is the right one and your program is buggy.

What's your point?

		Linus
