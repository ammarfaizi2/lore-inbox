Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSCTOMf>; Wed, 20 Mar 2002 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSCTOMZ>; Wed, 20 Mar 2002 09:12:25 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:9138 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S286343AbSCTOMP>; Wed, 20 Mar 2002 09:12:15 -0500
Date: Wed, 20 Mar 2002 14:12:13 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: NTFS+koi8-r: "file exists but can't be statted"
In-Reply-To: <200203200922.g2K9M0X03611@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.SOL.3.96.1020320135955.14364A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Denis Vlasenko wrote:
> [I can't reach you directly, hope you read this on lkml]

Oh? Does the email bounce? What error does it give you? An alternative is
to find me on IRC on irc.openprojects.net in #ntfs channel.

> Today I sorted out UNICODE -> koi8-r filename translation
> and now I'm able to mount NTFS volumes and see Cyrillic filenames.
> However, when I enter my MP3 fold^Wdirectory in Midnight Commander
> it complains that it cannot stat two files (DDT-Rain.MP3 and 
> DDT-Last_autumn.MP3, actual names are in Cyrillic). Other files
> (there are lots of them) are visible.
> 
> My mount options are:
> ro,iocharset=koi8-r,noatime
> 
> I can provide any additional info you need, just ask.

Ok, I have had a report from someone using cp950 (Big5 Chineese I think) 
who had such problems as well but he didn't last long enough to find the
problem and I haven't had time to try an reproduce it myself. Could you
create a .zip in Windows containing a few of those files? Perhaps one that
works and one that doesn't and send it to me? (If email is a problem,
visit on #ntfs, or give me a URL to download the zip from or try my
alternate email address aia21@mole.bio.cam.ac.uk.) I can then expand the
.zip in Windows and then hopefully I will see the same problem as you
do...

Hopefully I will do in which case I will trace the problem, if not, you
will need to enable debugging output in ntfs, and we will have to trace
the problem...

One thing that would interest me is if the new ntfs driver (ntfs tng) will
work ok (which it should). If you have BitKeeper you can get a clone of
linux-ntfs.bkbits.net/ntfs-tng-2.5. This is a child of
linux.bkbits.net/linux-2.5 so if you have that already you can just pull
from the tng repository above... If you are not using bitkeeper let me
know and I will create patch for you for the current kernel.

Just FYI ntfs tng is now considered fully functional and implements all
features the old driver did (read-only, no write code present). It also
still supports the old mount options (even though some are deprecated), so
no need to change /etc/fstab.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

