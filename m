Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSGHVkk>; Mon, 8 Jul 2002 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGHVkj>; Mon, 8 Jul 2002 17:40:39 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65029
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316988AbSGHVki> convert rfc822-to-8bit; Mon, 8 Jul 2002 17:40:38 -0400
Date: Mon, 8 Jul 2002 14:41:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Paul Bristow <paul@paulbristow.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <3D29F70D.6020001@paulbristow.net>
Message-ID: <Pine.LNX.4.10.10207081438090.9331-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

You have to remember that all that is good is SCSI, that is why the
hardare is dying and going away for the most part.  We all know that
ATA/IDE is a thing of the past as is anything with a parallel ribbon.

Just let them go about their merry way as there is something else on the
horizon where your talents would be used if you were willing.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 8 Jul 2002, Paul Bristow wrote:

> OK.  I kept quiet while the IDE re-write went on so that when it was 
> over I could fix up ide-floppy and start adding some of the requested 
> features that were only really possible with the taskfile capabilities. 
>  But I have to jump in with the latest statements from Martin...  
> 
> Martin Dalecki wrote:
> 
> >U¿ytkownik Eduard Bloch napisa³:
> >  
> >
> >>Why not another way round? Just make the ide-scsi driver be prefered,
> >>and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
> >>that are expected as /dev/hd* by some user's configuration?
> >>    
> >>
> >
> >This is the intention.
> >
> Since when?  I thought Jens was in the process of getting rid of the 
> ide-scsi kludge with his moves to support cd/dvd writing directly in 
> ide-cd?
> 
> >>to be honest - why keep ide-[cd,floppy,tape] when they can be almost
> >>completely replaced with ide-scsi? I know about only few cdrom devices
> >>that are broken (== not ATAPI compliant) but can be used with
> >>workarounds in the current ide-cd driver. OTOH many users do already
> >>need ide-scsi to access cd recorders and similar hardware, so they would
> >>benefit much more from having ide-scsi as default than few users of
> >>broken "atapi" drives.
> >>    
> >>
> OK.  I would prefer though to take Linus's comment on board about 
> unifying the removeable media  interfaces. Be they IDE, SCSI, Firewire, 
> USB, whatever.  Let's try to make it something comprehensible for 
> "normal humans", and don't say "let config scripts sort it out - I deal 
> with many user help requests from broken configs.
> 
> Please don't forget that
>   a) some of the broken ide devices will still need fixes even if 
> handled via ide-scsi (and yes, devices on the market today are still 
> broken today)
>   b) some features still need IDE commands (not ATAPI) which I hoped we 
> would have done via taskfile - I guess this is tricky via ide-scsi
>   c) getting ide-scsi working for PCMCIA devices is an absolute f*****g 
> nightmare - for this reason alone I would keep ide-floppy
>   d) many of these devices (LS120/LS240/Zip 100/250 etc) can and need to 
> boot.  I don't even know how to start doing this under ide-scsi in it's 
> present form.
> 
> The current system may be ugly, but if we have to break it in the name 
> of progress we have at least to make the new, improved version work as 
> well (and hopefully better) than the old one.
> 
> >>Other operating systems did switch to constitent (scsi-based) way of
> >>accessing all kinds of removable media drivers. Why does Linux have to
> >>keep a kludge, written years ago without having a good concept?
> >>
> >>    
> >>
> If we can address all these issues I will be extremely happy to helping 
> create a sensible removeable media subsystem.
> 
> 
> -- 
> 
> Paul
> 
> Linux ide-floppy maintainer
> Email:	paul@paulbristow.net
> Web:	http://paulbristow.net
> ICQ:	11965223
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

