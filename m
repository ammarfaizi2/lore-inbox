Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270632AbTHEUIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTHEUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:08:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:511 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270632AbTHEUIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:08:37 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 22:08:36 +0200 (MEST)
Message-Id: <UTC200308052008.h75K8aD22137.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] fix error return get/set_native_max functions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This change is okay, thanks.
> However changing coding style is not...

An interesting remark.

I belong to the people who look at kernel source on a screen
with 80 columns. Code that is wider and wraps is unreadable.

Now of course you might react "buy a better monitor", but in fact
this restriction leads to cleaner code. There is something wrong
when code is indented too deeply, and almost always a cleanup is
possible that splits some inner stuff out as a separate function.

As a side effect of that you'll see in patches from me changes
that bring the code within the 80-column limit.

> -static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
> +static unsigned long
> +idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)

It is a matter of taste precisely which transformation is best
in order to bring the source within the 80-column limit,
but having the type on the preceding line is very common
in the kernel source (and elsewhere), so among the possible
ways of splitting this line this is a very natural one.

I am not interested in a discussion about style, but will defend
the 80-column limit.

Andries


---
Functions should be short and sweet, and do just one thing.  They should
fit on one or two screenfuls of text (the ISO/ANSI screen size is 80x24,
as we all know), and do one thing and do that well.
