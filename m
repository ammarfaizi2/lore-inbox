Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUAEKbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 05:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUAEKbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 05:31:23 -0500
Received: from cibs9.sns.it ([192.167.206.29]:28686 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S264126AbUAEKbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 05:31:21 -0500
Date: Mon, 5 Jan 2004 11:31:19 +0100 (CET)
From: venom@sns.it
To: Soeren Sonnenburg <kernel@nn7.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
In-Reply-To: <1073211091.3261.4.camel@localhost>
Message-ID: <Pine.LNX.4.43.0401051127080.32446-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 4 Jan 2004, Soeren Sonnenburg wrote:

> > out of interest, have you tried to see how 2.4.xx compares when compiled
> > with HZ set to 1000?
> > (or conversely, 2.6 compiled with HZ set to 100)
>
> assuming you mean changing the HZ value in include/param.h to 1000/100
> yes 2.4 with HZ=1000 is fine and 2.6 with HZ=100 still #%$@$^&!!
>
mmhhh! depends...

On a DB that has to write often big, long data streams HZ=100 on a 2.6.0 kernel
allows a better performance instead of HZ=1000 (no kernel preemption).

on a DB that has to read often small, short data streams HZ=1000 is better than
HZ=100 with a 2.6.0 kernel.

Luigi



