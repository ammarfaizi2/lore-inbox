Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbULGQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbULGQhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULGQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:37:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:47785 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261855AbULGQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:37:14 -0500
Subject: Re: Rereading disk geometry without reboot
From: Mark Haverkamp <markh@osdl.org>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041206202356.GA5866@thumper2>
References: <20041206202356.GA5866@thumper2>
Content-Type: text/plain
Date: Tue, 07 Dec 2004 08:37:07 -0800
Message-Id: <1102437427.23136.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 14:23 -0600, Andy wrote:
> I am using linux kernel 2.6.9 on a san.  I have file systems on
> non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
> the XFS file system those disks.  What I would like to avoid rebooting or
> even unmounting the filesystem if possible.
> 
> Is there any way to get the kernel to re-read the disk geometry and change
> the information it holds without rebooting or reloading the module (which is
> as bad as a reboot in my case)?

You can re-scan a scsi device via sysfs.  You can, for example,

echo 1 > /sys/block/sdc/device/rescan

to rescan that device.

Mark.
 

> 
> Thanks,
> 
> Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Haverkamp <markh@osdl.org>

