Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbTILXKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTILXKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:10:05 -0400
Received: from hera.cwi.nl ([192.16.191.8]:35560 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261935AbTILXKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:10:00 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 13 Sep 2003 01:09:58 +0200 (MEST)
Message-Id: <UTC200309122309.h8CN9wn08090.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Re: [PATCH][IDE] update qd65xx driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From B.Zolnierkiewicz@elka.pw.edu.pl  Fri Sep 12 00:44:48 2003

	> That reminds me, did I ever send you this?
	>
	> Andries

	No, only similar patch for hpt366.c.

	I think the (almost) correct scheme is following ...

Yes, larger changes are possible - and in fact I have a directory
full of IDE stuff, polishing, cleanup, non-urgent.

I sent this mainly because the hpt366.c analog was needed to
prevent filesystem corruption (on my own system). Similarly,
I imagine this patch is needed to prevent filesystem corruption -
no need to wait until someone actually reports a corrupted filesystem.

Patches that allow people to set lower PIO modes than the max
may be nice, but are less urgent than preventing modes higher
than the max.

Andries

	> -		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
	> +		pio = ide_get_best_pio_mode(drive, 255, pio, &d);
