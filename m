Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUC1WqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 17:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUC1WqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 17:46:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10985 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262473AbUC1WqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 17:46:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pavel Machek <pavel@ucw.cz>, Arthur Othieno <a.othieno@bluewin.ch>
Subject: Re: Kill IDE debug messages during suspend
Date: Mon, 29 Mar 2004 00:55:25 +0200
User-Agent: KMail/1.5.3
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
References: <20040326001154.GA3353@elf.ucw.cz> <20040328205822.GA846@mars> <20040328222502.GJ406@elf.ucw.cz>
In-Reply-To: <20040328222502.GJ406@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403290055.25084.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 of March 2004 00:25, Pavel Machek wrote:
> Hi!
>
> > What about these stale #ifdefs?
> >
> > drivers/ide/ide-io.c:126:#ifdef DEBUG_PM
> > drivers/ide/ide-io.c:220:#ifdef DEBUG_PM
> > drivers/ide/ide-io.c:638:#ifdef DEBUG_PM
> > drivers/ide/ide-io.c:662:#ifdef DEBUG_PM
>
> I wanted to leave debugging possible...
>
> > This patch sweeps up both DEBUG_PM and DEBUG #ifdefs in favour of
> > pr_debug()

Well, I doubt anybody wants to debug taskfile IOs and PM at the same time.
[ pm_debug() ? ]

BTW adding -DDEBUG to EXTRA_CFLAGS in Makefile is cleaner
than defining/undefining it inside .c or .h.

> ...but your patch looks better.
> 								Pavel
>
> >  ide-io.c |   74
> > ++++++++++++++++++++++++++-------------------------------------

