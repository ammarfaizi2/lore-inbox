Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVK1HPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVK1HPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 02:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVK1HPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 02:15:55 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:33553 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932110AbVK1HPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 02:15:54 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Mon, 28 Nov 2005 02:15:35 -0500
To: Patrick McFarland <diablod3@gmail.com>
Cc: Mark Knecht <markknecht@gmail.com>, gcoady@gmail.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: umount
Message-ID: <20051128071535.GB3638@voodoo>
Mail-Followup-To: Patrick McFarland <diablod3@gmail.com>,
	Mark Knecht <markknecht@gmail.com>, gcoady@gmail.com,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <200511272154.jARLsBb11446@apps.cwi.nl> <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com> <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com> <200511272101.07771.diablod3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511272101.07771.diablod3@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05 09:01:07PM -0500, Patrick McFarland wrote:
> On Sunday 27 November 2005 20:42, Mark Knecht wrote:
> > On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> > > It leaves me with a little distrust of linux' handling of non-locked
> > > removable media (as opposed to lockable media like a zipdisk or cdrom).
> > >
> > > Grant.
> >
> > Under Windows, if a 1394 drive is unplugged without unmounting, it you
> > get a pop up dialog on screen telling you that data may be lost, etc.
> > while under any of the main environments I've tried under Linux
> > (Gnome, KDE, fluxbox) there are no such messages to the user. I have
> > not investigated log files very deeply, other than to say that dmesg
> > will show the drive going away but doesn't say it was a problem.
> >
> > I realize it's probably 100x more difficult to do this under Linux, at
> > least at the gui level, but I agree with your main point that my trust
> > factor is just a bit lower here.
> 
> No, WIndows says that because it is unable to mount a partition as sync, 
> unlike Linux. Linux Desktop Environments simply don't tell the user because 
> no data is lost if they unplug the media.

Both of those statements are not true. At least in XP removable media is
mounted sync by default, you have to go into the device manager and toggle
a radio button to "optimize for performance" before it'll do async writes.
I think the setting was the opposite in Win2K but I can't say for sure.

And even with sync writes it's possible to unplug the drive before the
write completes and if the drive is powered by USB there's no way to know
just how much data made it to disk. Ideally the kernel would emit some
message so that HAL or something can catch it and popup a message or
something.

> 
> -- 
> Patrick "Diablo-D3" McFarland || diablod3@gmail.com
> "Computer games don't affect kids; I mean if Pac-Man affected us as kids,
> we'd all be running around in darkened rooms, munching magic pills and
> listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
> Inc, 1989
>

Jim.
