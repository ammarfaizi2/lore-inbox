Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130044AbRBZADU>; Sun, 25 Feb 2001 19:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130046AbRBZADK>; Sun, 25 Feb 2001 19:03:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:53261 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130044AbRBZADD>; Sun, 25 Feb 2001 19:03:03 -0500
Message-ID: <002f01c09f87$a99faff0$f6976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "Guest section DW" <dwguest@win.tue.nl>,
        "Andreas Jellinghaus" <aj@dungeon.inka.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: partition table: chs question
Date: Sun, 25 Feb 2001 17:04:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Guest section DW" <dwguest@win.tue.nl>; "Andreas Jellinghaus"
<aj@dungeon.inka.de>; <linux-kernel@vger.kernel.org>
Sent: Sunday, February 25, 2001 5:02 PM
Subject: Re: partition table: chs question


>
> Please also check vger.timpanogas.org/nwfs/nwfs.tar.gz:disk.c for NetWare
> specific calculations of the CHS values, a different method is used for
> NetWare partitions vs. everything else (Novell just had to be different).
> If you do not  use their methods on NetWare partitions, NetWare will not
> recognize the partition entries correctly, and will attempt to
reinitialize
> the entire partition table on a system if they are wrong (Ouch!).  NetWare
> does a different calculation for conversion of cylinder values above 1024.
>
> Jeff
>
>
> ----- Original Message -----
> From: "Guest section DW" <dwguest@win.tue.nl>
> To: "Andreas Jellinghaus" <aj@dungeon.inka.de>;
> <linux-kernel@vger.kernel.org>
> Sent: Sunday, February 25, 2001 2:47 PM
> Subject: Re: partition table: chs question
>
>
> > On Sun, Feb 25, 2001 at 04:35:34PM +0100, Andreas Jellinghaus wrote:
> >
> > > for partitions not in the first 8gb of a harddisk, what
> > > should the c/h/s start and end value be ?
> > >
> > > most fdisks seem to set start and end to 255/63/1023.
> > > but partition magic creates partitions with start set to
> > > 0/1/1023 and end set to 255/63/1023, and detects a problem
> > > if start is set to 255/63/1023.
> > >
> > > so, how should a partition table look like ?
> >
> > Since these values will never be used you can imagine that they
> > are not of great interest. Do whatever you like.

This statement is not true of NetWare partitions.  They are used to validate
whether or not the partition table has been corrupted.

Jeff


> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

