Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315490AbSEHDDU>; Tue, 7 May 2002 23:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSEHDDT>; Tue, 7 May 2002 23:03:19 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:63621 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315490AbSEHDDS>; Tue, 7 May 2002 23:03:18 -0400
Date: Tue, 7 May 2002 23:03:19 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508030319.GA22933@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com> <20020507162010.GA13032@ravel.coda.cs.cmu.edu> <3CD7F212.5090608@evision-ventures.com> <20020507213603.GA18535@ravel.coda.cs.cmu.edu> <20020508002513.GA26150@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 02:25:13AM +0200, Guest section DW wrote:
> On Tue, May 07, 2002 at 05:36:03PM -0400, Jan Harkes wrote:
> > On Tue, May 07, 2002 at 05:26:10PM +0200, Martin Dalecki wrote:
> > > Uz.ytkownik Jan Harkes napisa?:
> > > >I'm still hoping a patch will show up that will allow me to regain
> > > >access to my compactflash cards and IBM microdrive disks. The code
> > > >currently doesn't rescan for new drives when a card has been inserted,
> > > >although it still seems to have all the necessary logic.
> > > 
> > > Yes I'm fully aware of this, but the whole initialization
> > > is currently much in flux and I will return to this issue back
> > > if I think that things are in shape there. OK?
> > 
> > I thought so, you already indicated so around the time that it broke.
> > There is still a 2.4 kernel when I really need to get to the data.
> 
> I usually do
> 
> 	blockdev --rereadpt /dev/sde
> 
> or so. That still works for me with 2.5.13.

For SCSI devices probably, but I get "/dev/hde: No such device" (ENODEV)
when a CF card is inserted and recognized.

    (dmesg)
    hde: SanDisk SDCFB-32, ATA DISK drive
    ide2 at 0x100-0x107,0x10e on irq 3
    ide_cs: hde: Vcc = 3.3, Vpp = 0.0

When the CF card is not inserted I get a subtly different error
"/dev/hde: No such device or address" (ENXIO).

It looks like the drive <-> driver association is only set up when the
ide-disk driver module is loaded and not when new hardware is found.

Jan

