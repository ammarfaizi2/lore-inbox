Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281652AbRKUHq6>; Wed, 21 Nov 2001 02:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281653AbRKUHqs>; Wed, 21 Nov 2001 02:46:48 -0500
Received: from law2-oe42.hotmail.com ([216.32.180.39]:48146 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S281652AbRKUHqh>;
	Wed, 21 Nov 2001 02:46:37 -0500
X-Originating-IP: [213.82.66.51]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <LAW2-OE70z82buW5RNB000007e5@hotmail.com> <20011119104411.U11826@suse.de>
Subject: Re: Kernel Panic: too few segs for DMA mapping increase AHC_NSEG
Date: Wed, 21 Nov 2001 08:46:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <LAW2-OE42edZhotjCjW000013a3@hotmail.com>
X-OriginalArrivalTime: 21 Nov 2001 07:46:31.0563 (UTC) FILETIME=[A2BA4DB0:01C17260]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...not good news.
Same behaviour: without hi mem support all right. With hi mem support
(4GB) I get this error on console, after a kernel dump:

SCSI1:0:0:0 attempt to queue an abort message
SCSI1:0:0:0 command not found
aic7xxx_abort returns 0x2002

Then the system freeze completely, so I press the reset button.
At the startup INIT calls fsck and when the checking is at about 55% it
displays this message:

SCSI1:A:0:0 locking max tag count at 128

then the following startup procedure goes well.
I want to tell you that with this kernel (hi mem support enabled), all
is working perfectly (I can compile a new working kernel, for example).
X Window (4.1) plus kde is working well.
Only when I mount a vfat filesystem type and then I try to copy a file
to the root partition I get this error.
Another point: I usually build only mass storage driver in the kernel
(Adaptec AHA 39160 bios rev 3.10). I build as modules all other HW (nic,
sound, USB), however only the SB PCI512 is loaded in this situation. I
haven't any IDE device just one SCSI HD (IBM DDYS-T18350N firmware rev
S93E) and one Plextor SCSI cdrom (UltraPlex 40max PX-40TS firmware
revision 1.04).

----- Original Message -----
From: "Jens Axboe" <axboe@suse.de>
To: "Marco Berizzi" <pupilla@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 19, 2001 10:44 AM
Subject: Re: Kernel Panic: too few segs for DMA mapping increase
AHC_NSEG


> On Mon, Nov 19 2001, Marco Berizzi wrote:
> > Hi everybody.
> >
> > I have just upgraded my PC from 768MB RAM to 1GB.
> > I have recompiled the kernel (2.4.14) for hi mem support (4GB).
> >
> > Now it's appening a very strange behaviour.
> > I have several file system on the same disk (vfat file system). I
have
> > compiled vfat driver as a module. So before try to mount I must
issue a
> > 'modprobe vfat'. I'm using Slackware 8.0. modutils version is 2.4.6
> >
> > Then if I try to copy a file from that filesystem to the root
filesystem
> > I get this error:
> >
> > Kernel panic: too few segs for DMA mappings increase AHC_NSEG
>
> Aha! Finally someone that can provoke this easily. Could you please
> apply attached patch and reproduce? Thanks.
>
> --
> Jens Axboe
>
>
