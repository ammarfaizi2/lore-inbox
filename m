Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933060AbWKXLfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbWKXLfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWKXLfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:35:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27271 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933060AbWKXLfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:35:41 -0500
Date: Fri, 24 Nov 2006 11:41:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Juergen Beisert <juergen127@kreuzholzen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] i386/pci: fix nibble permutation and add Cyrix
 5530 IRQ router
Message-ID: <20061124114156.1b02cf2e@localhost.localdomain>
In-Reply-To: <200611241144.06267.juergen127@kreuzholzen.de>
References: <200611241144.06267.juergen127@kreuzholzen.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 11:44:05 +0100
> Cyrix 5520 and Cyrix 5530 do interrupt routing in the same way. But the
> (pirq-1)^1 expression to set a route always sets the wrong nibble, so
> INTA/INTB and INTC/INTD are permuted and do not work as expected.
> 
> Signed-off-by: Juergen Beisert <juergen.beisert@weihenstephan.org>

NAK

This will then break other boards. As far as I can tell there is no
"correct" answer here for 5530 based hardware. The existing setup makes
most random CS5520/30 based PC systems like the Palmax laptops work if the
irq router is used, your change will break them

Given the choice between LinuxBIOS and the rest of the world then the
rest of the world needs to win. The 5530 is absent from the IRQ routing
table because it varied by system what the right answer was.

Alan
