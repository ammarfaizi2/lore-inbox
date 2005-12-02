Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVLBVqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVLBVqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLBVqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:46:00 -0500
Received: from fmr21.intel.com ([143.183.121.13]:53698 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750806AbVLBVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:45:59 -0500
Date: Fri, 2 Dec 2005 13:45:50 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Matthew Wilcox <matthew@wil.cx>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [2.6.15-rc4] oops in acpiphp
Message-ID: <20051202134549.A22130@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <4390B646.60709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4390B646.60709@pobox.com>; from jgarzik@pobox.com on Fri, Dec 02, 2005 at 04:01:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 04:01:58PM -0500, Jeff Garzik wrote:
> 
> Booting with acpiphp on this dual core, dual package (2x2) box causes an 
> oops.
> 
The oops is actually in pciehp, not acpiphp. It's been around
for a while, I saw a similar report dating back to April. It
triggers only if pciehp (CONFIG_HOTPLUG_PCI_PCIE) is marked as
"y" in .config. Making it a module will make it go away.  I
looked into this very briefly last week and it looked like some
race related to the pcie core registering the pciehp driver.
I'll be working on making some pcie improvements soon, and will
look into this as a part of that.

Rajesh

