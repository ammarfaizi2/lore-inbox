Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVJCQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVJCQcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJCQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:32:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47364 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751167AbVJCQcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:32:09 -0400
Message-ID: <43415D14.5070909@tmr.com>
Date: Mon, 03 Oct 2005 12:32:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org>
In-Reply-To: <433C2A11.9090506@utah-nac.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:
> 
> Someone needs to fix SATA drive ordering in the kernel so it matches 
> GRUBs ordering, or perhaps GRUB needs fixing. I have run into
> several situation where hd0,hd1 are in reverse order from what is 
> reported when the Intel PII drivers load from the kernel, making in
> necessary to swap the two values in the grub config.

There's more to it than that. With PATA drives I see issues with order 
as well, and they date back to the Redhat 7.x days, where the install 
chose one order for the scsi drivers and the boot chose another. With 
IDE the order in which drivers are loaded affects the drive naming.

It would be great to have some way to match drives with names, but there 
doesn't seem to be a single solution for PATA, SATA, SCSI and hotplug. 
Something like mounts using UUID of the filesystem, but for the drives.

I do use pluggable drives for backup, load modules for various 
controllers on demand, etc, so I'm aware that the most reliable 
solutions seem to involve either reduced flexibility, human intervention 
at boot, or both.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
