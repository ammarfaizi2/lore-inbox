Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWAaNgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWAaNgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWAaNgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:36:24 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:24252 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750815AbWAaNgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:36:23 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 Jan 2006 14:35:10 +0100
To: schilling@fokus.fraunhofer.de, bzolnier@gmail.com
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DF678E.nail3B431CUWJ@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
In-Reply-To: <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

>   Joerg, I don't see any sense in providing users with fake SCSI
>   lun and bus numbers for ATAPI devices.  I think that what users
>   would like is the list of devices consisting of "fd" and actual vendor
>   name of device (+ optionally serial no + optionally "x:y:z" for real
>   SCSI).  Nobody wants to see some artificial "x:y:z" for her/his
>   ATAPI device (it has always annoyed me in Windows), not to say
>   that the majority of desktop users have absolutely no idea of meaning
>   of these numbers.

This is called integration and it is done by Linux e.g. for 1394 and USB SCSI 
devices. So why not for ATAPI?


> * ide-* drivers for ATAPI devices are needed (some devices just doesn't
>   work with ide-scsi ATM) so please accept this fact that we cannot just
>   now simply switch over everything to using ide-scsi and we have to use
>   SG_IO ioctl for ide-cd (and ide-{floppy,tape} if anybody cares to add
>   support for it).  I'm not saying this won't change in future but this requires
>   doing actual work and people seem to be more interested in discussing
>   stupid naming issues than doing it so...

Well, the problem with ide-scsi is not a general one but caused by a simple
bug that needs to be fixed.


> > So why do people try to convince me that there is a need to avoid the standard
> > SCSI protocol stack because a PC might have only ATAPI?
>
> SCSI protocol stack is far too Parallel SCSI centric (vide SAS flamewar).
> Once again this is Linux problem which will get fixed with time or will fix
> itself if we switch to libata for PATA.

If this is true for Linux, it should be fixed. But this is not a general 
problem.

> > Major OS implementations use a unique view on SCSI (MS-win [*], FreeBSD, Solaris,
> > ...). Why do people believe that Linux needs to be different? What does it buy
> > you to go this way?
>
> Linux needs to be better, no? ;-)

In case that Linux would offer better methods, I would not complain.


> > If the Linux folks could give technical based explanations for the questions
> > from above and if they would create a new completely orthogonal view on SCSI [*]
> > I had no problem. But up to now, the only answer was: "We do it this
> > way because we do it this way".
>
> The answer is - we do this this way because of historical reasons and we
> simply lack resources to change it immediately (be it your "everything is
> SCSI" or mine "block layer devices claiming supported transport types").

This is obviously not true: There _was_ (and still is) a useful implementation 
with minor bugs. But instead of fixing the minor bugs, a lot of work has been 
done to introduce a new and unneded new interface.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
