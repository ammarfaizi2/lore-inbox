Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWJMROJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWJMROJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWJMROI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:14:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56199 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751070AbWJMROG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:14:06 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Adam Belay <abelay@MIT.EDU>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <1160760867.25218.77.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
	 <1160757260.26091.115.camel@localhost.localdomain>
	 <1160759349.25218.62.camel@localhost.localdomain>
	 <20061013164933.GD11633@parisc-linux.org>
	 <1160760867.25218.77.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 13 Oct 2006 19:13:52 +0200
Message-Id: <1160759632.14815.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 18:34 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 10:49 -0600, ysgrifennodd Matthew Wilcox:
> > No it didn't.  It's undefined behaviour to perform *any* PCI config
> > access to the device while it's doing a D-state transition.  It may have
> 
> I think you missed the earlier parts of the story - the kernel caches
> the base config register state.
> 
> > happened to work with the chips you tried it with, but more likely you
> > never hit that window because X simply didn't try to do that.
> 
> Which is why the kernel caches the register state. 

but... it didn't USE the cache in the case we're protecting here.
Instead the hardware would just go splat.


