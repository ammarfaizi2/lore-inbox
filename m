Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271743AbRHQW13>; Fri, 17 Aug 2001 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRHQW1H>; Fri, 17 Aug 2001 18:27:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271736AbRHQW07>; Fri, 17 Aug 2001 18:26:59 -0400
Subject: Re: 'make dep' produces lots of errors with this .config
To: alex.buell@tahallah.demon.co.uk
Date: Fri, 17 Aug 2001 23:24:35 +0100 (BST)
Cc: andre.dahlqvist@telia.com (=?iso-8859-1?Q?Andr=E9?= Dahlqvist),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108172305530.9362-100000@tahallah.demon.co.uk> from "Alex Buell" at Aug 17, 2001 11:11:42 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xs2d-0008EK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dear Gods, not another of Linus's "holiday presents".  These are for th=
> e
> Sparc32 port, I came across one earlier and here's a slightly modified
> patch for drivers/char/vt.c. Original patch came from a l-lk post earli=
> er
> (must have missed it, found a reference to it on sparclinux)

Actually thats one of my presents. The ports are expected to provide
their definition for struct kbd_repeat and a kbd_rate function. If the
facility is not available then it can be defined as NULL

So the sparc asm/keyboard.h if it supports no keyboard rate stuff would be


/*
 *	Sparc32 lacks the standard keyboard rate ioctls
 */

#define kbd_rate	NULL

and it'll error out with -EINVAL

Alan
