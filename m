Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBMP1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBMP1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWBMP1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:27:35 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31158 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750712AbWBMP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:27:35 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:26:01 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, davidsen@tmr.com,
       chris@gnome-de.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A509.nailKUSY13VFY@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43ED005F.5060804@tmr.com>
 <1139615496.10395.36.camel@localhost.localdomain>
 <43F088AB.nailKUSB18RM0@burner>
 <5a2cf1f60602130607v5954d1a6qc738dd608aaf9b96@mail.gmail.com>
In-Reply-To: <5a2cf1f60602130607v5954d1a6qc738dd608aaf9b96@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> [...]
> > > > Since -scanbus tells you a
> > > > device is a CDrecorder, or something else, *any user* is likely to be
> > > > able to tell it from DCD, CD-ROM, etc. Nice like of text for most devices...
> > >
> > > Well, "any user" just opens his Windows Explorer and takes a look at the
> > > icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
> > > interesting to see professional programmers often argue that a
> >
> > This is not true: a drive letter mapping does not need to exist on MS-WIN
> > in order to be able to access it via ASPI or SPTI.
>
> But from a user perspective, how one is supposed to identify between 2
> identical burners named D: and E: on their system if cdrecord only
> provides b,t,l naming and "b,t,l to cd burner name" mapping?

Drive letters do not have real relevence from a OS view if talking about MS-WIN

> The "OS specific to b,t,l" mapping is clearly lacking although
> cdrecord knows it there as well. Cf. scsi-wnt.c:
>
> #ifdef _DEBUG_SCSIPT
>         js_fprintf(scgp_errfile,  "SPTI: Adding drive %c: (%d:%d:%d)\n", 'A'+i,
>                                         pDrive->ha, pDrive->tgt, pDrive->lun);
> #endif

The is no mapping, libscg just let's the user use the addressing used inside 
the MS-WIN kernel.

The drive letter related code was contributed by a russion guy who did
try to find a way to lock a drive in use by cdrecord, preventing 
automount/autoexec. This is unfortunately a bit brain-dead and caused by 
MS-WIN oddities.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
