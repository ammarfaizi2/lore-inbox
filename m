Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTLAQlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLAQlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:41:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48773 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263777AbTLAQlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:41:05 -0500
Date: Mon, 1 Dec 2003 11:43:15 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Juergen Oberhofer <j.oberhofer@gmx.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: wake_up_interruptible problem
Message-ID: <Pine.LNX.4.53.0312011138350.31222@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On -1 xxx -1, Juergen Oberhofer wrote:

> Hi,
> I'm trying to implement a timer, which on each timer interrupt wakes up
> every process that got blocked by a read call.
> My problem is the following: if I'm insmod'ing the module (I've attached the
> file) the execution gets
> blocked on the wake_up_interruptible(&timer_queue); call. If I'm
> uncommenting this line everything
> goes smooth and the timer counts without problems. Does somebody have a
> hint? Some ideas?
> Regards
> Juergen

Well you don't provide enough code to actually compile NotGood(tm).

I would guess that you failed to do:

        init_waitqueue_head(&timer_queue);

... in your initialization code, so wake_up_interruptible() is
waiting forever...... Look at the drivers provided in the
kernel source. All the initialization stuff is mandatory.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


