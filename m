Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757765AbWKXN3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765AbWKXN3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757768AbWKXN3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:29:25 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52933 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757766AbWKXN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:29:24 -0500
Date: Fri, 24 Nov 2006 13:35:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Juergen Beisert <juergen127@kreuzholzen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] i386/pci: fix nibble permutation and add Cyrix
 5530 IRQ router
Message-ID: <20061124133544.5334f789@localhost.localdomain>
In-Reply-To: <200611241409.30546.juergen127@kreuzholzen.de>
References: <200611241144.06267.juergen127@kreuzholzen.de>
	<20061124114156.1b02cf2e@localhost.localdomain>
	<200611241409.30546.juergen127@kreuzholzen.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmmm, as I understand the source, it let the routing register entries 
> unchanged if the BIOS did it before. This is why it (IMHO) works. But if this 

The 5530 isn't matched by the PCI router code so we fall back to the PCI
BIOS32 services which do know what they are doing.

> routine tries to set a new route it fails due to it writes the wrong register 
> nibble. But maybe I'm wrong, I will read the source again (and try to get a 
> CS5520 datasheet).

I have the 5520 data sheet. For IRQ routing the 5520 and 5530 are
identical according to the docs and code according to the docs doens't
generally work ..

If you need to set these for LinuxBIOS then perhaps matching and setting
it up only if LinuxBIOS is present would be the better choice ?

Alan
