Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRK1Qtw>; Wed, 28 Nov 2001 11:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRK1Qtn>; Wed, 28 Nov 2001 11:49:43 -0500
Received: from [195.63.194.11] ([195.63.194.11]:58122 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S273305AbRK1Qt2>; Wed, 28 Nov 2001 11:49:28 -0500
Message-ID: <3C051345.41D81A1C@evision-ventures.com>
Date: Wed, 28 Nov 2001 17:39:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de> <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com> <20011128135508.A21418@caldera.de> <20011128092600.Q730@lynx.no> <20011128174250.A17582@caldera.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Wed, Nov 28, 2001 at 09:26:00AM -0700, Andreas Dilger wrote:
> > What would be nice in the case of drivers that don't use the new error
> > handling code is to add something like:
> >
> > #warning "Uses obsolete SCSI error code, see Documentation/2.5/scsi-error.txt"
> >
> > for a hint as to the reason why it no longer compiles, and a short guide
> > on how to update the drivers.
> 
> I already thought about that - as the old error handling code is selected
> by setting a member in a struct to '1' I don't see any easy way to do so...
> 
>         Christoph

Please note that this selection is static with regard to the driver.
It only happens in the initialization code for the driver!
The #warning doesn't have to at the same place where the filed in
the struct was.
