Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUI1VIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUI1VIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUI1VIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:08:32 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12044 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267926AbUI1VIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:08:24 -0400
Date: Tue, 28 Sep 2004 22:08:21 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Joerg Sommrey <jo175@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nmi watchdog failure on dual Athlon box
In-Reply-To: <20040928183103.GA10593@sommrey.de>
Message-ID: <Pine.LNX.4.58L.0409282159480.24587@blysk.ds.pg.gda.pl>
References: <20040928163324.GA5759@sommrey.de> <Pine.LNX.4.58L.0409281802270.32231@blysk.ds.pg.gda.pl>
 <20040928183103.GA10593@sommrey.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, Joerg Sommrey wrote:

> |--- lockupcli.c
> |
> |main ()
> |{
> |	iopl(3);
> |	for (;;) asm("cli");
> |}
> 
> Does this mean there is a good reason for further investigations on why
> the IO-APIC NMI watchdog doesn't work? Until now I thought it would
> be ok as long as the local APIC NMI watchdog is set up.

 Since this program does busy looping, the local APIC NMI watchdog should
trigger indeed.  It's "cli; hlt" that causes a problem with this watchdog.  
Something wrong is happening in your system, indeed.

  Maciej
