Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277893AbRJaAXP>; Tue, 30 Oct 2001 19:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277983AbRJaAXF>; Tue, 30 Oct 2001 19:23:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277893AbRJaAWx>; Tue, 30 Oct 2001 19:22:53 -0500
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 31 Oct 2001 00:28:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), zzz@cd-club.ru (Denis Zaitsev),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110301610460.1336-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 30, 2001 04:12:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yjFR-0001qh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Firstly the array is __init so is discarded on boot
> 
> I think that array really is broken. We should get the name association
> from the array that "register_blkdev()" maintains, I'm sure. That way
> random stupid driver X doesn't need to touch a common init/main.c file,
> which I find personally offensive.

For 2.5 definitely. Right now we'd have to be very careful to process
the string -> number conversion after initrd had run (ie at the root change)
and also add a mechanism for aliases for the names we don't quite match
