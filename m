Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933883AbWKTLhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933883AbWKTLhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933884AbWKTLhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:37:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36483 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933883AbWKTLhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:37:01 -0500
Date: Mon, 20 Nov 2006 11:42:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Roese <ml@stefan-roese.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx
 systems
Message-ID: <20061120114248.60bb0869@localhost.localdomain>
In-Reply-To: <200611201200.36780.ml@stefan-roese.de>
References: <200611201200.36780.ml@stefan-roese.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 12:00:36 +0100
Stefan Roese <ml@stefan-roese.de> wrote:

> This patch fixes a problem seen on multiple 4xx platforms, where
> the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> on those systems to not use an real interrupt but the timer based
> implementation.

NAK.

Zero means "no interrupt" in the Linux space. If you have a physical IRQ
0 remap it to a convenient number (eg map IRQ's + 1, or stick it on the
end). The logical and physical IRQ numbering in Linux don't have to match
up - and given some platforms have IRQ numbering per bus and the like
clearly doesn't in many cases.
