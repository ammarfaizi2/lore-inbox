Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWBGPCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWBGPCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWBGPCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:02:13 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34697 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965116AbWBGPCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:02:12 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139312330.18391.14.camel@localhost.localdomain>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
	 <1139310335.18391.2.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
	 <1139312330.18391.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 15:04:13 +0000
Message-Id: <1139324653.18391.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 11:38 +0000, Alan Cox wrote:
> Ok there is a resource handling bug somewhere in the generic case that
> needs fixing I have yet to find. Also some mishandling of devices with
> bmdma not enabled which kills Qemu. I've just been fixing the latter and
> also adding CFA awareness. I'll take a look at the resource code next.

I've put up a -ide2 patch at

http://zeniv.linux.org.uk/~alan/IDE

This
	- cleans up old pci_module_init users
	- Should fix the crashes people saw when bmdma is zero
	- Adds the netcell driver (nothing clever in it yet as the chip
	  does all the thinking)
	- Fixed probe ordering
	- Added resource management to the pata_legacy driver
	- Other minor oddments (Allow CFA etc)

Should help fix some of the crashes reported on startup.

I did however forget to change the default ATA_ENABLE_PATA setting

Alan

