Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKRGEz>; Sat, 18 Nov 2000 01:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQKRGEp>; Sat, 18 Nov 2000 01:04:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20750 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129199AbQKRGEm>; Sat, 18 Nov 2000 01:04:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch] potential death in disassociate_ctty()
Date: 17 Nov 2000 21:34:24 -0800
Organization: Transmeta Corporation
Message-ID: <8v54d0$7dl$1@penguin.transmeta.com>
In-Reply-To: <3A15FF3F.9692D272@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A15FF3F.9692D272@uow.edu.au>,
Andrew Morton  <andrewm@uow.edu.au> wrote:
>
>Also, somewhere on the path from kernel 2.2 to 2.4 the call to
>do_notify_parent() was moved inside the tasklist lock.  Why was this?

Ehh.. Because that is also what protects our "parent" pointer.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
