Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSGNUrX>; Sun, 14 Jul 2002 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGNUrW>; Sun, 14 Jul 2002 16:47:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43509 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317114AbSGNUrV>; Sun, 14 Jul 2002 16:47:21 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <xltn0sujb0v.fsf@shookay.newview.com>
References: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
	<1026683185.13886.81.camel@irongate.swansea.linux.org.uk> 
	<xltn0sujb0v.fsf@shookay.newview.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 22:59:42 +0100
Message-Id: <1026683982.13885.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 21:43, Mathieu Chouquet-Stringer wrote:
> alan@lxorguk.ukuu.org.uk (Alan Cox) writes:
> > On Sun, 2002-07-14 at 21:21, Mathieu Chouquet-Stringer wrote:
> > > I'm running tar (the regular version not star) right now on an Athlon @
> > > 850. The fs is ext3 and the disk is a scsi drive.
> > > So far, tar has been running for 17 min 25 sec, and that's what top says:
> > > CPU states:  1.7% user, 98.2% system,  0.0% nice,  0.0% idle
> >                  ^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > Why are using PIO mode devices ?
> 
> I'm using SCSI :
> Jul 13 16:35:50 mcs kernel: SCSI subsystem driver Revision: 1.00

Intriguing. Something horrible is happening on your system to see 98%
system time off a bus mastering DMA controller. It should only look like
that on things like an AHA152x 

