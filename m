Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWCVNvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWCVNvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCVNvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:51:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:48868 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751244AbWCVNvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:51:20 -0500
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] i386: run BIOS PCI detection before direct
Date: Wed, 22 Mar 2006 14:10:47 +0100
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, gregkh@suse.de
References: <20060317000303.13252107@localhost.localdomain> <441A91A5.3020607@shadowen.org>
In-Reply-To: <441A91A5.3020607@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221410.47505.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 11:38, Andy Whitcroft wrote:
> Dave Hansen wrote:
> > from 2.6.16-rc3-mm1 through at least 2.6.16-rc6-mm1 a patch from
> > Andi Kleen, titled
> > 
> >         x86_64-i386-pci-ordering.patch
> > 
> > which is now called:
> > 
> > 	gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
> > 
> > has caused a 4-way PIII Xeon (non-NUMA) to stop detecting its SCSI
> > card.  I believe this is also the issue keeping -mm from booting
> > on "elm3b67" from http://test.kernel.org/. 
> > 
> > The following patch reverts the ordering of the PCI detection code
> > to always run the BIOS initialization, first.  As far as I can
> > tell, this was the original behavior, and it makes my machine boot
> > again.
> > 
> > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> Ran this through the nightly regression suite on the affected machine
> and it boots fine with this patch applied.

I fixed this up my copy of the patch.

Also fixed the warning with CONFIG_ACPI=n

Thanks,

-Andi
