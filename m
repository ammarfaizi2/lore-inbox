Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276729AbRJVQxi>; Mon, 22 Oct 2001 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277072AbRJVQx2>; Mon, 22 Oct 2001 12:53:28 -0400
Received: from mail.myrio.com ([63.109.146.2]:2292 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S276729AbRJVQxO>;
	Mon, 22 Oct 2001 12:53:14 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CA7B@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Jens Axboe'" <axboe@suse.de>, Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: "'Peter Moscatt'" <pmoscatt@yahoo.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Can't see IDE CDR-W after compile ?
Date: Mon, 22 Oct 2001 09:53:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the cdparanoia ripper.  Here's a quote from the 
cdparanoia FAQ (cdparanoia III - alpha 9.8):

  "Note that the native ATAPI driver is supported, but that IDE-SCSI
  emulation works better with ATAPI drives. This is an issue of control;
  the emulation interface gives cdparanoia complete control over the
  drive whereas the native ATAPI driver insists on hiding the device
  under an abstraction layer with poor error handling capabilities. Note
  also that a number of ATAPI drives that do not work at all with the
  ATAPI driver (error 006: Could not read audio) *will* work with
  IDE-SCSI emulation."

That, (and the actual performance difference I experienced)
is about all I know about the reasons behind this problem.    

I also used to read the cdrecord mailing list, and IIRC, Jorg 
Schilling (author of cdrecord, general expert on CD ROM stuff)
is not too impressed with the default Linux driver.  I don't 
remember the details... 

I do hope this gets sorted out properly in 2.5.  Perhaps all 
that's needed is better hints for people as they configure the 
kernel, or an "auto-configure" that actually works for the 90% 
of users who aren't experts on this stuff.

With the 2.5 makefile rewrites this may be easy to do.

Or perhaps the IDE-CD driver should be deprecated, kind of like 
the old disk-only IDE driver?

Torrey


Jens Axboe wrote:
 
> On Fri, Oct 19 2001, Torrey Hoffman wrote:
> > The other driver is the IDE-SCSI emulation layer.  This 
> works better for
> > some things, including ripping music CD's.  And, as you 
> have discovered, it
> > is a requirement for CDR's.  For example, using the 
> IDE-SCSI driver I can
> > rip audio with my Toshiba DVD drive at 10x speed, but with 
> the "normal IDE"
> > driver it could not even go at 1x speed.
> 
> THat is funny, since the code for ripping audio is in the 
> generic CDROM
> layer and this shared by both ide-cd and sr. Exactly the same cdb is
> sent down regardless of your setup.
> 
> So maybe your ripping program is accessing the CDROM differently
> depending on the bus type (eg using sg for sr, maybe?).
> 
> -- 
> Jens Axboe
> 
