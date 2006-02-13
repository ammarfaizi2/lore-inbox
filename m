Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWBMKmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWBMKmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBMKmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:42:08 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:34471 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932082AbWBMKmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:42:07 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 11:40:32 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F06220.nailKUS5D8SL2@burner>
References: <20060208162828.GA17534@voodoo>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
In-Reply-To: <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > "D. Hazelton" <dhazelton@enter.net> wrote:
> >
> > > And does cdrecord even need libscg anymore? From having actually gone through
> > > your code, Joerg, I can tell you that it does serve a larger purpose. But at
> > > this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_
> > > writing programs, does _ANYONE_ use libscg? Is it ever used to access any
> > > other devices that are either SCSI or use a SCSI command protocol (like
> > > ATAPI)?  My point there is that you have a wonderful library, but despite
> > > your wishes, there is no proof that it is ever used for anything except
> > > writing/ripping CD's.
> >
> > Name a single program (not using libscg) that implements user space SCSI and runs
> > on as many platforms as cdrecord/libscg does.
>
>
> I have 2 technical questions, and I hope that you will take the time
> to answer them.
>
> 1) extract from the README of the latest stable cdrtools package:
>
>         Linux driver design oddities ******************************************
>         Although cdrecord supports to use dev=/dev/sgc, it is not recommended
>         and it is unsupported.
>
>         The /dev/sg* device mapping in Linux is not stable! Using dev=/dev/sgc
>         in a shell script may fail after a reboot because the device you want
>         to talk to has moved to /dev/sgd. For the proper and OS independent
>         dev=<bus>,<tgt>,<lun> syntax read the man page of cdrecord.
>
> My understanding of that is you say to not use dev=/dev/sgc because it
> isn't stable. Now that you've said that bus,tgt,lun is not stable on
> Linux (because of a "Linux bug") why is the b,t,l scheme preferred
> over the /dev/sg* one ?

b,t,l _is_ stable as long as the OS does a reasonable and orthogonal work.

This was true until ~ 2001, when Linux introduced unstable USB handling.
Note that this fact is not a failure from libscg but from Linux.


> 2) design question:
>
> - cdrecord scans then maps the device to the b,t,l scheme.
> - the libsg uses the b,t,l ids in its interface to perform the operations
>
> So now, if cdrecord could have a new option called -scanbusmap that
> displays the mapping it performs in a way that people can parse the
> output, I think that will solve most issues.

The output of cdrecord -scanbus is already parsable, so what is your point?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
