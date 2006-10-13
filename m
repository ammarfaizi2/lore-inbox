Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWJMU7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWJMU7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWJMU7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:59:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53266 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751902AbWJMU7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:59:48 -0400
Date: Fri, 13 Oct 2006 16:59:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Matthew Wilcox <matthew@wil.cx>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Belay <abelay@MIT.EDU>,
       Arjan van de Ven <arjan@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
In-Reply-To: <20061013191854.GF11633@parisc-linux.org>
Message-ID: <Pine.LNX.4.44L0.0610131657540.8377-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Matthew Wilcox wrote:

> On Fri, Oct 13, 2006 at 01:57:48PM -0400, Alan Stern wrote:
> > Would it be okay for pci_block_user_cfg_access() to use its own cache, so 
> > it doesn't interfere with data previously cached by pci_save_state()?
> 
> My suggestion is just to require that the callers have previously called
> pci_save_state().  The PCI PM stack already has, and it's a one-line
> change to the IPR driver.

Okay.  Would you like to write a patch with that fix?  Be sure to add a 
comment explaining the need for a previous call to pci_save_state().

At least it will get things going for now, even if it isn't perfectly
correct in the long run.

Alan Stern

