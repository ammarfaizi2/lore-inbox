Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319185AbSIDPlg>; Wed, 4 Sep 2002 11:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319184AbSIDPlg>; Wed, 4 Sep 2002 11:41:36 -0400
Received: from rom.cscaper.com ([216.19.195.129]:18347 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S319183AbSIDPle>;
	Wed, 4 Sep 2002 11:41:34 -0400
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Content-Transfer-Encoding: 7BIT
To: Benjamin LaHaise <bcrl@redhat.com>
From: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 4 Sep 2002 08:48 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020904154134Z319183-685+42704@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002 10:55:37 -0400, Benjamin LaHaise <bcrl@redhat.com> wrote:
> Have you tried commenting out the hdparm commands in the initscripts and 
> booted with a kernel that enables DMA (instead of using hdparm -d1)?
> 
> 		-ben

I can give that a whirl, but it bothers me the way it currently
"works":

* Performance is terrible
* booting with noapic makes no difference
* Performance seems to indicate some kind of difficulties in
  the kernel, perhaps connected to interrupt handling

I have another RH 7.3 box sitting next to the new one, which has
a Sony DVD-ROM.  I just enabled DMA with hdparm and it works very
well.  That is not what happens on the other (troublesome) machine.

So I am wondering:

* Kernel interrupt handling problem (should there be ERR if
  apic is enabled?  which it is)
* IRQ problem?  I haven't tried changing around IRQs.
* IDE controller problem?  Probably not, because the drive seems
  to work the same on the Highpoint controller.
* Problem with this specific drive?  Perhaps.  I've never used it
  before--the last "combo" drive I used was SCSI.  I bought this
  one because it was the same brand as the SCSI drive I used before,
  and as an IDE device it would be about $500 cheaper (no SCSI
  card needed).  I will check to see if a firmware download is
  available.
* Some other m/b problem?  Perhaps, but I've not tried this drive
  in another box.  I am inclined to try that next.

I am also inclined to try the Sony DVD-ROM in the new box to see
if it exhibits the same behavior.

What is the "combo drive" used by the iMac et al.?

  -joseph

> 
> On Tue, Sep 03, 2002 at 11:00:00PM -0700, Joseph N. Hall wrote:
> > Yes, DMA makes the drive completely non functional and eventually
> > hangs the machine after some amount of attempted use.  This is
> > regardless of when DMA is enabled, whether via the standard
> > RedHat "harddiskn" mechanism or manually with hdparm.
> > 
> >   -joseph
> > 
> > On Tue, 3 Sep 2002 22:37:57 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> > > 
> > > Have you tried enabling DMA on the drive?
> > > 
> > > Matt
> > > 
> > > On Tue, Sep 03, 2002 at 06:45:00PM -0700, Joseph N. Hall wrote:
> > > > Dear Kernel Folks,
> > > >
> > > > I am trying to determine the cause of the poor performance of a
> > > > an IDE DVD device on my new machine.  I have an IDE Panasonic DF-210-type
> > > > DVD-RAM/R/ROM in a new machine with Soyo KT333 motherboard.  It
> > > > transfers data slowly (below DVD speed), consumes large amounts of
> > > > system time, and slows down the user interface and even system
> > > > clock (which can run as slow as 1/4 speed while the drive is
> > > > going).
> > > >
> > > > The interrupt ERR count below seems to be mostly related to use
> > > > of the DVD drive.
> > > >
> > > > Maybe it's something simple.  If not, I'll be glad to do further
> > > > work to help diagnose the problem.
> 
> -- 
> "You will be reincarnated as a toad; and you will be much happier."
> 

