Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317687AbSFSALA>; Tue, 18 Jun 2002 20:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317688AbSFSALA>; Tue, 18 Jun 2002 20:11:00 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:30426 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S317687AbSFSAK7>; Tue, 18 Jun 2002 20:10:59 -0400
Message-ID: <3D0FC86A.2030203@drugphish.ch>
Date: Wed, 19 Jun 2002 01:55:22 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
References: <Pine.LNX.3.95.1020618093121.3483A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Okay. I tried the ieee1394-508.tar.gz tar-ball at home, replacing
> ../linux/drivers/ieee1394 directory contents of Linux version 2.4.18.
> 
> I have sbp2.o inserted by initrd. It initializes, but doesn't find
> any devices. If, once the machine is up, I remove the module and then
> re-install it, it finds the two devices that I have on the Firewire.

Ever tried to find the attached devices with rescan-scsi-bus.sh [1]?

> I have been able to make an e2fs file-system on the 80 Gb drive.
> I can also create a large file on the drive. But... The following
> will lock up... `cp /dev/sdd /dev/null`, the raw device being /dev/sdd.

Could you try with the latest 2.4.19pre tree, please? I remember some 
scsi related fixes from Alan and some other which went into that tree. 
Besides that the 2.4.18 is _really_ old with regard to certain subsystems.

> The disk drive light comes on, then stays on forever. I get error
> messages about "resetting the drive", and I can't get control from

I reckon some sbp2 problem together with the currect scsi interface. If 
you can, you should try it with a 2.4.19pre tree even if it is simply to 
show people that something is still heavily broken and to have a decent 
starting point for debugging purposes.

> any terminal. If I power off the drive, then power it back on, the
> process reading from the drive, enters the 'D' state (forever), but
> I can get control from another virtual terminal and reboot the machine.
> There is something, probably in SCSI, that won't allow the root file-
> system to be unmounted so there is a long fsck upon reboot.

Always enable SysRq for such test cases, so you can at least emergency 
sync and remount,ro.

> Anyway. I have a setup at home that can be used to test anything.
> I think the hangup comes from the raw-read length being greater
> than the "payload", but I'm not sure.

I don't know either, we might also need an ieee1394 specialist to solve 
that problem, but only after you tested it with a more recent kernel 
tree ;).

[1] http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

