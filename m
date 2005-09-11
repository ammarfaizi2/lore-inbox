Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVIKIv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVIKIv2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVIKIv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:51:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21144 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932442AbVIKIv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:51:27 -0400
Message-ID: <4323EFFE.2040102@pobox.com>
Date: Sun, 11 Sep 2005 04:51:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: Greg KH <greg@kroah.com>, Grant Coady <lkml@dodo.com.au>,
       "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com> <20050911031150.GA20536@kroah.com> <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com>
In-Reply-To: <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> Just ran the discovery script on 2.6.13.mm2, there's roughly 1609 
> symbols unused in pci_ids.h, another 1030 are defined throughout the 
> source tree, leaving 729 in pci_ids.h.  Total unique symbols is 1030.
> Not counted are macro defined symbols: 
> 
> PCI_DEVICE_ID_##id
> PCI_DEVICE_ID_##v##_##d
> PCI_DEVICE_ID_BROOKTREE_##chip
> PCI_VENDOR_ID_##v
> 
> from:
> 
> linux-2.6.13-mm2/drivers/video/cirrusfb.c
> linux-2.6.13-mm2/sound/oss/ymfpci.c
> linux-2.6.13-mm2/sound/pci/bt87x.c
> 
> 
> What is the goal here?  Is a comment stripped, non-duplicate pci_ids.h 
> with a reference to source site okay? 

Not sure what your last question is asking.  The current goal is to 
remove completely unused symbols from pci_ids.h, nothing more.


> Should the various distributed defines be collected to the one header 
> file and that header be include'd to those files?  It seems pci_ids.h 
> is redundant.

pci_ids.h should be the place where PCI IDs (class, vendor, device) are 
collected.

Long term, we should be able to trim a lot of device ids, since they are 
usually only used in one place.

	Jeff


