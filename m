Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRBZRlR>; Mon, 26 Feb 2001 12:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbRBZRlI>; Mon, 26 Feb 2001 12:41:08 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:4879 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129257AbRBZRlB>; Mon, 26 Feb 2001 12:41:01 -0500
Message-ID: <000801c0a01b$744df0c0$f6976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Guest section DW" <dwguest@win.tue.nl>,
        "Andreas Jellinghaus" <aj@dungeon.inka.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10102260929080.28790-100000@master.linux-ide.org>
Subject: Re: partition table: chs question
Date: Mon, 26 Feb 2001 10:42:14 -0700
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
From: "Andre Hedrick" <andre@linux-ide.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>; "Guest section DW"
<dwguest@win.tue.nl>; "Andreas Jellinghaus" <aj@dungeon.inka.de>;
<linux-kernel@vger.kernel.org>
Sent: Monday, February 26, 2001 10:32 AM
Subject: Re: partition table: chs question


> On Mon, 26 Feb 2001, Jeff V. Merkey wrote:
>
> > On Sun, Feb 25, 2001 at 05:59:33PM -0800, Andre Hedrick wrote:
> > >
> > >
> > > It does not matter because the usage of CHS will dies soon because it
was
> > > voted to death in Austin last week.  There will only be LBA addressing
> > > from now on out.
> >
> > If someone has Linux and NetWare dual booted on a system, and does not
> > fill out the CHS fields properly for NetWare partitions, When NetWare
> > boots, it will wipe the partition table (it will ask you first) and
> > will not recognize any of the partitions.  It does this because if it
> > sees CHS values it does not expect, it assumes the partition table
> > has been corrupted.
>
> Then Netware is a bad HOST-Driver and people should expect to be hurt by
> using a HOST that is not compliant.  It is the responsiblity of the user
> to tell the HOST-OS what it needs to do.  Especially if one of the OSes
> can not be intelligent enough to adpat to the changes.

Andre,

I am not going to debate whether what they do is good or bad, there's
arguments either
way for the value in being able to detect a corrupted boot sector.
Unfortunately, this is how all the installed NetWare versions on planet
Earth behave.  If someone is rearranging a partition table and fills out
these values wrong, it will make the drive unreadable to NetWare, and make
it look like Linux just corrupted the drive (since Linux will get blamed).
The disk
tools should observe each OS's weirdness if it may potentially change values
in this
table and cause data loss.

Jeff


>
> Regards,
>
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> --------------------------------------------------------------------------
---
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

