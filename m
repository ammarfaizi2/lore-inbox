Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262016AbREPRBp>; Wed, 16 May 2001 13:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262010AbREPRBf>; Wed, 16 May 2001 13:01:35 -0400
Received: from hermes.sistina.com ([208.210.145.141]:32017 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S262009AbREPRBZ>;
	Wed, 16 May 2001 13:01:25 -0400
Date: Wed, 16 May 2001 18:58:45 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
To: Thomas Kotzian <thomasko321k@gmx.at>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516185845.A14397@sistina.com>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <071001c0de01$45497730$0301a8c0@none56n4x0fcnq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <071001c0de01$45497730$0301a8c0@none56n4x0fcnq>; from thomasko321k@gmx.at on Wed, May 16, 2001 at 02:09:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 02:09:32PM +0200, Thomas Kotzian wrote:
> From: "Helge Hafting" <helgehaf@idb.hist.no>
> > Partition id's seems more interesting than disk id's - we normally
> > mount partitions not whole disks.
> >
> > RAID do this well - the raid autodetect partition stores an ID in the
> > last block,
> > the remaining N-1 blocks are available for a fs.
> >
> > This could be extended to non-raid use - i.e. use the "raid autodetect"
> > partition type for non-raid as well.  The autodetect routine could
> > then create /dev/partitions/home, /dev/partitions/usr or
> > /dev/partitions/name_of_my_choice
> > for autodetect partitions not participating in a RAID.
> 
> Raid can do this easily because they install the raid on fresh partitions so
> they can easily "steal" the last sector, and the filesystem goes in the
> "shrinked" raid-device. Normal partitions that already have a filesystem on
> them (maybe another OS formatted them) occupy space including the last
> sector - no place left on these partitions to baptize them. - how should
> that work with existing fs'es???

Right.
LVM does a similar thing storing UUIDs in its private metadata area
on every device used by it.

Problem is: neither MD nor LVM define a standard in Linux which *needs* to be
used on every device!

It is just up to the user to configure devices with them or not.

BTW: in case we had a Linux standard it wouldn't solve the
"different OS" situation mentioned in this thread either.


Generally speaking:

It is not the problem to reserve some space to store a uuid or something
at such and such location on a device.

The problem is the lack of a standard which eventually
could be implemented in all OSes at some point in time.

OS dependent data migration tools presumed, we could have
that standard in place on (all) real devices a little later than that ;-)

And what about a standard to access the stored identifying
data and to avoid that it doesn't get overwritten by accident?

> 
> > This is better than volume labels, as it will work for all fs'es
> > (including those who don't support mount-by-ID) and also raw
> > partitions with no fs.
> 
> Thomas Kotzian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
