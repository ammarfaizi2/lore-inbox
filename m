Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHFMVF>; Mon, 6 Aug 2001 08:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268137AbRHFMUz>; Mon, 6 Aug 2001 08:20:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268100AbRHFMUk>; Mon, 6 Aug 2001 08:20:40 -0400
Subject: Re: rio_init, tty_io call confusion.  2.4.8-pre4
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 6 Aug 2001 13:21:41 +0100 (BST)
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
In-Reply-To: <32756.997071720@ocs3.ocs-net> from "Keith Owens" at Aug 06, 2001 02:22:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TjO9-0000rK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/tty_io calls rio_init and gets a link error when rio is
> linked into the kenrel because rio_init is declared as static.  However
> rio_init is also declared as module_init() so it gets called twice, one
> from tty_io and once from the kernel initcall code.  One of those calls
> has to go.  If you keep the tty_io call then rio_init cannot be static.

The tty_io call appears to be stale

