Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130877AbRAWQkk>; Tue, 23 Jan 2001 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRAWQka>; Tue, 23 Jan 2001 11:40:30 -0500
Received: from purplecoder.com ([206.64.99.91]:19611 "EHLO
	gateway.purplecoder.com") by vger.kernel.org with ESMTP
	id <S130877AbRAWQkY>; Tue, 23 Jan 2001 11:40:24 -0500
Message-ID: <3A6D6A9C.98237DE4@purplecoder.com>
Date: Tue, 23 Jan 2001 06:27:24 -0500
From: Mark I Manning IV <mark4@purplecoder.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.3.95.1010123101348.1264A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > I think that your linux's partition has not been overwritten, but only the MBR
> > > of your disk, so you probably just need to reinstall lilo. Insert your
> > > installation bootdisk into your pc, then skip all the setup stuff, but the
> > > choose of the partition where you want to install and the source from where
> > > you want to install, then select just the lilo configuration (bootconfiguration
> > > I mean), complete that step and reboot your machine, lilo will'be there again.

Oopts I did this last week (fdisk /mbr doesnt do lilo any good :P)

Insert Debian boot cd, boot to install, press Alt f2  Create mountpoint,
Mount /dev/hda1, CD to that directory chroot to it, cd into /root and
./.profile (prolly not needed but can be useful sometimes)  run lilo. 
All fixed (except by the time i rebooted my motherboard had commited
suicide on me for being so stupid.  Im about to go collect the
replacement right now :)


> > I hate to tell you this, but you couldn't be more wrong.  My MBR was
> > fine.  Lilo was fine and ran fine.  The kernel even booted. The problem
> > was my ext2 partition was scrambled but good (over 4 hours trying to fix
> > it and answer all the questions that fsck threw out).  The ext2 drive
> > lost a lot of data and suddenly had windows stuff all over it (yes, just
> > like Mike, I had ttf fonts and other such things).


Argh... Window$, ya gotta love it!

 
> Nobody seems to have discovered the problem yet. It is likely some
> race produced by those who have been working on finer-ganularity
> locking.

If i boot my laptop to windows I have to do a total shutdown befire
booting back into windows or else gpm goes all crazy.  It occurs to me
that maybe OTHER things are going crazy too but are just not doing it as
loudly :)

I think it would be a good polacy to NOT boot from windows immediatly
into Linux without a shutdownn in between (a pain in the ass for sure :)

> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.

:)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
