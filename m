Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTEJQ4w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEJQ4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:56:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264442AbTEJQ4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:56:51 -0400
Message-ID: <33096.4.64.196.31.1052586571.squirrel@www.osdl.org>
Date: Sat, 10 May 2003 10:09:31 -0700 (PDT)
Subject: Re: [PATCH] Use correct x86 reboot vector
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <jamie@shareable.org>
In-Reply-To: <20030510161529.GB29271@mail.jlokier.co.uk>
References: <20030510025634.GA31713@averell>
        <20030510161529.GB29271@mail.jlokier.co.uk>
X-Priority: 3
Importance: Normal
Cc: <ak@muc.de>, <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi Kleen wrote:
>> Extensive discussion by various experts on the discuss@x86-64.org mailing
>> list concluded that the correct vector to restart an 286+  CPU is
>> f000:fff0, not ffff:0000. Both seem to work on current systems,  but the
>> first is correct.
>
> You are right.  That's what a 286 does when the RESET signal is asserted.
>
> Which is amazing, because I wrote that ffff:0000 and I was reading from the
> Phoenix BIOS book at the time.  It was long ago but I'm
> fairly sure I got that address from the book.
>
> I just did some Googling and found that there examples of DOS code fragments
> using both vectors.  Also, the original IBM BIOS (as they say) had a long
> jump at the vector, which is presumably one of the many de facto ABIs which
> real mode programmers grew to depend on.

This seems to be a difference from 8086/8088 to the 286.
My iAPX 286 Hardware Reference Manual says that the RESET signal initializes
CS to 0FF0000H and IP to 0FFF0H, while my iAPX 86,88 User's Manual says
that RESET sets CS to 0FFFFh and IP to 0.

~Randy



