Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUAYSkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbUAYSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:40:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:44216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265152AbUAYSkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:40:46 -0500
Date: Sun, 25 Jan 2004 10:40:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David =?iso-8859-2?q?Posp=ED=B9il?= <foton2@post.cz>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Unable to handle kernel paging request
In-Reply-To: <200401250601.48095.foton2@post.cz>
Message-ID: <Pine.LNX.4.58.0401251038020.18932@home.osdl.org>
References: <200401250424.21533.foton2@post.cz> <20040124203400.6dde63d0.akpm@osdl.org>
 <200401250601.48095.foton2@post.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jan 2004, David [iso-8859-2] Pospí?il wrote:
>
> > >  Jan 25 03:51:02 foton2 kernel: EIP:    0060:[<c013bb35>]    Tainted: P

What is tainting your kernel?

If it's nVidia, the most likely reason is a double free by the binary-only 
nVidia driver, which just hits us when we free something unrelated.

> I had the same problem (if it is problem :-) also with 2.4

Is it in the same place? Which 2.4.x? The task free code has changed a bit
with the threading stuff, and the latest RH 2.4.x kernels with the new
threading code are more similar to 2.6.1 than older 2.4.x kernels are.

		Linus
