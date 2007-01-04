Return-Path: <linux-kernel-owner+w=401wt.eu-S1751103AbXADCPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXADCPN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 21:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXADCPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 21:15:13 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43039
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751103AbXADCPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 21:15:11 -0500
Date: Wed, 03 Jan 2007 18:15:10 -0800 (PST)
Message-Id: <20070103.181510.00930133.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       benh@kernel.crashing.org, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1a41c67ddc85c317d358b32a274babdf@kernel.crashing.org>
References: <f07fd44aab26bf553ecdab5be5ee962e@kernel.crashing.org>
	<20070102.203417.102576086.davem@davemloft.net>
	<1a41c67ddc85c317d358b32a274babdf@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 3 Jan 2007 16:23:53 +0100

> >>> therefore you can't let multiple CPUs call
> >>> into OFW at one time.  You must use some kind of locking mechanism,
> >>> and that locking mechanism is not simple because it has to not just
> >>> stop the other cpus, it has to be able to stop the other cpus yet
> >>> still allow them to receive SMP cross-calls from the firmware if the
> >>> OFW call is 'stop' or similar.
> >>
> >> YOu don't need to *stop* the other CPUs, you just need to
> >> prevent them from entering the client interface.  Put a lock
> >> in front.
> >
> > That's not the issue.
> >
> > If the global OFW lock disables interrupts,
> 
> Why would it?

Because if a serial/keyboard/other-console-input-device interrupt
arrives, from the user hitting the "BREAK" key sequence, you'll have
to enter OBP from a hardware interrupt handler.

Look, this thread is already tiring me, having to explain a lot
of things and not making much useful progress.  So I'll just be
honest and say that I'll go work on other things which need my
time and won't take part in this thread any more.

Take care.
