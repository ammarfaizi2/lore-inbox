Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290527AbSBKVs0>; Mon, 11 Feb 2002 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSBKVsQ>; Mon, 11 Feb 2002 16:48:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39428 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290508AbSBKVsJ>; Mon, 11 Feb 2002 16:48:09 -0500
Subject: Re: what serial driver restructure is planned?
To: ncw@axis.demon.co.uk (Nick Craig-Wood)
Date: Mon, 11 Feb 2002 22:01:15 +0000 (GMT)
Cc: linux@arm.linux.org.uk (Russell King - ARM Linux),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020211163059.A22996@axis.demon.co.uk> from "Nick Craig-Wood" at Feb 11, 2002 04:30:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aOVf-00084P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we also have an interface to serial devices which bypass the tty
> layer?  Ie a /dev/ttyraw* which just speaks to the serial port without
> going through the labyrinthine tty layers?

You've got one

> 9 times out of 10 when I reach for /dev/ttyS* that is all I want and
> the tty layer is just wasteful and gets in the way of a conceptually
> very simple device.

The only bits of the tty layer being used in raw data passing is the same
buffer management logic you would need anyway. In short - the perceived
waste is simply not there
