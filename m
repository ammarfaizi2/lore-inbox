Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRAaUFE>; Wed, 31 Jan 2001 15:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132666AbRAaUEy>; Wed, 31 Jan 2001 15:04:54 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:55812 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id <S132696AbRAaUEm>;
	Wed, 31 Jan 2001 15:04:42 -0500
Message-ID: <3A786FDB.F7B2DF78@pobox.com>
Date: Wed, 31 Jan 2001 15:04:43 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
CC: Andre Hedrick <andre@linux-ide.org>, Andries.Brouwer@cwi.nl, ole@linpro.no,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <Pine.LNX.4.10.10101310936280.14252-100000@master.linux-ide.org> <m3u26ffrej.fsf@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple solution is to have kernel fall-back to LBA style
translations instead of kernel "basic" translations.
This would make it match the first two "BIOS" drives
on most systems, and not really hurt anything in most cases.

Even better would be to add a stage in front of the fall-back,
which queries the BIOS (from kernel startup code) for translation
info on ALL drives.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


Rupa Schomaker wrote:
> 
> Andre Hedrick <andre@linux-ide.org> writes:
> 
> > > But there is no indication of what the problems could be,
> > > or what he thinks the geometry should be (and why).
> > > I see nothing very wrong in the posted data.
> >
> > We agree Andries, but the enduser wants to see stuff the same.
> 
> In my case, I have two identical Maxtor drives, but they reported
> different geometry.  How could that be?  Move the "virgin" drive to
> the motherboard IDE controller and suddenly the geometry is the same.
> Use fdisk and partition the disk, write it, and then move to the
> promise controller and the "correct" geometry was used (that is, it is
> now the same as when hooked up to the motherboard ide controller).
> 
> Why was it important to me?  I'm doing RAID1 and it is really nice to
> have the same geometry so that the partition info is the same between
> the two drives.   Makes life easier.
> 
> --
> -rupa
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
