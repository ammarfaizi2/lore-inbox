Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276255AbRJGJ5Z>; Sun, 7 Oct 2001 05:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJGJ5R>; Sun, 7 Oct 2001 05:57:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25860 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276247AbRJGJ47>; Sun, 7 Oct 2001 05:56:59 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
To: jdthood@mail.com (Thomas Hood)
Date: Sun, 7 Oct 2001 11:02:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1002423279.978.28.camel@thanatos> from "Thomas Hood" at Oct 06, 2001 10:54:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qAlp-0005Mw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This change has to be permanent.  Linux should never automatically
> set the boot flag, no matter how PnP-competent we make it.
> The reason is that setting the flag affects what the BIOS will
> do on the _subsequent_ boot.  But Linux can't possibly know 
> which operating system will be booted _next time_.  This is
> something that has to be left up to the user to control.

When it cuts your reboot time right down then its a very useful thing to
set. Also remember that this is entirely configurable. In fact the last
stage of a pnp aware bootup requires that user space sets the "booted ok"
flag.

> a "quick boot" flag, but the time savings involved must be on the
> order of milliseconds.  All that we seem to achieve by booting

On some boxes they are much higher

> If I'm right, then bootflag.c should be modified (see my patch)
> to remove the bit that sets the flag.  It would be nice,
> however, if the flag could be controlled via a /proc entry.

No need. It's all already handled

Alan
