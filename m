Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWIGMk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWIGMk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIGMk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:40:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:23979 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751661AbWIGMk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:40:27 -0400
Date: Thu, 7 Sep 2006 06:40:26 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907124026.GN2558@parisc-linux.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157632405.14882.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:33:25PM +0200, Arjan van de Ven wrote:
> 
> > 
> > So I think we should redo the PCI subsystem to set cacheline size during
> > the buswalk rather than waiting for drivers to ask for it to be set.
> 
> ... while allowing for quirks for devices that go puke when this
> register gets written ;)
> 
> (afaik there are a few)

So you want:

	unsigned int no_cls:1;	/* Device pukes on write to Cacheline Size */

in struct pci_dev?
