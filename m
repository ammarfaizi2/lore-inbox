Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSGPKey>; Tue, 16 Jul 2002 06:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSGPKex>; Tue, 16 Jul 2002 06:34:53 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:4818 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S313087AbSGPKew>; Tue, 16 Jul 2002 06:34:52 -0400
Date: Tue, 16 Jul 2002 12:16:38 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020716121637.A223@linux-m68k.org>
References: <200207151307.g6FD7DJ1020676@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207151307.g6FD7DJ1020676@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Mon, Jul 15, 2002 at 03:07:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 03:07:13PM +0200, Joerg Schilling wrote:
> 
> >From: Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
> 
> >> >There is another problem, with your scsi transport library you
> >> >are bypassing normal Linux devices. Try
> >> >  mount /dev/scd0 /mnt
> >> >  cdrecord -dev 0,0,0 -blank=fast
> >> >  ls -al /mnt
> >> 
> >> >Nice? It certainly isn't the fault of Linux if you choose to
> >> >bypass normal device usage and it can be very annoying not
> >> >only for beginners.
> >> 
> >> It is not a fault of cdrecord either.
> 
> >A cure would be nice and I don't see what the kernel could do
> >to solve this problem as long as cdrecord insists on talking
> >to the SCSI bus directly.
> 
> >If nothing else, cdrecord manpage
> > - should make a big fat warning about it
> > - should stop claiming that it is safe to suid cdrecord
> 
> >The potential for breakage is huge, people run automounters on CD's,
> >file managers may try to mount the CD without asking the user.
> 
> The bad news is that it seems that the automounters are part of the GUIs and 
> not well enough documented. There should be:
> 
> -	Something like the Solaris volume manager that is part of the base OS 
> 	and kernel folks should forbid GUI folks to add such tasks to the GUI

Solaris vold? Thanks no, floppy access was so easy in SunOS before the 
days of the volume manager.

> -	The volume manager should have a documented interface that allows 
> 	programs like e.g. cdrecord to gain exclusive access to a CD drive.

much simpler, cdrom driver needs an ioctl to claim exclusive use of
the device and cdrecord than needs to use that ioctl.

Richard
