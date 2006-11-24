Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757736AbWKXNJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736AbWKXNJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757741AbWKXNJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:09:34 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:63714 "EHLO
	bill.weihenstephan.org") by vger.kernel.org with ESMTP
	id S1757735AbWKXNJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:09:33 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 001/001] i386/pci: fix nibble permutation and add Cyrix 5530 IRQ router
Date: Fri, 24 Nov 2006 14:09:30 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200611241144.06267.juergen127@kreuzholzen.de> <20061124114156.1b02cf2e@localhost.localdomain>
In-Reply-To: <20061124114156.1b02cf2e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241409.30546.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Friday 24 November 2006 12:41, Alan wrote:
> On Fri, 24 Nov 2006 11:44:05 +0100
>
> > Cyrix 5520 and Cyrix 5530 do interrupt routing in the same way. But the
> > (pirq-1)^1 expression to set a route always sets the wrong nibble, so
> > INTA/INTB and INTC/INTD are permuted and do not work as expected.
> >
> > Signed-off-by: Juergen Beisert <juergen.beisert@weihenstephan.org>
>
> NAK
>
> This will then break other boards. As far as I can tell there is no
> "correct" answer here for 5530 based hardware. The existing setup makes
> most random CS5520/30 based PC systems like the Palmax laptops work if the
> irq router is used, your change will break them

Hmmmm, as I understand the source, it let the routing register entries 
unchanged if the BIOS did it before. This is why it (IMHO) works. But if this 
routine tries to set a new route it fails due to it writes the wrong register 
nibble. But maybe I'm wrong, I will read the source again (and try to get a 
CS5520 datasheet).

> Given the choice between LinuxBIOS and the rest of the world then the
> rest of the world needs to win.

ACK. :-)

Juergen
