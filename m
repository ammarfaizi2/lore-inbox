Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271633AbRIBPPu>; Sun, 2 Sep 2001 11:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271629AbRIBPPk>; Sun, 2 Sep 2001 11:15:40 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:41163 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271633AbRIBPPd>; Sun, 2 Sep 2001 11:15:33 -0400
Date: Sun, 2 Sep 2001 16:15:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent for small allocations?
Message-ID: <20010902161550.C11463@flint.arm.linux.org.uk>
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Sep 02, 2001 at 08:08:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 08:08:00AM -0700, Adam J. Richter wrote:
> 	In looking at the ieee1394 OHCI driver, I noticed that it
> appears to make 104 calls to pci_alloc_consistent for data structures
> that are 16 or 64 bytes.  Currently, on x86, pci_alloc_consistent
> allocates at least one full page per call, so it looks like the
> ohci1394 driver allocates 416kB per controller as a result of these
> data structures.

You might want to look through the PCI stuff in drivers/pci - there's a
generic method for handling this on USB already.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

