Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbREPMOY>; Wed, 16 May 2001 08:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261896AbREPMOQ>; Wed, 16 May 2001 08:14:16 -0400
Received: from pop.gmx.net ([194.221.183.20]:51602 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261895AbREPMOC>;
	Wed, 16 May 2001 08:14:02 -0400
Message-ID: <071001c0de01$45497730$0301a8c0@none56n4x0fcnq>
From: "Thomas Kotzian" <thomasko321k@gmx.at>
To: "Helge Hafting" <helgehaf@idb.hist.no>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 14:09:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Helge Hafting" <helgehaf@idb.hist.no>
> Partition id's seems more interesting than disk id's - we normally
> mount partitions not whole disks.
>
> RAID do this well - the raid autodetect partition stores an ID in the
> last block,
> the remaining N-1 blocks are available for a fs.
>
> This could be extended to non-raid use - i.e. use the "raid autodetect"
> partition type for non-raid as well.  The autodetect routine could
> then create /dev/partitions/home, /dev/partitions/usr or
> /dev/partitions/name_of_my_choice
> for autodetect partitions not participating in a RAID.

Raid can do this easily because they install the raid on fresh partitions so
they can easily "steal" the last sector, and the filesystem goes in the
"shrinked" raid-device. Normal partitions that already have a filesystem on
them (maybe another OS formatted them) occupy space including the last
sector - no place left on these partitions to baptize them. - how should
that work with existing fs'es???

> This is better than volume labels, as it will work for all fs'es
> (including those who don't support mount-by-ID) and also raw
> partitions with no fs.

Thomas Kotzian

