Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317413AbSFRNpq>; Tue, 18 Jun 2002 09:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFRNpp>; Tue, 18 Jun 2002 09:45:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317413AbSFRNpo>; Tue, 18 Jun 2002 09:45:44 -0400
Date: Tue, 18 Jun 2002 09:47:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roberto Nibali <ratz@drugphish.ch>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
In-Reply-To: <Pine.LNX.3.95.1020617130745.2163A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1020618093121.3483A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Richard B. Johnson wrote:

> On Mon, 17 Jun 2002, Roberto Nibali wrote:
> [SNIPPED...]
> 
> > 
> > Could you try with the latest 2.4.19preX tree and also replace the 
> > ../drivers/ieee1394 with the CVS one?
> > 
> > [1] http://linux1394.sourceforge.net/svn.html
> > 
> > Best regards,
> > Roberto Nibali, ratz
> > 
> > p.s.: You have to hurry up, since I'm not online very often the next few 
> > weeks. Of course you could also show up at OLS with the disk ;).
> 
> Okay. I did that now. However, `depmod -ae` shows some unresolved
> symbols:
> 
[SNIPPED...]



Okay. I tried the ieee1394-508.tar.gz tar-ball at home, replacing
../linux/drivers/ieee1394 directory contents of Linux version 2.4.18.

I have sbp2.o inserted by initrd. It initializes, but doesn't find
any devices. If, once the machine is up, I remove the module and then
re-install it, it finds the two devices that I have on the Firewire.

I have been able to make an e2fs file-system on the 80 Gb drive.
I can also create a large file on the drive. But... The following
will lock up... `cp /dev/sdd /dev/null`, the raw device being /dev/sdd.
The disk drive light comes on, then stays on forever. I get error
messages about "resetting the drive", and I can't get control from
any terminal. If I power off the drive, then power it back on, the
process reading from the drive, enters the 'D' state (forever), but
I can get control from another virtual terminal and reboot the machine.
There is something, probably in SCSI, that won't allow the root file-
system to be unmounted so there is a long fsck upon reboot.

Anyway. I have a setup at home that can be used to test anything.
I think the hangup comes from the raw-read length being greater
than the "payload", but I'm not sure.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

