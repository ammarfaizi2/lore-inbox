Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314268AbSD0Pmm>; Sat, 27 Apr 2002 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314269AbSD0Pml>; Sat, 27 Apr 2002 11:42:41 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:61639 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314268AbSD0Pmk>;
	Sat, 27 Apr 2002 11:42:40 -0400
Date: Sat, 27 Apr 2002 17:42:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Kevin Krieser <kkrieser_list@footballmail.com>,
        linux-kernel@vger.kernel.org, Martin Bene <martin.bene@icomedias.com>,
        Andre Hedrick <andre@linux-ide.org>
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Message-ID: <20020427174226.B7293@ucw.cz>
In-Reply-To: <20020427125551.GG10849@niksula.cs.hut.fi> <NDBBLFLJADKDMBPPNBALAEHKIEAA.kkrieser_list@footballmail.co m> <5.1.0.14.2.20020427153130.03ea8b30@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 04:02:54PM +0100, Anton Altaparmakov wrote:
> At 14:51 27/04/02, Kevin Krieser wrote:
> >You need an IDE controller that supports ATA133.  For most existing
> >computers, that is going to require a new card.
> 
> Rubbish! The drives are backwards compatible with all ATA standards (do a 
> hparm -i on the drive and you will see). I certainly don't have an ATA133 
> controller and use one of the new Maxtor ATA133 drives just fine on it.
> 
> For LBA48 support I am not too sure whether you need a special controller 
> (for what it's worth I use a Promise ATA100 controller and it works fine on 
> my Maxtor 120G, LBA48, ATA133 disk but the disk is possibly not big enough 
> for any problems to manifest).
> 
> Perhaps Andre (cc-ed) could shed some light on this?

For ATA133 you need a new controller if you want the 133 MB/sec speed.
But the drives will work with any lower speed controller just fine, and
the speed difference is not really noticeable.

For LBA48 you don't need any special hardware, just support for it in
the kernel. So even an old PIIX4 will do just fine. The onboard BIOS may
refuse to boot from that drive, though.

> 
> Best regards,
> 
> Anton
> 
> >-----Original Message-----
> >
> >
> >From: linux-kernel-owner@vger.kernel.org
> >[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ville Herva
> >Sent: Saturday, April 27, 2002 7:56 AM
> >To: Martin Bene; linux-kernel@vger.kernel.org
> >Subject: 48-bit IDE [Re: 160gb disk showing up as 137gb]
> >
> >
> >On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> > >
> > > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > > 160GB.
> > >
> > > (...) however, you can do something about the linux ATA driver: code
> > > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> >
> >But which IDE controllers support 48-bit addressing? Not all of them? Does
> >linux IDE driver support 48-bit for all of them? Do they require BIOS
> >upgrade in order to operate 48-bit?
> >
> >Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
> >box I have and be done with it?
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
