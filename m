Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVETVue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVETVue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVETVue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:50:34 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:29279 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261388AbVETVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:50:28 -0400
Message-ID: <428E5BA1.8040301@tls.msk.ru>
Date: Sat, 21 May 2005 01:50:25 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Miller <amiller@gravity.phys.uwm.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: software RAID
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Miller wrote:
> Hi,
>   We're looking to set up either software RAID 1 or RAID 10 using 2 SATA 
> disks.  If a disk in drive A has a bad sector, can it be setup so that 
> the array will read the sector from drive B and then have it rewrite the 
> bad sector on drive A?  Please CC me in the response.

Adam,

There's no such functionality in linux software raid exists now.
Instead, as it is implemented now, the whole drive is kicked off
the array in case of *any* error in I/O path.  There are patches
by Peter T. Breuer for 2.4 kernel for raid1, named "robust read",
which does just that, but the patches aren't accepted in mainline,
and in 2.6, the subsystem is too different.  Maybe in some future...

And BTW, there's no reason to set up RAID10 array on top of 2 drives ;)

/mjt
