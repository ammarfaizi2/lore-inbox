Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWBMWsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWBMWsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWBMWsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:48:05 -0500
Received: from smtp.enter.net ([216.193.128.24]:46856 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964887AbWBMWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:48:04 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:57:10 -0500
User-Agent: KMail/1.8.1
Cc: jerome.lacoste@gmail.com, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com> <43F06220.nailKUS5D8SL2@burner>
In-Reply-To: <43F06220.nailKUS5D8SL2@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131757.11725.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 05:40, Joerg Schilling wrote:
> jerome lacoste <jerome.lacoste@gmail.com> wrote:
> > On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > "D. Hazelton" <dhazelton@enter.net> wrote:
> > > > And does cdrecord even need libscg anymore? From having actually gone
> > > > through your code, Joerg, I can tell you that it does serve a larger
> > > > purpose. But at this point I have to ask - besides cdrecord and a few
> > > > other _COMPACT_ _DISC_ writing programs, does _ANYONE_ use libscg? Is
> > > > it ever used to access any other devices that are either SCSI or use
> > > > a SCSI command protocol (like ATAPI)?  My point there is that you
> > > > have a wonderful library, but despite your wishes, there is no proof
> > > > that it is ever used for anything except writing/ripping CD's.
> > >
> > > Name a single program (not using libscg) that implements user space
> > > SCSI and runs on as many platforms as cdrecord/libscg does.
> >
> > I have 2 technical questions, and I hope that you will take the time
> > to answer them.
> >
> > 1) extract from the README of the latest stable cdrtools package:
> >
> >         Linux driver design oddities
> > ****************************************** Although cdrecord supports to
> > use dev=/dev/sgc, it is not recommended and it is unsupported.
> >
> >         The /dev/sg* device mapping in Linux is not stable! Using
> > dev=/dev/sgc in a shell script may fail after a reboot because the device
> > you want to talk to has moved to /dev/sgd. For the proper and OS
> > independent dev=<bus>,<tgt>,<lun> syntax read the man page of cdrecord.
> >
> > My understanding of that is you say to not use dev=/dev/sgc because it
> > isn't stable. Now that you've said that bus,tgt,lun is not stable on
> > Linux (because of a "Linux bug") why is the b,t,l scheme preferred
> > over the /dev/sg* one ?
>
> b,t,l _is_ stable as long as the OS does a reasonable and orthogonal work.
>
> This was true until ~ 2001, when Linux introduced unstable USB handling.
> Note that this fact is not a failure from libscg but from Linux.

Isn't that also when the USB system underwent a massive rewrite to fully 
support hotplugging and to fix a lot of bugs that were present in the 
original implementation?

Still, the question I posed in my earlier post remains - why can't you have 
your program do the BTL mappings behind the scenes? You can easily allow it 
from the command line and also allow pointing to a /dev entry... If you want 
I'll actually put together a patch based on whatever version of cdrecord I 
have here on my system and send it to you.

DRH
