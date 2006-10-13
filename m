Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWJMTS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWJMTS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJMTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:18:56 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:61924 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751825AbWJMTS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:18:56 -0400
Date: Fri, 13 Oct 2006 13:18:54 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adam Belay <abelay@MIT.EDU>,
       Arjan van de Ven <arjan@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061013191854.GF11633@parisc-linux.org>
References: <1160760867.25218.77.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610131355550.6612-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610131355550.6612-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 01:57:48PM -0400, Alan Stern wrote:
> Would it be okay for pci_block_user_cfg_access() to use its own cache, so 
> it doesn't interfere with data previously cached by pci_save_state()?

My suggestion is just to require that the callers have previously called
pci_save_state().  The PCI PM stack already has, and it's a one-line
change to the IPR driver.
