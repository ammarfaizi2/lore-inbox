Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136657AbREGURH>; Mon, 7 May 2001 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136658AbREGUQ5>; Mon, 7 May 2001 16:16:57 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54287 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136657AbREGUQy>; Mon, 7 May 2001 16:16:54 -0400
Date: Mon, 7 May 2001 13:16:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <3AF6FD69.5654B88B@didntduck.org>
Message-ID: <Pine.LNX.4.31.0105071315580.22171-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Brian Gerst wrote:
>
> This patch will still cause the user process to seg fault: The error
> code on the stack will not match the address in %cr2.

You've convinced me. Good thinking. Let's do the irq thing.

		Linus

