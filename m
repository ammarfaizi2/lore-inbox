Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRAGOVo>; Sun, 7 Jan 2001 09:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRAGOVe>; Sun, 7 Jan 2001 09:21:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132563AbRAGOVW>; Sun, 7 Jan 2001 09:21:22 -0500
Subject: Re: How to make VFAT work right in 2.4.0-prereleaseu
To: eelco@losser.st-lab.cs.uu.nl (Eelco Dolstra)
Date: Sun, 7 Jan 2001 14:22:08 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lubaldo@adinet.com.uy (Ivan Baldo),
        flf@operamail.com, ben@imben.com, linux-kernel@vger.kernel.org,
        linux-uy@linux.org.uy (Linux Uruguay), salvador@inti.gov.ar (SET)
In-Reply-To: <Pine.BSF.4.21.0101070300030.12461-100000@losser.st-lab.cs.uu.nl> from "Eelco Dolstra" at Jan 07, 2001 03:07:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGi2-0002ji-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > =09", just delete all of it (or comment it out). This change wich has b=
> een
> > > made in the -prerelease versi=F3n, makes Netscape Messenger not to work
> >=20
> > If you do that you will corrupt your FAT fs.
> 
> But only on SMP, right?  The only other FAT change I see in -ac (apart
> from my patch) is the spinlock around fat_cache.

SMP and uniprocessor will both corrupt the fatfs sometimes if you ftruncate
files larger without the grow the file patch.

Returning 0 not -EPERM also seems to be a valid standards compliant behaviour

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
