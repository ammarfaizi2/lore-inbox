Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUE2SMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUE2SMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUE2SMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:12:03 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:20395 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S263828AbUE2SLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:11:45 -0400
Message-ID: <40B8D24A.4080703@xfs.org>
Date: Sat, 29 May 2004 13:11:22 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vincent van de Camp <vncnt@vzavenue.net>
CC: linux-kernel@vger.kernel.org, XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
References: <40B89FE7.5090203@vzavenue.net>
In-Reply-To: <40B89FE7.5090203@vzavenue.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent van de Camp wrote:
> I run a gentoo system, and after updating python 2.3.3-r1, the emerge 
> -DU that was running segfaulted. I had to hard reset the computer and 
> since then the main (and only) partition refuses to mount.
> 
> The motherboard is an A7N8X Deluxe, with a Western Digital 36GB SATA 
> Raptor drive. Kernel version was 2.6.5. The message:
> 
> XFS mounting filesystem ide2(33,1)
> Starting XFS recovery on filesystem: ide2(33,1) (dev: ide2(33,1))
> XFS assertion failed: *(uint *)dp == XFS_TRANS_HEADER_MAGIC, file: 
> xfs_log_recover.c, line: 1424
> kernel BUG at debug.c:55!
> invalid operand: 0000
> ohci1394 ieee1394 3c59x floppy serial isa-pnp usb-storage hid usb-ohci 
> ehci-hcd usbcore
> CPU:    0
> EIP:    0010:[<c02c4f96>]    Not tainted
> EFLAGS: 00010282
> eax: 00000061   ebx: 00000001   ecx: 00000000   edx: f773c000
> esi: f6d79780   edi: 00000034   ebp: 00000008   esp: f6de7b68
> ds: 0018   es: 0018   ss: 0018
> Process mount (pid: 2689, stackpage=f6de7000)
> Stack: c04180e0 c0414be0 c03ed901 00000590 c029d43e c0414be0 c03ed901 
> 00000590
>        f7340720 f7c36260 f6d79774 00000008 c029f6e5 f7340720 f6d79780 
> 00000034
>        f6d79780 00000020 f6d7a200 00000001 f7341200 f6de7c24 f73d1070 
> 00000011
> Call Trace: [<c029d43e>]  [<c029f6e5>]  [<c02a04d5>]  [<c0308912>] 
> [<c02a0dd4>]  [<c02a0e96>]  [<c02a10a4>]  [<c029735b>]  [<c02a523f>] 
> [<c02b995a>]  [<c02a4782>]  [<c02b953c>]  [<c0294df0>]  [<c02ae54c>] 
> [<c02c4151>]  [<c02c3f80>]  [<c01daea5>]  [<c01db87d>]  [<c01eaedb>] 
> [<c01dbafb>]  [<c01ebcf1>]  [<c01ebf68>]  [<c01ebdef>]  [<c01ec2c8>] 
> [<c01aaab3>]
> Code: 0f 0b 37 00 6f f1 3e c0 83 c4 10 c3 89 f6 8b 0d e0 95 10 c0
> 
> If there's a separate xfs list, I'll be happy to post it there too.
> 
> Thanks,
> Vincent

Added the XFS mailing list to the cc list....

You have turned on XFS debug, which is really a developer option. It
looks like you have a corrupt journal though. A non debug kernel may
still refuse to mount it and you would need to run xfs_repair from
a rescue disk in that case.

Steve
