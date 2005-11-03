Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVKCRPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVKCRPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVKCRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:15:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8634 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030290AbVKCRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:15:35 -0500
Subject: Re: First steps towards making NO_IRQ a generic concept
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051103145141.GX23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org>
	 <20051103145141.GX23749@parisc-linux.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 18:15:30 +0100
Message-Id: <1131038130.2839.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 07:51 -0700, Matthew Wilcox wrote:
> Introduce PCI_NO_IRQ and pci_valid_irq()
> Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
> the value of PCI_NO_IRQ when all drivers have been audited.


can pci_valid_irq() accept a device instead of a number?
that allows a lot more checks later on (like "is it enabled") and other
such checks. 

