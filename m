Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbULQXvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbULQXvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbULQXvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:51:07 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39904 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262234AbULQXvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:51:01 -0500
Date: Fri, 17 Dec 2004 15:43:31 -0800
From: Greg KH <greg@kroah.com>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] PCI early fixup missing bits
Message-ID: <20041217234331.GB24350@kroah.com>
References: <Pine.LNX.4.61.0412152359360.14855@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412152359360.14855@perivale.mips.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 12:25:42AM +0000, Maciej W. Rozycki wrote:
> Hello,
> 
>  A few bits seem to be missing for PCI early fixup to work -- the 
> pci_fixup_device() helper ignores fixups of the pci_fixup_early type.  
> Also the local class variable needs to be refreshed after performing the 
> fixups for they can change dev->class.
> 
>  The patch should be obvious.  Checked against 2.6.10-rc3-bk9.  Please 
> apply.

Doh, nice fix.  I've applied it to my trees, will show up in the next
-mm.

thanks,

greg k-h
