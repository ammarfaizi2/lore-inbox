Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265790AbUGHF7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUGHF7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGHF7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:59:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30848 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265790AbUGHF7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:59:41 -0400
Date: Wed, 7 Jul 2004 19:06:42 -0500
From: linas@austin.ibm.com
To: Linda Xie <lxiep@us.ibm.com>
Cc: greg@kroah.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040707190642.J21634@forte.austin.ibm.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <40EC9A02.1000507@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EC9A02.1000507@us.ibm.com>; from lxiep@us.ibm.com on Wed, Jul 07, 2004 at 07:49:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 07:49:06PM -0500, Linda Xie wrote:
> linas@austin.ibm.com wrote:
> 
> > 	}
> > 	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
> > 	/* do pci_scan_child_bus */
> >-	pci_scan_child_bus(child_bus);
> >+	// pci_scan_child_bus(child_bus);
> > 
> Why remove pci_scan_child_bus call?

Because it won't compile otherwise.  
(Actually, I didn't mean to leave that in the patch, 
it was a work-around to get my tree to compile).

pci_scan_child_bus() is currently defined only as a static fuction
in drivers/pci/probe.c and thus cannot be called outside of that 
file.  Maybe there's a patch to drivers/pci/probe.c that hasn't 
been applied yet?

--linas
