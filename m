Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUJNS33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUJNS33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUJNS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:29:09 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62472 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266838AbUJNRir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:38:47 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: TimO <hairballmt@mcn.net>, "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Linux-2.6.8 Hates DOS partitions
Date: Thu, 14 Oct 2004 20:38:05 +0300
User-Agent: KMail/1.5.4
Cc: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com> <20041013213519.GA3379@pclin040.win.tue.nl> <416D15BB.9020002@mcn.net>
In-Reply-To: <416D15BB.9020002@mcn.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410142038.05141.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Having experienced a similar but not exact situation; I'm going to
> suggest that your BIOS is to blame.  (AMI?)  If you hadn't already
> done a MBR restore; I would have suggested for you to remove the ATA
> disk to see if you could once again boot to DOS.  You might remove
> it anyway to see if a boot from DOS floppy will again allow you to
> 'see' the DOS D:\ partition.
>    My situation actually arose from a motherboard swap; AOpen/Award/K7
> --> GByte/AMI/AthlonXP.  Linux booted fine and ran for 2 weeks with-
> out problem.  I could even see/read all the DOS/VFAT partitions just
> fine.  It wasn't until I went to boot Win98 that I noticed the prob-
> lem(Invalid system disk).  Booting from a floppy showed a "Drive not
> ready" for C:(hda2); D:(hdc1) looked fine but became corrupt as soon
> as I wrote to it, and E:(hdc2) didn't even show.  I made sure to
> transfer the IDE settings exactly but no amount of war would allow
> both systems to boot from the same hard drive(ATA)on the GByte/AMI
> board and I eventually managed to trash the Linux / as well.  Another
> motherboard with an Award/Pheonix Bios, a little restoration and all
> is once again right with the(my) world.
> 
> oh, YMMV   :)

Hehe. I have a HP box here which insists that there are 240 heads
on large IDE drives, not typical 255. This wreaks havoc when I
try to swap disks between this box and some saner one. Most OSes
do not boot after swap.

Of special note is total brain damage of NT4 bootloader.
Boot sector contains plain simple divide overflow bug and
even when fixed, the same bug is apparently present in NTLDR.
Result: cannot boot if NTLDR or kernel file is farther than 2Gb
from disk beginning.
--
vda

