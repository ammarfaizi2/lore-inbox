Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSLYA67>; Tue, 24 Dec 2002 19:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSLYA67>; Tue, 24 Dec 2002 19:58:59 -0500
Received: from f134.law7.hotmail.com ([216.33.237.134]:53768 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265998AbSLYA65>;
	Tue, 24 Dec 2002 19:58:57 -0500
X-Originating-IP: [198.70.229.121]
From: "Randy S." <hey_randy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: nForce2 chipset and agpgart: unsupported bridge?
Date: Tue, 24 Dec 2002 20:07:05 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1342cBQnBJxjjK7bsv00012080@hotmail.com>
X-OriginalArrivalTime: 25 Dec 2002 01:07:05.0432 (UTC) FILETIME=[F09F2D80:01C2ABB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, let's try a different tack then...

Suppose I were to try to add the nForce2 support myself...

I'm aware of the following considerations:

1) agpgart has been somewhat redesigned for kernel 2.5.X. I'm not ready to 
tackle that aspect yet.
2) Since they want everyone to use their cards, its doubtful that nvidia 
will give me any help in this task.
3) I have limited knowledge of the AGP and PCI specifications
4) I can always buy a new board if this one fries... :-p


I know I at least need the PCI device ID and a setup routine. The setup 
routine needs to set lots of state structure fields to define the masks, 
aperture, etc. I might also need some custom routines for this chipset, but 
I don't know anything about that yet.

Could anyone give me some guidelines on how I might go about finding this 
data? Also, feel free to tell me if this a waste of time because someone 
else is already doing it and/or its unfeasible without nvidia's help.

And as before, please CC me on any replies. I don't subscribe since my mail 
service can't handle the this list's volume.

Thanks,
   Randy Sharo


>
>The way I know it you must first of all build the nvagp modules
>downloadable from nVidia's web site and use those instead of agpgart.
>However, the snafu is that you must have an nVidia video card to go
>along with it (or use the on-chipset crap video card.) So you're SOL i
>think, at least until nvidia gets a bit less selfish.
>
>-Josh
>
>Rabid cheeseburgers forced "Randy S." <hey_randy@hotmail.com> to write
>this on Tue, 24 Dec 2002 16:21:37 -0500:
>
> > Hi folks,
> >
> >   I recently acquired a motherboard with an NVidia nForce 2 chipset
> >   (more
> > specifically, its a Chaintech CT-7NJS). I have a Radeon 9700PRO video
> > card that I'm running in this machine.  I've got integrated
> > networking, sound, XFree86, etc. working, but am having trouble
> > getting 3D acceleration to work.
> >
> >    My kernel is 2.4.19.  Agpgart does not appear to be able to detect
> >    the
> > nForce 2 chipset's bridge. There is no vendor entry for nvidia at all,
> > actually -- otherwise I might have gotten by with
> > agp_try_unsupported=1.
> >
> >    Has anyone written nForce2 support for agp? Is so, where can I find
> >    the
> > source?   I found drivers for the nvidia IGP (which I don't have), but
> > not for agpgart itself at the nvidia site.  If I find the source, I
> > believe I'll have to merge it manually since the 3D driver for Radeon
> > 9700 (fglrx) includes a modified agpgart_be.c.
> >
> >     If this is not a new question, my apologies -- I couldn't find an
> >     answer
> > anywhere in the archives.
> >
> >    Please CC me directly on any reply, as I'm not currently
> >    subscribed.
> >
> > Thanks!
> >    Randy Sharo
> >    hey_randy@hotmail.com
> >
> >
> > _________________________________________________________________
> > MSN 8: advanced junk mail protection and 3 months FREE*.
> > 
>http://join.msn.com/?page=features/junkmail&xAPID=42&PS=47575&PI=7324&DI=7474&SU=
> > 
>http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_advancedjmf_3mf
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
>--
>Joshua Kwan
>joshk@mspencer.net
>pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
>
>(13:59:00) Ted: my english teacher isn't all that smart when it comes to
>telling the fruit of labor from that of the rectum
>
>"oh that's right! I'm not deleting a bob anymore, i'm deleting a duck!"
>-vivek
><< attach3 >>


_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 3 months FREE*. 
http://join.msn.com/?page=features/junkmail&xAPID=42&PS=47575&PI=7324&DI=7474&SU= 
http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_stopmorespam_3mf

