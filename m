Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTKZSe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTKZSe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:34:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:43987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264270AbTKZSez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:34:55 -0500
Date: Wed, 26 Nov 2003 10:34:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bruce Perens <bruce@perens.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal left blocked after signal handler.
In-Reply-To: <3FC4EF24.9040307@perens.com>
Message-ID: <Pine.LNX.4.58.0311261030300.1524@home.osdl.org>
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org>
 <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Nov 2003, Bruce Perens wrote:
>
> OK, I see. The signal remains blocked forever if we jump out of the
> handler. This is not the case on 2.4 . So, is this is semantic change?

It _shouldn't_ be a semantic change. Quite frankly, 2.4.x shouldn't work
the way you describe either.

I wonder if it's the "sigaction()" call in the handler that unblocks the
signal in 2.4.x.

		Linus
