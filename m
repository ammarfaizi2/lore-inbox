Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCGVcc>; Thu, 7 Mar 2002 16:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292752AbSCGVcX>; Thu, 7 Mar 2002 16:32:23 -0500
Received: from onyx-dial-233.ras.ind.net ([157.91.4.233]:59779 "EHLO
	orb.sphere.org") by vger.kernel.org with ESMTP id <S285692AbSCGVcT>;
	Thu, 7 Mar 2002 16:32:19 -0500
Subject: RE: ext3 and undeletion
From: Patrick Lynch <plynch@sphere.org>
To: "Rose, Billy" <wrose@loislaw.com>
Cc: "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        Pavel Machek <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD06307869@loisexc2.loislaw.com>
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD06307869@loisexc2.loislaw.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 16:30:25 -0500
Message-Id: <1015536627.23070.24.camel@plynch.noc.tmpw.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm taking an idea from the NetApp filer and using LVM to solve these
issues.  I'm hoping it will work as planned and not lose too much
performance.  I am going to create snapshots of certain partitions with
LVM at different time indexes.  I will use these snapshots to recover
lost data and to backup to tape.


On Tue, 2002-03-05 at 18:04, Rose, Billy wrote:
> To me, Linux is about freedom. As we all know, freedom comes with a price.
> My company has users that sit on Win9x boxes and use Explorer to connect to
> a set of Netware boxes. These boxes house critical data. I didn't create
> this system, it grew to what it is before my time. If it were up to me, all
> of the users would be running Emacs or some other great editor (vim is my
> favorite), and connect to a Linux machine via CVS with a Linux box to alter
> files so there is little chance they could crap out the file system, or
> delete files without knowing it. Explorer is one of those M$ monsters that,
> under the right circumstances, grabs an entire tree and grinds it up into
> the digital void. The users in question are at these moments little more
> than automatons from editing hundreds, perhaps even a thousand, files in
> some 8 hour span of time. These users don't even have the DOS prompt in
> their Start menu, let alone the time to mess with it. Bottom line: Linux is
> not being used for file servers in my company because this feature is not
> present. We are _not_ talking about a windblows trashcan here, we are
> talking about short term enterprise class file recovery as implemented in
> Netware. This was my intention when I brought the whole issue up on this
> list. We don't need a windows garbage can (unless you mean literally :), we
> need file recovery at the sysadmin level without going to the tapes as
> often. In order for Linux to take over the planet (my dream), then all of
> the features that keep companies tied to an OS needs to be addressed. This
> issue is one such company tie.
> 
> Billy Rose
> 
> P.S. I got 2981.88 BogoMIPS today from a new install of RedHat 7.2 on a P4
> 1.5Ghz!
> 
> -----Original Message-----
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
> Sent: Tuesday, March 05, 2002 4:07 PM
> To: Pavel Machek
> Cc: Andreas Ferber; linux-kernel@vger.kernel.org
> Subject: Re: ext3 and undeletion
> 
> 
> On Mon, 4 Mar 2002, Pavel Machek wrote:
> 
> > Hi
> > > > All the deleted files, with the correct path(s), are now in the
> > > > top directory file the file-system ../lost+found directory. They
> > > > are still owned by the original user, still subject to the same
> > > > quota.
> > > 
> > > And what about:
> > > 
> > > - Luser rm's "foo.c"
> > > - Luser starts working on new version of "foo.c"
> > > - Luser recognizes, that the old version was better
> > > - Luser rm's new "foo.c"
> > > - Luser tries to unrm the old "foo.c" -> *bang*
> > > 
> > > Trust me, there /will/ be a luser who tries to do it this way. If
> > > teaching lusers were enough, you'd have no need for an unrm at all.
> > 
> > You don't consider me a luser, right?
> 
> Nope.
> 
> Some newbees think that Windoze 'send-to-the-wastebasket' is a kernel-
> level "safe-delete". It's just some ^&$)##*@*) program that slows most
> of us down.
> 
> Even Windows/Professional/2000 (NT) developers knew that it was
> garbage. If you've figured out how to get to the CMD prompt, just
> type:
> 
> cd \
> rm -r *.*
>  |  |   |______ They still have dots
>  |  |__________ Yes, even "folders" <coff, coff>
>  |_____________ What do you expect for a stolen OS? Yes, `rm` instead of
>                 del, following the Unix pathname tradition.
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).
> 
> 	Bill Gates? Who?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


plynch@sphere.org

"Communications without intelligence is noise;
 Intelligence without communications is irrelevant." 
   - Gen Alfred. M. Gray, USMC                                  .

