Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272475AbRH3VQ4>; Thu, 30 Aug 2001 17:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272476AbRH3VQr>; Thu, 30 Aug 2001 17:16:47 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:15890 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272474AbRH3VQ3>; Thu, 30 Aug 2001 17:16:29 -0400
Message-ID: <3B8EAD35.5695B30B@namesys.com>
Date: Fri, 31 Aug 2001 01:16:37 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Nikita Danilov <Nikita@namesys.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, research@suse.de
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> >  > For recovering broken machine, I'd like to mount without replaying journal.
> >
> > You cannot mount without replaying even in read-only mode, because
> > file-system meta-data are possibly inconsistent.
> 
> Then suse's  use of reiserfs is pretty b0rken. Putting reiserfsck on /
> partition is pretty useless -- if it crashes during mount you can't
> repair it.

Every filesystem has this problem, if the root directory gets hosed you have to
use the CDROM.
Booting from CDROM with SuSE is not such a problem.

> 
> If reiserfsck detects errors on /, you can't repair them because
> reiserfsck is on that partition. Ouch.
> 
> >  > [reiserfs panics while replaying journal; seems there are still some bugs
> >  > hidden in there]. Unfortunately, "nolog" option does not seem imlemented.
> >
> > There is a patch allowing to mount reiserfs if there was io error during
> > journal replay on mount. It is included into 2.4.9-ac* tree (it was sent
> > to Linus several times, but this did not avail).
> 
> I already repaired my system -- had to install another copy of suse to
> another partition :-(.


I boot from CDROM when I have such problems.

> 
> > Can you send to Reiserfs mail-list <Reiserfs-List@Namesys.COM> more
> > detailed information about your case, like ksymoopsed stack trace,
> > etc.
> 
> No stack trace, sorry. It refused to mount saying that attempting to
> write into log block.. That's panic. Reiserfsck is not usable in such
> case, because ... how do you run reiserfsck from partition you can't
> mount?
>                                                                 Pavel
> --
> The best software in life is free (not shareware)!              Pavel
> GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
