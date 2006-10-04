Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWJDFKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWJDFKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 01:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWJDFKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 01:10:23 -0400
Received: from mx1.suse.de ([195.135.220.2]:5248 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030190AbWJDFKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 01:10:21 -0400
Date: Tue, 3 Oct 2006 22:10:23 -0700
From: Greg KH <greg@kroah.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [-mm patch] missing class_dev to dev conversions
Message-ID: <20061004051023.GA15801@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org> <20060919173902.GB751@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919173902.GB751@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 05:39:03PM +0000, Frederik Deweerdt wrote:
> On Tue, Sep 19, 2006 at 01:28:48AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/
> > 
> Greg,
> 
> There are some net drivers that didn't get their class_device converted to
> device, as introduced by the gregkh-driver-network-class_device-to-device
> patch.
> The arm defconfig build thus fails with the following message:
> 
> drivers/net/smc91x.c: In function `smc_ethtool_getdrvinfo':
> drivers/net/smc91x.c:1713: error: structure has no member named
> `class_dev'
> make[2]: *** [drivers/net/smc91x.o] Error 1
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> 
> The following patch fixes at91_ether.c, etherh.c, smc911x.c and smc91x.c.

Thanks a lot, I've merged this in with the original patch that caused
this problem.

greg k-h
