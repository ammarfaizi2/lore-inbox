Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276813AbRJKT5k>; Thu, 11 Oct 2001 15:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276802AbRJKT5V>; Thu, 11 Oct 2001 15:57:21 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:1634 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276803AbRJKT5O>; Thu, 11 Oct 2001 15:57:14 -0400
Date: Thu, 11 Oct 2001 14:57:40 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unconditional include of <linux/module.h> in aic7xxx driver
In-Reply-To: <200110111940.f9BJe8Y97938@aslan.scsiguy.com>
Message-ID: <Pine.LNX.3.96.1011011145407.5934B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Justin T. Gibbs wrote:
> Can anyone comment on why the include of <linux/module.h> is now
> unconditional in the aic7xxx driver?  Assuming MODULE_LICENSE is
> properly qualified by an #ifdef MODULE, the driver appears to compile
> and function correctly without this include.  Are MODULE attributes
> (MODULE_VERSION/AUTHOR/DESCRIPTION/etc.) now supposed to be included in
> static configurations?

linux/module.h has been set up, for a long while now, to support
building statically into the kernel as well as building as a module.

Linux kernel rule #812: ifdefs are ugly.  Strive to make your code
ifdef free by creating includes/defines/inline functions that exist
even when your selected ifdef is undefined.  module.h follows that
rule.

Similarly you can include linux/pci.h even if !CONFIG_PCI.

	Jeff




