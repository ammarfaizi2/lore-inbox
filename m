Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTI0CAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 22:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTI0CAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 22:00:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:35589 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262037AbTI0CAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 22:00:37 -0400
Subject: Ejecting a CardBus device
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064628015.1393.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Sep 2003 04:00:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

How can I tell the CardBus subsystem to eject my CardBus NIC by software
with 2.6.0 kernels? In 2.4 I could use "cardctl eject", but I don't know
how to do the same on 2.6.0-test5-mm4.

I need to eject my CardBus NIC if I want to be able to suspend the
machine using APM. Resuming from APM when the "yenta_socket" and
"pcmcia_core" modules are loaded causes a deadlock in the kernel during
resume, and the machine never comes back completely. Thus, before
suspending, I need to rmmod "pcmcia_core" and "yenta_socket" (well, and
uhci-hcd and the sound modules).

Currently, I need to manually eject the card by pushing the eject button
on the side of the laptop if I want to to rmmod "pcmcia_core" (not doing
so, causes pcmcia_core to complain that it's busy). So, I wonder if
there's a way to tell pcmcia_core to "eject" the CardBus NIC (without
physically ejecting the card from the socket) in order to being able to
rmmod it before trying to suspend.

Thanks!

   Felipe Alfaro Solana


