Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUB0V7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUB0Vz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:55:56 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:45235 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263159AbUB0Vxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:53:31 -0500
Date: Fri, 27 Feb 2004 19:51:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
In-Reply-To: <200402272114.23108.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58L.0402271950540.19454@logos.cnet>
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271629430.19209@logos.cnet>
 <1077908499.29713.19.camel@dhcp23.swansea.linux.org.uk>
 <200402272114.23108.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, Bartlomiej Zolnierkiewicz wrote:

> On Friday 27 of February 2004 20:01, Alan Cox wrote:
> > On Gwe, 2004-02-27 at 19:30, Marcelo Tosatti wrote:
> > > > > Haven't got a clue about these "status=0x51" and "error=0x04".
> > > > > Anyone?
> > > >
> > > > Basically, the errors mean what they say - the drive is in an error
> > > > state, (received an unrecognised command), but is ready for further
> > > > operation.
> > >
> > > Received an unrecognised command from the kernel? What can cause that?
> >
> > Our early setup/probing code in 2.4.x at least may send stuff that very
> > very old disks don't understand. Its arguably a bug in the ident parsing
> > but it shouldnt ever be harmful
>
> ide-disk.c sends WIN_READ_NATIVE_MAX_{EXT} without checking
> if HPA feature set is supported, this is fixed in 2.6.x for a long time.
>
> We need 2.4<->2.6 IDE sync monkey... a really smart one...

OK and what about the status=0x58 errors? What are those about?
