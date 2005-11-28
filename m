Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVK1RUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVK1RUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVK1RUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:20:07 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:49434 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932131AbVK1RUF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:20:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GmZsbHU5Zdmqq35xUl9Lz2Wilt0IJpq8lYI5nJnepr5zuhm70/xcuDNSE7m8g6ntNg5ouX4D6ylfkMJvA6zKtE0SVreanxF+YDoPFIWqbyr3Rv5OgwKmt1t93GO9VuGe7sk4/2GH5f3jfFRE14GMwPQPpGEfrL1sZmCTxvWP6Bs=
Message-ID: <5bdc1c8b0511280920i424cb9e7t50399b4f12abc154@mail.gmail.com>
Date: Mon, 28 Nov 2005 09:20:02 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Patrick McFarland <diablod3@gmail.com>, Mark Knecht <markknecht@gmail.com>,
       gcoady@gmail.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: umount
In-Reply-To: <20051128071535.GB3638@voodoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511272154.jARLsBb11446@apps.cwi.nl>
	 <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com>
	 <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com>
	 <200511272101.07771.diablod3@gmail.com> <20051128071535.GB3638@voodoo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05, Jim Crilly <jim@why.dont.jablowme.net> wrote:
> On 11/27/05 09:01:07PM -0500, Patrick McFarland wrote:
> > On Sunday 27 November 2005 20:42, Mark Knecht wrote:
> > > On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> > > > It leaves me with a little distrust of linux' handling of non-locked
> > > > removable media (as opposed to lockable media like a zipdisk or cdrom).
> > > >
> > > > Grant.
> > >
> > > Under Windows, if a 1394 drive is unplugged without unmounting, it you
> > > get a pop up dialog on screen telling you that data may be lost, etc.
> > > while under any of the main environments I've tried under Linux
> > > (Gnome, KDE, fluxbox) there are no such messages to the user. I have
> > > not investigated log files very deeply, other than to say that dmesg
> > > will show the drive going away but doesn't say it was a problem.
> > >
> > > I realize it's probably 100x more difficult to do this under Linux, at
> > > least at the gui level, but I agree with your main point that my trust
> > > factor is just a bit lower here.
> >
> > No, WIndows says that because it is unable to mount a partition as sync,
> > unlike Linux. Linux Desktop Environments simply don't tell the user because
> > no data is lost if they unplug the media.
>
> Both of those statements are not true.

Jim,
   I'm not clear if 'both statements' included any of mine or not? :-)

   You discussed the event I was thinking of. I am writing to a 1394
drive, bus powered or not, and while the write is occuring I unplug
the cable. Clearly the data being written is not going to finish, and
that's expected, but the 'reduced confidence' issue is that I'm not
told directly of the event. Granted I'll eventually discover it in
some indrect manner, like a GUI action failing or something timing
out. However in Windows I do appreciate the clear message that this
has happened.

Thanks,
Mark

> At least in XP removable media is
> mounted sync by default, you have to go into the device manager and toggle
> a radio button to "optimize for performance" before it'll do async writes.
> I think the setting was the opposite in Win2K but I can't say for sure.
>
> And even with sync writes it's possible to unplug the drive before the
> write completes and if the drive is powered by USB there's no way to know
> just how much data made it to disk. Ideally the kernel would emit some
> message so that HAL or something can catch it and popup a message or
> something.
>
>
> Jim.
>
