Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265512AbRGCAXU>; Mon, 2 Jul 2001 20:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbRGCAXK>; Mon, 2 Jul 2001 20:23:10 -0400
Received: from burdell.cc.gatech.edu ([130.207.3.207]:29446 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S265512AbRGCAW6>; Mon, 2 Jul 2001 20:22:58 -0400
Date: Mon, 2 Jul 2001 20:22:55 -0400 (EDT)
From: David T Eger <eger@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: readl() / writel() on PowerPC
In-Reply-To: <Pine.SOL.4.21.0106180852480.16027-100000@oscar.cc.gatech.edu>
Message-ID: <Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been working on a driver for a PowerPC PCI card/framebuffer device,
and noticed that the standard readl() and writel() for this platform to
byte swapping, since PowerPC runs big-endian.  However, at least for my
hardware it's *really* not needed, and should just do a regular load
store, as is done for CONFIG_APUS.  Looking at another driver
(drivers/char/bttv.h) I notice that Mr. Metzler redefines his read and
write routines for PowerPC as well to do simple loads and stores to IO
regions.

Am I missing something?  Is there some reason that readl() and
writel() should byte-swap by default?


