Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWCPXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWCPXtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCPXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:49:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:51644
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751227AbWCPXtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:49:41 -0500
Date: Thu, 16 Mar 2006 15:49:06 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Grundler <iod00d@hp.com>
Cc: Mark Maule <maule@sgi.com>, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060316234906.GA24675@suse.de>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com> <20060316234118.GB9746@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316234118.GB9746@esmail.cup.hp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:41:18PM -0800, Grant Grundler wrote:
> On Thu, Mar 16, 2006 at 12:19:34PM -0600, Mark Maule wrote:
> > If there's objectins to having struct msi_ops declared in pci.h, then I guess
> > we need to come up with another solution.
> 
> There are other transaction based interrupt subsystems that are typically
> arch specific (e.g. GSC device interrupts on PA-RISC). So far, MSI is the
> only generic one and that is clearly part of the PCI spec. 

Yes, that's fine.  But the core pci msi structures do not need to be
exported for the whole kernel to see, right?  That's my only point here.

pci.h is cluttered enough as it is :)

thanks,

greg k-h
