Return-Path: <linux-kernel-owner+w=401wt.eu-S1751903AbXAVDdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbXAVDdw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 22:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXAVDdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 22:33:52 -0500
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:58815 "EHLO
	imf20aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751897AbXAVDdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 22:33:51 -0500
Message-ID: <45B43093.6060500@bellsouth.net>
Date: Sun, 21 Jan 2007 21:33:39 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com, hch@infradead.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net, kronos.it@gmail.com
Subject: Re: [PATCH 4/4] atl1: Ancillary C files for Attansic L1 driver
References: <20070121210737.GE2702@osprey.hogchain.net> <20070121183151.4be61ebf.randy.dunlap@oracle.com>
In-Reply-To: <20070121183151.4be61ebf.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Sun, 21 Jan 2007 15:07:37 -0600 Jay Cliburn wrote:
[snip]

>> +	value = ioread16(hw->hw_addr + REG_PCIE_CAP_LIST);
>> +	return ((value & 0xFF00) == 0x6C00) ? 0 : 1;
> 
> Are there defines or enums for these?
> Fewer magic numbers would be nice/helpful/readable.
[snip]
>> +	s32 ret;
>> +	ret = atl1_write_phy_reg(hw, 29, 0x0029);
> 
> Fewer magic numbers?

Unfortunately, we don't have a spec.  This is how the vendor coded it.

[snip]
>> +
>> +int enable_msi;
>> +module_param(enable_msi, int, 0444);
>> +MODULE_PARM_DESC(enable_msi, "Enable PCI MSI");
> 
> Hm, I thought that we didn't want individual drivers having MSI config
> options...

Luca?  This one was yours IIRC.  Care to chime in?

Randy, thank you for the review.

Jay
