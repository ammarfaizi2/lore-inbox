Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUHCRbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUHCRbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUHCRbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:31:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29692 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266748AbUHCRbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:31:36 -0400
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
From: Dave Hansen <haveblue@us.ibm.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091552426.4981.103.camel@tdi>
References: <1091552426.4981.103.camel@tdi>
Content-Type: text/plain
Message-Id: <1091554271.27397.5327.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:31:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 10:00, Alex Williamson wrote:
>    This is by no means ready for release, but I wanted to get a sanity
> check.  I'm still stuck on this idea that userspace needs access to ACPI
> namespace.  Manageability apps might use this taking inventory of
> devices not exposed by other means, things like X can locate chipset
> components that don't live in PCI space, there's even the possibility of
> making user space drivers.

The only thing that worries me about a patch like this is that it
encourages people to write arch-specific tools that have no chance of
working on multiple platforms.  

Right now, on ppc64, we have a system for making direct calls into the
firmware, as well as a copy of the firmware's device-tree exported to
userspace.  This means that we have userspace applications that do very
generic things like counting CPUs, or activating memory in very
arch-specific ways.  

Creating more of these interfaces encourages more of these arch-specific
applications, and what we end up with are lots of tools that only work
on Intel platforms or IBM ppc, but not Linux in general.

So, what kinds of generic, arch-independent interfaces should we
implement in the kernel that would reduce the need for something like
your driver?

-- Dave


