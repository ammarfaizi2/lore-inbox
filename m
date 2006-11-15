Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966119AbWKOEBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119AbWKOEBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966479AbWKOEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:01:49 -0500
Received: from mx1.mail.ru ([194.67.23.121]:52054 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S966119AbWKOEBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:01:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Date: Wed, 15 Nov 2006 07:01:37 +0300
User-Agent: KMail/1.9.5
Cc: Stefan Seyfried <seife@suse.de>, Zan Lynx <zlynx@acm.org>,
       linux-kernel@vger.kernel.org
References: <200611121436.46436.arvidjaar@mail.ru> <200611142347.28571.arvidjaar@mail.ru> <20061114225736.GB2676@elf.ucw.cz>
In-Reply-To: <20061114225736.GB2676@elf.ucw.cz>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611150701.41595.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 15 November 2006 01:57, Pavel Machek wrote:
> On Tue 2006-11-14 23:47:27, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Tuesday 14 November 2006 17:23, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > Maybe its a journal size thing, you could try "sync" before
> > > > > > suspend and see if it helps.
> > > > >
> > > > > We already sync inside the kernel, it does not help here, though.
> > > > > Blockdev freezing might help.
> > > >
> > > > is there patch applicable to vanilla kernel? After repairing reiser
> > > > several times (due to hard lockups during suspend-to-RAM) that sounds
> > > > even more interesting.
> > >
> > > Could you do the test Stefan asked? I do not think you'll kill
> > > reiserfs by single forced powerdown.
> >
> > well, I did it accidentally :) (forgot to plug in power and after 2 hours
> > on battery notebook simply switched off) and yes, there was some
> > noticeable delay loading grub. I also tried fs freezer without any
> > visible effect. The patches from mm I applied to vanilla kernel:
> >
> > add-include-linux-freezerh-and-move-definitions-from.patch
> > swsusp-cleanup-whitespace-in-freezer-output.patch
> > swsusp-freeze-filesystems-during-suspend-rev-2.patch
> > swsusp-thaw-userspace-and-kernel-space-separately.patch
> >
> > Do I need some more patches for this to work?
>
> I guess reiserfs would need to respond to filesystem freezing.
>

OK the I guess it would have not worked in mm either. As far as I can tell the 
only FS supporting it so far is XFS.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFWpElR6LMutpd94wRApSWAJ0Wm2Yey6k0Lf0tMO5gBsOBYS5qLACgw8Xj
1rTy08rdsktGkvneKrweENM=
=xUbx
-----END PGP SIGNATURE-----
