Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSFKEeT>; Tue, 11 Jun 2002 00:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFKEeT>; Tue, 11 Jun 2002 00:34:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15120
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316798AbSFKEeS>; Tue, 11 Jun 2002 00:34:18 -0400
Date: Mon, 10 Jun 2002 21:18:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
In-Reply-To: <Pine.LNX.3.96.1020610164828.23851A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10206102115530.9566-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Basically the driver has never properly supported CFA/Flash.
There are translation calls to decode various events.
It is kind of like ide-scsi or ide-cd for DVD-RAM, both will work but
clearly it is best operate in native interfaces.

In short I need to get around to creating an ide-cfa.c subdriver.

On Mon, 10 Jun 2002, Bill Davidsen wrote:

> On Sat, 8 Jun 2002, Andre Hedrick wrote:
> 
> > 
> > Because there is an entire set of new calls to deal with cfa or flash.
> > It really takes a new subdriver.
> 
> Could you clarifiy that to either (a) "the kernel is now broken
> completely for CF," (b) "use the non-kernel 3.1.33 pcmcia," or (c) "use
> XXX." It's not clear to me if you are stating that CF no longer works at
> all, not longer works with taskfile, no longer works but pcmcia separate
> modules do, or that I need some other software "new subdriver" not in the
> kernel or pcmcia package.
> 
> I'm not matching any of those to uni laptops working with kernel plus OLD
> pcmcia support for pcmcia in kernel, and SMP not working with any
> combination of recent kernel (plain, -jam, -ac, -aa, with patches, etc)
> and any pcmcia.
>  
> > On Tue, 4 Jun 2002, Bill Davidsen wrote:
> > 
> > > On Wed, 29 May 2002, Nick Evgeniev wrote:
> 
> > > > I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
> > > > filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
> > > > little bit better though every 5-8 hours I've got ide errors in log (at
> > > > least it didn't crash my reiserfs volumes yet):
> > > 
> > > I see a lot of the 0x58 with taskfile enabled, are you doing that? I even
> > > see it mounting an "IDE" compact flash! I ran out of time to try w/o
> > > taskfile_io.
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> 

Andre Hedrick
LAD Storage Consulting Group

