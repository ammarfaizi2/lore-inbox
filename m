Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWCVWIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWCVWIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWCVWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:08:51 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:19082
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932079AbWCVWIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:08:50 -0500
Date: Wed, 22 Mar 2006 14:08:17 -0800
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] i386: run BIOS PCI detection before direct
Message-ID: <20060322220817.GA13453@suse.de>
References: <20060317000303.13252107@localhost.localdomain> <441A91A5.3020607@shadowen.org> <200603221410.47505.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221410.47505.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 02:10:47PM +0100, Andi Kleen wrote:
> On Friday 17 March 2006 11:38, Andy Whitcroft wrote:
> > Dave Hansen wrote:
> > > from 2.6.16-rc3-mm1 through at least 2.6.16-rc6-mm1 a patch from
> > > Andi Kleen, titled
> > > 
> > >         x86_64-i386-pci-ordering.patch
> > > 
> > > which is now called:
> > > 
> > > 	gregkh-pci-pci-give-pci-config-access-initialization-a-defined-ordering.patch
> > > 
> > > has caused a 4-way PIII Xeon (non-NUMA) to stop detecting its SCSI
> > > card.  I believe this is also the issue keeping -mm from booting
> > > on "elm3b67" from http://test.kernel.org/. 
> > > 
> > > The following patch reverts the ordering of the PCI detection code
> > > to always run the BIOS initialization, first.  As far as I can
> > > tell, this was the original behavior, and it makes my machine boot
> > > again.
> > > 
> > > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> > 
> > Ran this through the nightly regression suite on the affected machine
> > and it boots fine with this patch applied.
> 
> I fixed this up my copy of the patch.
> 
> Also fixed the warning with CONFIG_ACPI=n

Care to send me that copy of the patch so I can forward it on?

thanks,

greg k-h
