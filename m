Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSIAW2e>; Sun, 1 Sep 2002 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSIAW2e>; Sun, 1 Sep 2002 18:28:34 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:11994 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318145AbSIAW2d> convert rfc822-to-8bit; Sun, 1 Sep 2002 18:28:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: question on spinlocks
Date: Mon, 2 Sep 2002 00:33:23 +0200
User-Agent: KMail/1.4.1
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209020033.23113.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. September 2002 00:09 schrieb Thunder from the hill:
> Hi,
>
> On Mon, 2 Sep 2002, Oliver Neukum wrote:
> > > > No; spin_lock_irqsave/spin_unlock_irqrestore and
> > > > spin_lock/spin_unlock have to be used in matching pairs.
> > >
> > > If it was his least problem! He'll run straight into a "schedule
> > > w/IRQs disabled" bug.
> >
> > OK, how do I drop an irqsave spinlock if I don't have flags?
>
> IMHO you might even ask "How do I start a car when I don't have the
> keys?"

Break off the lock, touch some cables ... ;-)

> You might find a way, but it's not desired. Are you sure you want to
> reschedule in an interrupt handler? If it's none, are you sure you want
> to disable interrupts?

I am not in an interrupt handler. It's not my fault that the scsi layer
calls queuecommand with a spinlock held. But I need to sleep,
I have to get rid of that spinlock's effects. If possible I even want
interrupts to be enabled.

	Regards
		Oliver

