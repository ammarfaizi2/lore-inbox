Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVIIAjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVIIAjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVIIAjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:39:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:39116 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751267AbVIIAjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:39:48 -0400
Date: Fri, 9 Sep 2005 02:39:47 +0200
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.13-mm2
Message-ID: <20050909003947.GE19913@wotan.suse.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <73450000.1126189801@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73450000.1126189801@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 07:30:01AM -0700, Martin J. Bligh wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> > 
> > (kernel.org propagation is slow.  There's a temp copy at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> > 
> > 
> > 
> > - Added Andi's x86_64 tree, as separate patches
> > 
> > - Added a driver for TI acx1xx cardbus wireless NICs
> > 
> > - Large revamp of pcmcia suspend handling
> > 
> > - Largeish v4l and DVB updates
> > 
> > - Significant parport rework
> > 
> > - Many tty drivers still won't compile
> > 
> > - Lots of framebuffer driver updates
> > 
> > - There are still many patches here for 2.6.14.  We're doing pretty well
> >   with merging up the subsystem trees.  ia64 and CIFS are still pending. 
> >   x86_64 and several of Greg's trees (especially USB) aren't merged yet.
> 
> Build fails on x86_64, at least, with this config:
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
> 
> arch/x86_64/pci/built-in.o(.init.text+0xa88): In function `pci_acpi_scan_root':
> : undefined reference to `pxm_to_node'
> make: *** [.tmp_vmlinux1] Error 1
> 09/08/05-06:52:31 Build the kernel. Failed rc = 2
> 09/08/05-06:52:31 build: kernel build Failed rc = 1
> 09/08/05-06:52:31 command complete: (2) rc=126
> Failed and terminated the run

I tried the config in my (non mm) tree and it compiled just fine.
Must be some bad interaction with another patch in -mm* or a bad 
merge.

The original patch that introduces it is
ftp://ftp.firstfloor.org/pub/ak/x86_64/x86_64-2.6.13-1/patches/pci-pxm

pxm_to_node for x86-64 is supposed to be declared in arch/x86_64/mm/srat.c

Andrew?

-Andi

