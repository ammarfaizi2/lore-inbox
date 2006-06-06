Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWFFLlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFFLlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFFLlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:41:16 -0400
Received: from server1.meinberg.de ([85.10.202.66]:33669 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S1751279AbWFFLlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:41:15 -0400
Message-ID: <448569CE.1020906@meinberg.de>
Date: Tue, 06 Jun 2006 13:41:02 +0200
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.2 (X11/20060601)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
References: <44854F74.50406@meinberg.de> <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
In-Reply-To: <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> in_atomic() is used to test if the kernel is in a state where sleeping
> is allowed or not. The 2.4.x kernel is not preemptive and has quite
> coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
> need in_atomic() in the same way as 2.6.x does.
OK, so I guess I can safely ommit this.

> schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
> which 2.4.x does not have.
Is there any similiar functionality in a 2.4 kernel environment? A
pointer to a 2.4 kernel driver using such a mechanism would be a good
starter...

> [snip]
> Wouldn't it make more sense to work on improving PPS (I assume you are
> refering to NTP "pulse per second" btw) support in 2.6.x rather than
> backporting an USB driver to 2.4.x ???
Yes, but unfortunately I have no chance to do this and therefore I rely
on others to do this. Well, the same applies to [me] and [kernel
drivers], but I hoped that it might be easier to try and backport one
driver instead of trying to improve other people's code (maybe that is
what OPC stands for :-)), especially when this code has a much larger
impact on several parts of the kernel.

> [snip]
> The book "Linux Device Drivers" third edition is available for free
> online and describes 2.6.x USB drivers in a fair bit of detail.
> Earlier editions of the book describe the 2.4.x kernel (don't know if
> those are available for free, but it should be possible to get them
> from a bookstore in any case).
> 
> Getting hold of the second & third editions of LDD and comparing the
> USB info from both should give you some idea of where to start...
OK, I will try to do so, but I am afraid that I will run out of time in
the meantime.

Thank you very much for your help and your fast response.

Kind regards,
Heiko




-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide

