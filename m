Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUK1Q3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUK1Q3i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUK1Q3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:29:38 -0500
Received: from postman4.arcor-online.net ([151.189.20.158]:61851 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261517AbUK1Q0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:26:31 -0500
Message-ID: <33050.192.168.0.5.1101651929.squirrel@192.168.0.10>
In-Reply-To: <slrncqjcve.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
    <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
    <slrncqhqib.19r.psavo@varg.dyndns.org>
    <33262.192.168.0.2.1101597468.squirrel@192.168.0.10>
    <slrncqjcve.19r.psavo@varg.dyndns.org>
Date: Sun, 28 Nov 2004 15:25:29 +0100 (CET)
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: "Pasi Savolainen" <psavo@iki.fi>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(please CC me because I'm not subscribed to the list)

>> What Kernel do you use?
>
> Linux tienel 2.6.10-rc2-mm1 #1 SMP Wed Nov 17 01:19:53 EET 2004 i686
> GNU/Linux

Maybe you can give a 2.4.27'er kernel a try.

>
> Actually now that I rebooted (for DVD flashing) and started back into
> linux, after running dvdspeed it also says:
> "scsi: unknown opcode 0xb6" (which is SET_STREAMING). Code for this is
> in drivers/block/scsi_ioctl.c, and if I read it right, it can't prevent
> root from executing that command.

I have the same impression after reading drivers/block/scsi_ioctl.c . I
think you will need root permission to send this command, RW-Permission
for the device file is not enough! Did you try this as root?

But I'm wondering that scsi_ioctl.c comes into play, because It's a
ATAPI-Device. Isn't it? Do you use the scsi emulation? If so please try
without.

>
> I modified your speed-1.0 to open device O_RDWR, didn't help.
> I modified it to also dump_sense after CMD_SEND_PACKET, it's just
> duplicate packet.

No this will definitively not solve this issue. I will try to check this
in the kernel, but because I'm not a kernel developer I will CC Jens
Axboe. Maybe he can help?

Kind Regards,
 Thomas Fritzsche

