Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUK0B7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUK0B7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUK0Bqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:46:47 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263031AbUKZTi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:29 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Len Brown <len.brown@intel.com>,
       Chris Wright <chrisw@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411201048470.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411201048470.20993@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101313614.2434.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 16:26:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-11-20 at 19:10, Linus Torvalds wrote:
> These kinds of things hopefully aren't all that common (there can't be a 
> lot of extra hw required to follow the PCI spec _properly_), but if I were 
> a hw designer, I'd connect such a chip to the PIRQ input, and just make 
> the BIOS enable it automatically.

The PCI spec includes several such bits of magic itself remember -
notably on a PC the use of IRQ14 and IRQ15 by the IDE controller is not
via the PCI PIRQ routing.

