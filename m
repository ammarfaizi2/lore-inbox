Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262343AbREXV2E>; Thu, 24 May 2001 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbREXV1v>; Thu, 24 May 2001 17:27:51 -0400
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:37870 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S262343AbREXV1q>; Thu, 24 May 2001 17:27:46 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19+ide: corrupts ide tape output
In-Reply-To: <200105212149.XAA10612@harpo.it.uu.se>
From: Camm Maguire <camm@enhanced.com>
Date: 24 May 2001 17:27:22 -0400
In-Reply-To: Mikael Pettersson's message of "Mon, 21 May 2001 23:49:14 +0200 (MET DST)"
Message-ID: <543d9uv3np.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thank you for this information!  I've just confirmed
this.  Both of my ATAPI tapes don't work reliably with the Promise
Ultra100, but do work with the on board ALI 15x3 chipsets.  Both disks
in this box appear to work with both sets of controllers.  After
considerable difficulty, I'm now booting off of the off-board Promise,
and all looks stable.

Question -- is the lack of support for ATAPI on the Promise Ultra100 a
hardware, or a driver/software, issue?

Take care,

Mikael Pettersson <mikpe@csd.uu.se> writes:

> On 21 May 2001 14:49:55 -0400, Camm Maguire <camm@enhanced.com> wrote:
> 
> >Greetings!  2.2.19+ide, applied the patch because this box has a new
> >Promise PDC20267 ide controller.  14GB HP Colorado tape drive.  Before
> >we installed the new ide controller and patched the kernel, i.e. with
> >unpatched 2.2.19 running on a different ide controller, this setup
> >works just fine.  Now I get the following occasionally, which results
> >in corrupted dumps to tape:
> >
> >May 21 10:27:47 intech9 kernel: hdh: status error: status=0x40 { DriveReady }
> >May 21 10:27:47 intech9 kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
> 
> You added a Promise Ultra100 PCI card, right?
> >From what I hear, it doesn't support ATAPI devices well, only disks.
> So if you moved the HP tape drive to the PDC, move it back to
> the mainboard's IDE controller.
> Also, don't disable the mainboard's controller thinking you can save
> some interrupts that way. Andre Hedrick (Linux IDE guy) once wrote
> that this could cause the PDC to grab IRQ 14, which had some nasty
> side-effects.
> 
> (My main box runs with disks on a Promise Ultra100 card and
> ATAPI CD-RW and tape on the mainboard's IDE (440BX) controller.
> Both 2.2+ide and 2.4 work fine.)
> 
> /Mikael
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
