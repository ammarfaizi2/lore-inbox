Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbQLHIHo>; Fri, 8 Dec 2000 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbQLHIHf>; Fri, 8 Dec 2000 03:07:35 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:42666 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130781AbQLHIHV>; Fri, 8 Dec 2000 03:07:21 -0500
Message-Id: <5.0.2.1.2.20001208072533.03fd97d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 08 Dec 2000 07:37:55 +0000
To: Peter Samuelson <peter@cadcamlab.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] NTFS repair tools
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <14896.31327.179696.632616@wire.cadcamlab.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>
 <20001207221347.R6567@cadcamlab.org>
 <3A3066EC.3B657570@timpanogas.org>
 <20001208005337.A26577@alcove.wittsend.com>
 <20001207230407.S6567@cadcamlab.org>
 <3A306CE4.47B366B0@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hearing how many people trash their partition I would agree to comment out 
the NTFS write option altogether. I will make a patch for both 2.4.0-testX 
and 2.2.18latest and send them off to Linus/Alan over the weekend if no one 
beats me to it.

Considering that people are blatantly ignoring all our warnings this might 
be the Right Thing(TM) as it is easy enough to activate the option if 
someone really wants/needs to use it. That should hopefully lower the 
amount of incidents with people trashing their partitions[1][2].

Anton

[1] On the other hand it might not help much as people might just uncomment 
it and go ahead using it, but there is a limit to how far we can go without 
taking out the write part of the driver altogether! Which might actually 
not be a Bad Thing(TM) were it not for the fact that having the write 
support can actually help in fixing a trashed partition when people know 
what they are doing...i.e. when they know what they can do safely and what 
not. - It's saved me from loosing 10Gb+ of non-backed up data in the past!

[2] My NTFS repair utility is under development albeit very slowly which 
should help a little bit once I have a stable release. - Initial release is 
yet TBA as there are some very strange bugs in it at the moment, which 
might actually turn out to be bugs in the compiler/libc/kernel as the 
program runs fine sometimes and sometimes corrupts the partitions slightly, 
operating on the _exact_ same partition with the _exact_ same data on it! - 
Anyway, I am not releasing this to the public before I have figured out WTH 
is going on...

At 06:06 08/12/2000, Peter Samuelson wrote:
>[Jeff Merkey]
> > Please consider the attached patch to make it a little bit harder for
> > folks to enable NTFS Write Support under Linux until it can get fixed
> > properly.
>
>Hey!  It was a joke!  A better way would be just to comment out the
>CONFIG_NTFS_RW line entirely.  Actually, I think that *would* be a good
>idea.  Anyone who has any business messing with NTFS_RW is more than
>capable of editing Config.in.
>
>Peter
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
