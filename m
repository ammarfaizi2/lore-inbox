Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVJCXV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVJCXV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVJCXV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:21:58 -0400
Received: from [67.137.28.189] ([67.137.28.189]:20610 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932374AbVJCXV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:21:57 -0400
Message-ID: <4341A8A7.9060607@utah-nac.org>
Date: Mon, 03 Oct 2005 15:54:47 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org> <43415D14.5070909@tmr.com>
In-Reply-To: <43415D14.5070909@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> jmerkey wrote:
>
>>
>> Someone needs to fix SATA drive ordering in the kernel so it matches 
>> GRUBs ordering, or perhaps GRUB needs fixing. I have run into
>> several situation where hd0,hd1 are in reverse order from what is 
>> reported when the Intel PII drivers load from the kernel, making in
>> necessary to swap the two values in the grub config.
>
>
> There's more to it than that. With PATA drives I see issues with order 
> as well, and they date back to the Redhat 7.x days, where the install 
> chose one order for the scsi drivers and the boot chose another. With 
> IDE the order in which drivers are loaded affects the drive naming.
>
> It would be great to have some way to match drives with names, but 
> there doesn't seem to be a single solution for PATA, SATA, SCSI and 
> hotplug. Something like mounts using UUID of the filesystem, but for 
> the drives.
>
> I do use pluggable drives for backup, load modules for various 
> controllers on demand, etc, so I'm aware that the most reliable 
> solutions seem to involve either reduced flexibility, human 
> intervention at boot, or both.

Have the IDE and SATA driver layer check the BIOS ordering and preserve 
it during registration of the IDE and SATA devices for boot.

Jeff
