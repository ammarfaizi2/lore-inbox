Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbTBXUmk>; Mon, 24 Feb 2003 15:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbTBXUmj>; Mon, 24 Feb 2003 15:42:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15375 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267492AbTBXUmj>;
	Mon, 24 Feb 2003 15:42:39 -0500
Date: Mon, 24 Feb 2003 12:44:58 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Scott Murray <scottm@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: CPCI stopped building
Message-ID: <20030224204457.GA3463@kroah.com>
References: <1046118108.2099.2.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046118108.2099.2.camel@vmhack>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 12:21:44PM -0800, Rusty Lynch wrote:
> Attempting to turn on cpci support on the latest kernel breaks the build.
> The problem is that pci_is_dev_in_use() has been removed, but 
> cpci_hotplug_pci.c still calls the non-existant function in 
> unconfigure_visit_pci_dev_phase1().
> 
> It looks like pci_dev_driver(dev) can be used in replacement (since that is
> what driver/pci/hotplug.c is now doing in pci_remove_device_safe(), but 
> I haven't taken the time to really understand what is happening.

Yes, Christoph sent me this patch a few days ago, and I noticed it just
got into the the tree.  I'm makeing a lot of pci hotplug core and driver
cleanups right now, and will handle this one too.

thanks,

greg k-h
