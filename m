Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFLK1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFLK1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVFLK1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:27:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25100 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261267AbVFLK12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:27:28 -0400
Date: Sun, 12 Jun 2005 12:27:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612102726.GA8470@alpha.home.local>
References: <20050612071213.GG28759@alpha.home.local> <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 03:15:14AM -0700, subbie subbie wrote:
> Willy,
>  
>  This is for a one-time use option, when the the admin
> is having a hard time finding the root partition, let
> alone the device NAME to boot the system ... proc is
> not even mounted at that point yet.

There are two alternatives at boot :

  - either you know the root device, and everything is
    OK (mount /proc; cat /proc/partitions)

  - you don't know the root device, so the kernel will
    panic at boot because it cannot find the root device.
    In this case, you have the partition list still on
    the screen as it's among the latest things in the
    boot order. And if your kernel reboots upon panic,
    just boot it with panic=30 so get 30 seconds to read
    the partition table.

> I can try booting ten times finding the correct scsi
> device and partition number, but that's hairy
> especially in situations where kernel config and BIOS
> settings affect device detection.

I too know that it's sometimes hard to read SCSI devices
names on screen during the boot, but I'm not sure that
introducing a delay will be more useful than the full
pause provided by the panic. I may be wrong, though.
 
> This is not for slowing everything down, let's say
> just until root is mounted from then on, as you say,
> dmesg and the system logs are available.

OK.

Regards,
willy

