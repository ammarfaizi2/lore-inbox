Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285492AbRLSU2W>; Wed, 19 Dec 2001 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285459AbRLSUZd>; Wed, 19 Dec 2001 15:25:33 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:32178 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S285461AbRLSUYN> convert rfc822-to-8bit; Wed, 19 Dec 2001 15:24:13 -0500
Date: Wed, 19 Dec 2001 15:23:53 -0500 (EST)
From: Asheesh Laroia <PaulProteus@technologist.com>
X-X-Sender: <paulproteus@renaissance.workgroup>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Diego Calleja <grundig@teleline.es>, Hans Reiser <reiser@namesys.com>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] Re: Reiserfs corruption on 2.4.17-rc1!
In-Reply-To: <200112190118.fBJ1IHb92286@spf5.us4.outblaze.com>
Message-ID: <Pine.LNX.4.33.0112191517320.6985-100000@renaissance.workgroup>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was exactly the problem I had.  It was solved by a getting a new
superblock via debugreiserfs, as patched by Yury Yu. Rupasov.  See the
thread at the beginning of the month, "Filesystem Corrupted".

It was resolved, again, by the patched debugreiserfs pre-release.  Run a
recent debugreiserfs and post the output.  It should give you the location
of a superblock backup.

-- Asheesh.

On Wed, 19 Dec 2001, Dieter [iso-8859-15] Nützel wrote:

> On Tue, 18 Dec 2001 21:35:40  Diego Calleja wrote:
> > On Tue, 18 Dec 2001 14:08:42 Hans Reiser wrote:
> > > Nikita Danilov wrote:
> > >
> > > >Diego Calleja writes:
> > > >
> > > >
> > > > Unfortunately this looks like "standard" reiserfs tree corruption.
> > > > Take
> > > >
> > A little more precisely: nobody at Namesys has ever hit this bug using
> > our known healthy hardware.  Various users have.  Bad hardware (e.g
> > media defect) could cause this bug, and maybe cause it in just about the
> > number of users that we see it in.   This does NOT mean that it is due
> > to bad hardware.  If you, or anyone, can reproduce this bug, we would be
> > very interested to learn how to do so.
> >
> > Hans
> > I'm afraid I can't. It just happened. I only can describe what was I doing,
> > although it must be useless....
> > The system booted with linux 2.4.17-rc1. I was readin mail in kde
> >  when  I tried to mount my vfat partition on /win to listen mp3. (as a
> > normal
> >  user, of course). But  I couldn't mount it. Reason?:
> >         ls: mtab: permission denied
> > Then I log as root, but ls -l /etc/mtab said:
> >         ls: mtab: permission denied
> > any chmod in /etc/mtab: (as root)
> >        chmod: getting attributes of mtab: Permission denied
> >
> >  After this, the filesystem started to fail a lot in all other programs
> >  , the problem is in some files in /etc.
>
> Are you sure, that you had a "clean" 2.4.17-rc1 running???
>
> This smells like the first broken P-reiser_stats_fix.patch, to me.
> Which (ReiserFS) patches had you applied?
>
> If the former is the true, go back to an older kernel version and hope
> reiserfsck will do it for you. When reiserfsck fails reformat.
>
> Let's take this from lk, please. Reiserfs list is the right place.
>
> Regards,
> 	Dieter
>
>
>

-- 
Democracy is good.  I say this because other systems are worse.
		-- Jawaharlal Nehru



