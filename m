Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbULMPwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbULMPwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbULMPwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:52:23 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:62444 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261248AbULMPwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:52:21 -0500
Date: Mon, 13 Dec 2004 16:52:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213155208.GI16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <1102939243.2478.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102939243.2478.17.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:00:44PM +0000, Alan Cox wrote:
> - Laptops tend to lose ticks on battery status queries at 1Khz

The lost-tick adjustment code should in theory cope with it, however in
my firewall with USB adsl modem taking 3msec-long-irqs, it makes the
system time go in the future pretty quick (instead of losing time
without tick compensation code). I guess the same would happen with the
battery status checks.
