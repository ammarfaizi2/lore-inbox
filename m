Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130869AbRAWP0F>; Tue, 23 Jan 2001 10:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131238AbRAWPZz>; Tue, 23 Jan 2001 10:25:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130869AbRAWPZf>; Tue, 23 Jan 2001 10:25:35 -0500
Date: Tue, 23 Jan 2001 10:25:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Trever L. Adams" <trever_Adams@bigfoot.com>
cc: Patrizio Bruno <patrizio@dada.it>,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <3A6D9BE6.8070400@bigfoot.com>
Message-ID: <Pine.LNX.3.95.1010123101348.1264A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Trever L. Adams wrote:

> Patrizio Bruno wrote:
> 
> > I think that your linux's partition has not been overwritten, but only the MBR
> > of your disk, so you probably just need to reinstall lilo. Insert your
> > installation bootdisk into your pc, then skip all the setup stuff, but the
> > choose of the partition where you want to install and the source from where
> > you want to install, then select just the lilo configuration (bootconfiguration
> > I mean), complete that step and reboot your machine, lilo will'be there again.
> > 
> > P.
> > 
> > On Tue, 23 Jan 2001, Trever L. Adams wrote:
> 
> I hate to tell you this, but you couldn't be more wrong.  My MBR was 
> fine.  Lilo was fine and ran fine.  The kernel even booted. The problem 
> was my ext2 partition was scrambled but good (over 4 hours trying to fix 
> it and answer all the questions that fsck threw out).  The ext2 drive 
> lost a lot of data and suddenly had windows stuff all over it (yes, just 
> like Mike, I had ttf fonts and other such things).
> 
> Trever
> 

Yes, last week I had a similar problem with the 2.4.0 (release) version.
I use only SCSI (Buslogic on this machine). The root file-system
was overwritten with a repeated directory-name+junk. This was reported
to the linux-kernel list. This problem occurred during my automated
nightly tape backup. Since the backup operation is mostly a read
operation, I suggested that the corruption occurred while updating
ATIME.

The file system was not recoverable. I keep a week's worth of tapes
before they get overwritten so I only lost a day's work and I really
didn't do much on that day so I really lost nothing but my temper ;^;).

Nobody seems to have discovered the problem yet. It is likely some
race produced by those who have been working on finer-ganularity
locking.

I'm still using the same kernel, although my 'tar' script now
does --atime-preserve. I don't know if this really works as
expected though...


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
