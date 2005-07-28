Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVG1S2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVG1S2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVG1S0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:26:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:7413 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261863AbVG1SZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:25:26 -0400
Subject: Re: [patch] mm: Ensure proper alignment for node_remap_start_pfn
From: Dave Hansen <haveblue@us.ibm.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, shai@scalex86.org
In-Reply-To: <20050728181421.GA3842@localhost.localdomain>
References: <20050728004241.GA16073@localhost.localdomain>
	 <20050727181724.36bd28ed.akpm@osdl.org>
	 <20050728013134.GB23923@localhost.localdomain>
	 <1122571226.23386.44.camel@localhost>
	 <20050728181421.GA3842@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 11:25:22 -0700
Message-Id: <1122575122.20800.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 11:14 -0700, Ravikiran G Thirumalai wrote:
> SRAT need not guarantee any alignment at all in the memory affinity 
> structure (the address in 64-bit byte address)

The Summit machines (the only x86 user of the SRAT) have other hardware
guarantees about alignment, so I guess that's why we've never
encountered it.  Are you using the SRAT on non-Summit hardware?  That
doesn't seem possible:

arch/i386/Kconfig:
        config ACPI_SRAT
                bool
                default y
                depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
        
> And yes, there are x86-numa
> machines that run the latest kernel tree and face this problem.

I didn't say "run the latest kernel tree".  *In* the latest kernel
tree :)

-- Dave

