Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVGZCDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVGZCDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVGZCDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:03:09 -0400
Received: from mx1.rowland.org ([192.131.102.7]:8713 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S261538AbVGZCDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:03:08 -0400
Date: Mon, 25 Jul 2005 21:56:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
In-Reply-To: <200507260029.41709@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507252152350.20667-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005, Michel Bouissou wrote:

> Le Lundi 25 Juillet 2005 22:44, Alan Stern a écrit :
> >
> > Now that's strange.  When you plug the high-speed device into the
> > integrated ports, which IRQ counter changes?  Since nothing is using IRQ
> > 21, it should be disabled and its counter should remain constant.  Does
> > this mean the interrupts show up on IRQ 19 (used by ehci-hcd), or do they
> > not show up at all (i.e., is the USB connection just being polled)?
> 
> I assume it's IRQ 19.
> 
> cat /proc/interrupts doesn't show IRQ21 at all when uhci isn't loaded.

As it shouldn't, since nothing is supposed to be using that IRQ.

> IRQ 19 being shared with 4 IDE controllers that controls my hard drives, 
> that's hard to isolate interrupts counts due to USB activity from interrupts 
> counts due to disks activity...

I was afraid you'd say that...

Natalie, that's all I can think of.  Now it's up to you to invent a patch
Michel can try out, to show just where the IO-APIC code is going wrong.

Alan Stern

