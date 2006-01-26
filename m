Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWAZNvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWAZNvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWAZNvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:51:32 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:7901 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750816AbWAZNvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:51:32 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 14:50:14 +0100
To: schilling@fokus.fraunhofer.de, acahalan@gmail.com
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D396.nailE2X31OHFU@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
In-Reply-To: <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <acahalan@gmail.com> wrote:

> > Conclusion:
> >
> > 17 Platforms _need_ the addressing scheme libscg offers
> >
> > 5  Platforms _may_ use a different access method too.
> >
> > NOTE: Amongst the 6 plaforms that do not allow to even get a file descriptor
> > there is a modern OS like MacOS X
>
> You can't fool me, because I looked at the cdrecord source
> code and at the documented APIs for various OSes.

I am sorry to see that you did not look close enough...


> It's misleading to say that MacOS doesn't allow a file
> descriptor. MacOS has something similar to what Linux
> has, but not in the normal filesystem namespace. You
> specify a name to get a handle. Of course, on MacOS,
> Joerg also uses -scanbus to create nonsense.
>
> Names can be handled by Windows, FreeBSD, MacOS X,
> Linux, OpenBSD, Solaris, HP-UX, AIX, and IRIX.
> That's everything that isn't end-of-lifed.

Aha, so you like to state that MS-WIN is end-of-lifed?
Is this secret new information from Microsoft?

Solaris is not on this list, because the only way to send SCSI commands to any 
kind of SCSI target is by using my /dev/scg driver.

AIX is not on this list because the only way to send SCSI commands to any
target is by using the /dev/gsc driver from Mathew Jacob who is a former
Sun employee and who did get the idea for this driver from a talk with me 
during a visit at Sun in 1987.

FreeBSD is not on the list as it uses CAM, similar to BeOS (Zeta), 
OSF1 (True 64) and QNX.

IRIX is not on this list because it uses the same kind of interface as
e.g. HP-UX does

	snprintf(devname, sizeof (devname),
			"/dev/scsi/sc%dd%dl%d", busno, tgt, tlun);


Next try please....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
