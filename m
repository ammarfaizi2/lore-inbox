Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270923AbRHNWyH>; Tue, 14 Aug 2001 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270922AbRHNWx5>; Tue, 14 Aug 2001 18:53:57 -0400
Received: from smtp1.one.net ([216.23.22.220]:37126 "HELO us.net")
	by vger.kernel.org with SMTP id <S270917AbRHNWxq>;
	Tue, 14 Aug 2001 18:53:46 -0400
Message-ID: <06db01c12514$23afc520$b214860a@amdmb>
From: "Ryan Shrout" <linux-kernel@amdmb.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10108142225230.12794-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Slow SCSI Disk Access on AMI Elite 1600 controller
Date: Tue, 14 Aug 2001 18:54:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Timing buffered disk reads:  64 MB in 13.92 seconds =  4.60 MB/sec
> ...
> > 4 - 15K RPM Cheetah SCSI HDDs
>
> each disks will sustain 30-50 MB/s, so yeah, that's kind of low.
>
I changed the drives settings from Write-Through to Write-Back and it went
to 22.5 MB/sec

> > AMI Elite 1600 SCSI RAID controller with 64 MB SDRAM
>
> I wish people would start with relatively simple controllers,
> and only move to fancy ones if they know they need them,
> and can prove that the fancy controller works better.
>
> so for instance, these disks on any PCI ultra2 controller
> will easily sustain 100 MB/s.  SW raid5 might slow things down
> if you had, say, a single celeron (260 MB's dram bandwidth),
> but certainly wouldn't effect a dual athlon with ddr.
>
I am using them in a RAID 0+1 configuration, so this kind of card was
needed.  Besides, it was a gift (Free!) and I couldn't pass that up.

> > Red Hat Linux 7.2
>
> do you mean with RH's kernel!?!
>
No, actually, its 2.4.6-2smp custom compiled.

> > So, I then started trying to figure out to raise the buffered disk read
> > speed.
>
> do you have a simple, non-raid ultra2 controller around?
>
> > My only solution I came across -- find out if the SCSI
> > controllers/drives were in asynchronous mode and if they are, change
them to
> > synchronous mode.
>
> unless something dramatic is happening, the disks will stay in the
> same mode as they're detected at driver-init time, which should be
> right before your eyes in /var/log/dmesg.  well, at least for a non-fancy
> controller.  for a gold-plated controller like you have, you need
> to find some way to query the controller, perhaps a serial port,
> or some too provided by AMI.  basically that's a non-linux question,
> since the controller has its own little OS that you need to interact with.
>
> > Now, how can I tell what mode my SCSI disks are in and how can I change
it
> > to synchronous if it isn't set that way already?
>
> unless your scsi cabling is utterly botched, they'll be synchronous.
>
Okay, that helps me so I stop looking for that setting!  :)

Hopefully, going from 4.5 -> 22.5 MB/sec will be enough to temporarily stop
my mysqld crashing.

Thanks!

Ryan Shrout

