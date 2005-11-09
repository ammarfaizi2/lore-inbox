Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVKIN5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKIN5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKIN5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:57:04 -0500
Received: from colin.muc.de ([193.149.48.1]:3593 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750760AbVKIN5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:57:02 -0500
Date: 9 Nov 2005 14:56:50 +0100
Date: Wed, 9 Nov 2005 14:56:50 +0100
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, gregkh@suse.de
Subject: Re: Changing MSI to use physical delivery mode always.
Message-ID: <20051109135650.GA78272@muc.de>
References: <20051108070038.A15318@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108070038.A15318@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 07:00:38AM -0800, Ashok Raj wrote:
> Hi,
> 
> MSI was hard coded to use logical delivery mode for i386/x86_64 and 
> physical mode for ia64.
> 
> With recent x86_64 we moved to physical flat mode that broke MSI.
> 
> Made MSI to work with physical mode, this will be consistent on all
> archs. 

Nasty bug. Thanks for tracking that down.

It is outright scary though that such deeply architecture specific
code is in drivers/pci. It should be in arch. I think that was
because I missed it. Would you be willing to move the APIC specific parts 
to arch/i386/pci ? 

-Andi

