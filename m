Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWD0WcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWD0WcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWD0WcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:32:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751658AbWD0WcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:32:09 -0400
Date: Thu, 27 Apr 2006 15:34:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add pci_assign_resource_fixed -- allow fixed
 address assignments
Message-Id: <20060427153432.5f3f4c12.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0604271242410.25641-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0604271242410.25641-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On some embedded systems the PCI address for hotplug devices are not only
> known a priori but are required to be at a given PCI address for other
> master in the system to be able to access.
> 
> An example of such a system would be an FPGA which is setup from user space
> after the system has booted.  The FPGA may be access by DSPs in the system
> and those DSPs expect the FPGA at a fixed PCI address.
> 
> Added pci_assign_resource_fixed() as a way to allow assignment of the PCI
> devices's BARs at fixed PCI addresses.

Is there any sane way in which we can arrange for this function to not be
present in vmlinux's which don't need it?

Options would be

a) Put it in a .a file.

   - messy from a source perspective

   - doesn't work if the only reference is from a module

   - small gains anyway.

b) Use CONFIG_EMBEDDED.

?
