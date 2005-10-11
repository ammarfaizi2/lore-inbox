Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbVJLF5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbVJLF5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 01:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJLF5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 01:57:42 -0400
Received: from ozlabs.org ([203.10.76.45]:40921 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932473AbVJLF5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 01:57:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17228.19865.982656.956187@cargo.ozlabs.ibm.com>
Date: Wed, 12 Oct 2005 09:41:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 20/22] PCI Error Recovery: e100 network device driver
In-Reply-To: <20051011230409.GS29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
	<20051006235729.GU29826@austin.ibm.com>
	<20051011001056.GA16634@kroah.com>
	<20051011230409.GS29826@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas writes:
> On Mon, Oct 10, 2005 at 05:10:56PM -0700, Greg KH was heard to remark:
> > On Thu, Oct 06, 2005 at 06:57:29PM -0500, linas wrote:
> > > +config E100_EEH_RECOVERY
> > > +	bool "Enable PCI bus error recovery"
> > > +	depends on E100 && PPC_PSERIES
> > > +   help
> > > +      If you say Y here, the driver will be able to recover from
> > > +      PCI bus errors on many PowerPC platforms. IBM pSeries users
> > > +      should answer Y.
> > 
> > Why make a config option for this at all?  Who would turn it off?
> 
> I wanted to have this turned off for anyone who didn't have 
> hardware capable of supporting this, and didn't really think 
> about how to hide this from the menu.  I guess its best to
> just plain hide this, keep the menus from getting cluttered.

I would think we could have one config option to enable PCI bus error
recovery generally, and have the code in the drivers enabled by that.
I don't think we need an individual config option for each driver to
enable PCI error recovery.

Regards,
Paul.
