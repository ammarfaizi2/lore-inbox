Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUJHTtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUJHTtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUJHTtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:49:50 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:60813 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263540AbUJHTts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 15:49:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Fri, 8 Oct 2004 13:49:41 -0600
User-Agent: KMail/1.7
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200409301014.00725.bjorn.helgaas@hp.com> <20041006083249.C18379@flint.arm.linux.org.uk> <200410061354.15746.bjorn.helgaas@hp.com>
In-Reply-To: <200410061354.15746.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410081349.41962.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 October 2004 1:54 pm, Bjorn Helgaas wrote:
> On Wednesday 06 October 2004 1:32 am, Russell King wrote:
> > I think you'll do better to discuss this problem with Alan so that
> > he can change his (and maybe others) points of view wrt when the
> > serial console is initialised.  Until then I'm going to continue
> > sitting on the fence on this point.
> 
> Yeah, I'll poke him about "console=uart".  I sent it to you because I
> think a clean solution requires minor 8250 hooks so we can look up
> the ttyS device that corresponds to an MMIO or IO address.

On second thought, I want the "console=uart" stuff regardless of
what happens with early port registration, because it fixes the
ia64 problem of port names changing based on firmware configuration.

I'd like to make forward progress on that.  Do you have any comments
on it?  The (whitespace-mangled) patch is here:
    http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1034.html
