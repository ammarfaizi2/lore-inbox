Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUAAVC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUAAVB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:01:56 -0500
Received: from colo.khms.westfalen.de ([213.239.196.208]:64910 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S264884AbUAAU4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:56:10 -0500
Date: 01 Jan 2004 21:43:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <900eUExXw-B@khms.westfalen.de>
In-Reply-To: <200401010634.28559.rob@landley.net>
Subject: Re: udev and devfs - The final word
X-Mailer: CrossPoint v3.12d.kh12 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rob@landley.net (Rob Landley)  wrote on 01.01.04 in <200401010634.28559.rob@landley.net>:

> On Wednesday 31 December 2003 18:31, Rob Love wrote:
> > On Wed, 2003-12-31 at 19:15, Andries Brouwer wrote:
> > > My plan has been to essentially use a hashed disk serial number
> > > for this "any old unique value". The problem is that "any old"
> > > is easy enough, but "unique" is more difficult.
> > > Naming devices is very difficult, but in some important cases,
> > > like SCSI or IDE disks, that would work and give a stable name.
> >
> > Yup.
> >
> > > The kernel must not invent consecutive numbers - that does not
> > > lead to stable names. Setting this up correctly is nontrivial.
> >
> > This is definitely an interesting problem space.
> >
> > I agree wrt just inventing consecutive numbers.  If there was a nice way
> > to trivially generate a random and unique number from some
> > device-inherent information, that would be nice.
> >
> > 	Rob Love
>
> Fundamental problem: "Unique" depends on the other devices in the system.
> You can't guarantee unique by looking at one device, more or less by
> definition.

This is actually not fundamental at all.

The best-known exception is probably the MAC address. But it is not the  
only example of devices having true unique information.

It is certainly true, though, that there are devices without this kind of  
info.

And remember that you can sometimes use secondary information. With any  
kind of read-write storage device, it might be possible to create such a  
piece of information and store it onto that device.

Moral: keep the identifier creation framework flexible enough so that you  
can chose device-specific means to produce useful identifiers. (And, use  
long identifiers, as they're less likely to be duplicated in general.)

MfG Kai
