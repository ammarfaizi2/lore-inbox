Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFOJsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFOJsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFOJsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:48:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:49314 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261363AbVFOJsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:48:35 -0400
Date: Wed, 15 Jun 2005 11:48:33 +0200
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: len.brown@intel.com, ak@suse.de, acpi-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/04] PCI: use the MCFG table to properly access pci devices (i386)
Message-ID: <20050615094833.GB11898@wotan.suse.de>
References: <20050615052916.GA23394@kroah.com> <20050615053031.GB23394@kroah.com> <20050615053120.GC23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615053120.GC23394@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 10:31:20PM -0700, Greg KH wrote:
> Now that we have access to the whole MCFG table, let's properly use it
> for all pci device accesses (as that's what it is there for, some boxes
> don't put all the busses into one entry.)
> 
> If, for some reason, the table is incorrect, we fallback to the "old
> style" of mmconfig accesses, namely, we just assume the first entry in
> the table is the one for us, and blindly use it.

I think it would be better to set different bus->ops at probe
time, not walk the table at runtime.

-Andi
