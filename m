Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTGKPld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTGKPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:41:33 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:48084
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263597AbTGKPla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:41:30 -0400
Date: Fri, 11 Jul 2003 11:56:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711155613.GC2210@gtf.org>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:26:19PM +0100, Alan Cox wrote:
> > - (Possibly linked to above bug) VIA APIC routing is currently broken.
> >   boot with 'noapic'.
> 
> Does 2.5 not have the INTD routing fix yet ?

It does.  It is in both 2.4 and 2.5 mainline now.


> > IDE.
> > ~~~~
> > - Known problems with the current IDE code. 
> >   o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
> FIXED
> >   o  PCMCIA IDE hangs on eject
> Should be fixed in 2.5, fixed(ish) in 2.4
> >   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> >      either use 2.4 or fix it 8)
> > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> >   are no longer supported. The only way forward is to remove the translator
> >   from the drive, and start over.
> 
> Or to use device mapper to remap the disk.

Definitely.  I'm hoping that people will decide upon a userland that
supports the popular (non-raid) partition tables as well as the simple
raid partitions, too.  Maybe that's a pipe dream, though ;-)



> > Ports.
> > ~~~~~~
> > - 2.5 features support for several new architectures.
> >   - x86-64 (AMD Hammer)
> >   - ppc64
> >   - UML (User mode Linux)
> >     See http://user-mode-linux.sf.net for more information.
> >   - uCLinux: m68k(w/o MMU), h8300 and v850.  sh also added a uCLinux option.
> > - The 64 bit s390x port got collapsed into a single port, appearing
> >   as a config option in the base s390 arch.
> > - In the opposite direction, arm26 was split out from arm.
> 
> sh64 ?

Only in 2.4.

	Jeff



