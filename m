Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbREPLTF>; Wed, 16 May 2001 07:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261879AbREPLSq>; Wed, 16 May 2001 07:18:46 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:42508 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261740AbREPLSf>; Wed, 16 May 2001 07:18:35 -0400
Message-ID: <3B0261EC.23BE5EF0@idb.hist.no>
Date: Wed, 16 May 2001 13:18:04 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Chemolli Francesco (USI)" <ChemolliF@GruppoCredit.it>,
        linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chemolli Francesco (USI)" wrote:
> 
> > The argument that "if you use numbering based on where in the
> > SCSI chain
> > the disk is, disks don't pop in and out" is absolute crap.
> > It's not true
> > even for SCSI any more (there are devices that will aquire
> > their location
> > dynamically), and it has never been true anywhere else. Give it up.
> 
> We could do something like baptizing disks.. Fix some location
> (i.e. the absolutely last sector of the disk or the partition table or
> whatever) and store there some 32-bit ID
> (could be a random number, a progressive number, whatever).

Partition id's seems more interesting than disk id's - we normally
mount partitions not whole disks.  

RAID do this well - the raid autodetect partition stores an ID in the
last block,
the remaining N-1 blocks are available for a fs.

This could be extended to non-raid use - i.e. use the "raid autodetect"
partition type for non-raid as well.  The autodetect routine could
then create /dev/partitions/home, /dev/partitions/usr or
/dev/partitions/name_of_my_choice
for autodetect partitions not participating in a RAID.

This is better than volume labels, as it will work for all fs'es
(including those who don't support mount-by-ID) and also raw
partitions with no fs.

Helge Hafting
