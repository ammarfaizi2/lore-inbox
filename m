Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWIGNB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWIGNB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWIGNB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:01:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751782AbWIGNBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:01:25 -0400
Subject: Re: question regarding cacheline size
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060907124026.GN2558@parisc-linux.org>
References: <44FFD8C6.8080802@gmail.com>
	 <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com>
	 <20060907120756.GA29532@flint.arm.linux.org.uk>
	 <20060907122311.GM2558@parisc-linux.org>
	 <1157632405.14882.27.camel@laptopd505.fenrus.org>
	 <20060907124026.GN2558@parisc-linux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 07 Sep 2006 15:01:19 +0200
Message-Id: <1157634080.14882.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 06:40 -0600, Matthew Wilcox wrote:
> On Thu, Sep 07, 2006 at 02:33:25PM +0200, Arjan van de Ven wrote:
> > 
> > > 
> > > So I think we should redo the PCI subsystem to set cacheline size during
> > > the buswalk rather than waiting for drivers to ask for it to be set.
> > 
> > ... while allowing for quirks for devices that go puke when this
> > register gets written ;)
> > 
> > (afaik there are a few)
> 
> So you want:
> 
> 	unsigned int no_cls:1;	/* Device pukes on write to Cacheline Size */
> 
> in struct pci_dev?

something like that yes...


