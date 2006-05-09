Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWEIXAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWEIXAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWEIXAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:00:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:41162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750881AbWEIXAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:00:33 -0400
Date: Tue, 9 May 2006 15:58:55 -0700
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI Bus Parity Status-broken hardware attribute, EDAC foundation
Message-ID: <20060509225855.GA14075@kroah.com>
References: <20060509000609.62160.qmail@web50101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509000609.62160.qmail@web50101.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 05:06:09PM -0700, Doug Thompson wrote:
> 
> PATCH against the 2.6.17-rc3 release.
> 
> Currently, the EDAC (error detection and correction) modules that are in the kernel
> contain some features that need to be moved. After some good feedback on the PCI
> Parity detection code and interface
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0603.1/0897.html) this patch ADDs an
> new attribute to the pci_dev structure: Namely the 'broken_parity_status' bit. 
> 
> When set this indicates that the respective hardware generates false positives of
> Parity errors.
> 
> The EDAC "blacklist" solution was inferior and will be removed in a future patch.
> 
> Also in this patch is a PCI quirk.c entry for an Infiniband PCI-X card which
> generates false positive parity errors.
> 
> I am requesting comments on this AND on the possibility of a exposing this
> 'broken_parity_status' bit to userland via the PCI device sysfs directory for
> devices. This access would allow for enabling of this feature on new devices and for
> old devices that have their drivers updated. (SLES 9 SP3 did this on an ATI
> motherboard video device). There is a need to update such a PCI attribute between
> kernel releases. 
> 
> This patch just adds a storage place for the attribute and a quirk entry for a known
> bad PCI device. PCI Parity reaper/harvestor operations are in EDAC itself and will
> be refactored to use this PCI attribute instead of its own mechanisms (which are
> currently disabled) in the future.

I have no objection to this patch and have added it to my tree.  If you
wish to export this information through sysfs, that's also ok.  Feel
free to send a follow-on patch that does that.

thanks,

greg k-h
