Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132551AbRC1VZy>; Wed, 28 Mar 2001 16:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132572AbRC1VZs>; Wed, 28 Mar 2001 16:25:48 -0500
Received: from [195.63.194.11] ([195.63.194.11]:40459 "EHLO mail.stock-world.de") by vger.kernel.org with ESMTP id <S132551AbRC1VW7>; Wed, 28 Mar 2001 16:22:59 -0500
Message-ID: <3AC25321.C99EDAC7@evision-ventures.com>
Date: Wed, 28 Mar 2001 23:09:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <E14i0u8-0004N1-00@the-village.bc.nu> <3AC1109A.8459E52@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Alan Cox wrote:
> >
> > > Another example: all the stupid pseudo-SCSI drivers that got their own
> > > major numbers, and wanted their very own names in /dev. They are BAD for
> > > the user. Install-scripts etc used to be able to just test /dev/hd[a-d]
> > > and /dev/sd[0-x] and they'd get all the disks. Deficiencies in the SCSI
> >
> > Sorry here I have to disagree. This is _policy_ and does not belong in the
> > kernel. I can call them all /dev/hdfoo or /dev/disc/blah regardless of
> > major/minor encoding. If you dont mind kernel based policy then devfs
> > with /dev/disc already sorts this out nicely.
> >
> > IMHO more procfs crud is also not the answer. procfs is already poorly
> > managed with arbitary and semi-random namespace. Its a beautiful example of
> > why adhoc naming is as broken as random dev_t allocations. Maybe Al Viro's
> > per device file systems solve that.
> >
> 
> In some ways, they make matters worse -- now you have to effectively keep
> a device list in /etc/fstab.  Not exactly user friendly.
> 
> devfs -- in the abstract -- really isn't that bad of an idea; after all,

Devfs is from a desing point of view the duplication for the bad /proc
design for devices. If you need a good design for general device
handling with names - network interfaces are the thing too look at.
mount() should be more like a select()... accept()!
