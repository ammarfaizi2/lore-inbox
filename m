Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbREPWMR>; Wed, 16 May 2001 18:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262070AbREPWMI>; Wed, 16 May 2001 18:12:08 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:225 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262031AbREPWL5>; Wed, 16 May 2001 18:11:57 -0400
Date: Thu, 17 May 2001 00:11:55 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010517001155.H806@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg> <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca> <3B02D6AB.E381D317@transmeta.com> <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca> <3B02DD79.7B840A5B@transmeta.com> <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca> <3B02F2EC.F189923@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3B02F2EC.F189923@transmeta.com>; from hpa@transmeta.com on Wed, May 16, 2001 at 02:36:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 02:36:44PM -0700, H. Peter Anvin wrote:
> > But all devices which export a CD-ROM interface will do so. So the
> > device node that is associated with the CD-ROM driver will export
> > CD-ROM semantics, and the trailing name will be "/cd".
> > 
> > Other interfaces a device exports, such as a CD-RW, appear as a
> > different device node ("generic" for SCSI, because we have no CD-RW
> > classification at this point).
> > 
> > My scheme works already, and works reliably. Nothing had to be done to
> > support the CD-ROM interface to CD-RW and DVD devices.
> > 
> 
> It's still completely braindamaged: (a) these interfaces aren't
> disjoint.  They refer to the same device, and will interfere with each
> other; (b) it is highly undesirable to tie the naming to the interfaces
> in this way.  It further restricts the namespaces you can export, for one
> thing.

We do this already with ide-scsi. A device is visible as /dev/hda
and /dev/sda at the same time. Or think IDE-CDRW: /dev/hda,
/dev/sr0 and /dev/sg0.

All at the same time.

It is perfectly normal to export different interfaces for the
same device. This is basically, what subfunctions on PCI do: Same
device with different interfaces. 

Just that we do it through a driver with ide and through the
hardware with a multi function PCI card.

Applications don't care about devices. They care about entities
that have capabilities and programming interfaces. What they
_really_ are and if this is only emulated is not important.

Sorry, I don't see your point here :-(


Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
