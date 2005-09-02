Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVIBFlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVIBFlo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 01:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVIBFlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 01:41:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:54711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751016AbVIBFlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 01:41:44 -0400
Date: Thu, 1 Sep 2005 22:38:23 -0700
From: Greg KH <greg@kroah.com>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH]reconfigure MSI registers after resume
Message-ID: <20050902053823.GA10287@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502409A45B38@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502409A45B38@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:59:32PM -0700, Nguyen, Tom L wrote:
> On Thursday, September 01, 2005 1:10 PM Andrew Morton wrote:
> >>
> >> On Thursday, September 01, 2005 12:32 PM Andrew Morton wrote:
> >> > So what is the alternative to Shaohua's fix?  Restore all the msi 
> >> > registers on resume?
> >> 
> >> Yes, the PCIe port bus driver, for example, did that.
> >> 
> 
> > So you're saying that each individual driver which uses MSI is
> responsible
> > for the restore?  
> Yes.
> 
> > Is it not possible to do this in some single centralized place?
> Existing pci_save_state(dev)/pci_restore_state(dev) covers only 64 bytes
> of PCI header. One solution is to extend these APIs to cover up to 256
> bytes. What do you think?

Will that solve this issue?  I need to dig up my PCI spec to see if that
will still work properly on older pci devices...

thanks,

greg k-h
