Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbVLGWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbVLGWpq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbVLGWpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:45:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31981 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030398AbVLGWpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:45:45 -0500
Date: Wed, 7 Dec 2005 23:43:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207224323.GB3204@elf.ucw.cz>
References: <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com> <20051207131454.GA16558@srcf.ucam.org> <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com> <20051207143337.GA16938@srcf.ucam.org> <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com> <1133970074.544.69.camel@localhost.localdomain> <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com> <1133918523.2936.12.camel@sli10-mobl.sh.intel.com> <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com> <1133994916.544.102.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133994916.544.102.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > PS1 Please don't use taskfile_lib_get_identify(), drive->id
> > should contain valid ID - if it doesn't it is a BUG.
> 
> If someone swapped the drive while suspended that isnt true. OTOH I'm
> not sure what the hell you'd do if that was the case and you are using
> drivers/ide right now.

If someone swapped the drive while runtime, it would not be true, too,
I guess. But that would be stupid thing to do. Swapping drive during
suspend-to-RAM would be similary stupid. During suspend-to-disk, it
might theoretically work, but we have big warnings saying "don't do
that".

								Pavel
-- 
Thanks, Sharp!
