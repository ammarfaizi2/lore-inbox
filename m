Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVK2ALU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVK2ALU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVK2ALU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:11:20 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:12426 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932311AbVK2ALT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:11:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MUdlS8f3nQTxdrd2CxbuRgGMzfj6U0I8wYc+rJXMOSU9yKASfbXXRmt/dEFUoAnJjR3ouzOfgXTU45CEarhSxAxMzyxlxjnJl0LHPLllrDec4+sD1uqVDGp7wet3w/zJ0Tc0zTscwlxoWNtJF9dpE8hJzsor3cDar5qzeO+p5FM=
Message-ID: <5bdc1c8b0511281611n606cf38av5ffcdae7b57e8b0e@mail.gmail.com>
Date: Mon, 28 Nov 2005 16:11:17 -0800
From: Mark Knecht <markknecht@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: umount
Cc: Patrick McFarland <diablod3@gmail.com>, gcoady@gmail.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511281229560.8176@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511272154.jARLsBb11446@apps.cwi.nl>
	 <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com>
	 <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com>
	 <200511272101.07771.diablod3@gmail.com> <20051128071535.GB3638@voodoo>
	 <5bdc1c8b0511280920i424cb9e7t50399b4f12abc154@mail.gmail.com>
	 <Pine.LNX.4.61.0511281229560.8176@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Mon, 28 Nov 2005, Mark Knecht wrote:
>
> > On 11/27/05, Jim Crilly <jim@why.dont.jablowme.net> wrote:
> >> On 11/27/05 09:01:07PM -0500, Patrick McFarland wrote:
> >>> On Sunday 27 November 2005 20:42, Mark Knecht wrote:
> >>>> On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> >>>>> It leaves me with a little distrust of linux' handling of non-locked
> >>>>> removable media (as opposed to lockable media like a zipdisk or cdrom).
> >>>>>
> >>>>> Grant.
> >>>>
> >>>> Under Windows, if a 1394 drive is unplugged without unmounting, it you
> >>>> get a pop up dialog on screen telling you that data may be lost, etc.
> >>>> while under any of the main environments I've tried under Linux
> >>>> (Gnome, KDE, fluxbox) there are no such messages to the user. I have
> >>>> not investigated log files very deeply, other than to say that dmesg
> >>>> will show the drive going away but doesn't say it was a problem.
> >>>>
> >>>> I realize it's probably 100x more difficult to do this under Linux, at
> >>>> least at the gui level, but I agree with your main point that my trust
> >>>> factor is just a bit lower here.
> >>>
> >>> No, WIndows says that because it is unable to mount a partition as sync,
> >>> unlike Linux. Linux Desktop Environments simply don't tell the user because
> >>> no data is lost if they unplug the media.
> >>
> >> Both of those statements are not true.
> >
> > Jim,
> >   I'm not clear if 'both statements' included any of mine or not? :-)
> >
> >   You discussed the event I was thinking of. I am writing to a 1394
> > drive, bus powered or not, and while the write is occuring I unplug
> > the cable. Clearly the data being written is not going to finish, and
> > that's expected, but the 'reduced confidence' issue is that I'm not
> > told directly of the event. Granted I'll eventually discover it in
> > some indrect manner, like a GUI action failing or something timing
> > out. However in Windows I do appreciate the clear message that this
> > has happened.
> >
> > Thanks,
> > Mark
> >
>
> Doesn't your GUI show a 'console' window?

No, Gnome does not, by default, show a console window. Many GUI based
users like me, coming from Windows a couple of years ago, prefer to
remain GUI based. I don't open termainals except to build kernels and
do system admin stuff. Most all of my day to day like is spent in the
GUI or in graphical applications. I move files, change permissions,
etc., in GUI apps, at least most of the time. I know that's going to
be pretty foreign to many old timers here, and that's cool, but I'm
just saying that this is the way it is for me.

Please note that I didn't say the info wasn't available. The info is
available in dmesg and I know to go look there. The point I was making
is that as a user I get no specific GUI level messages about this sort
of problem like I do in Windows and I think as more Windows folks come
to Linux there will be times they do not know what's going on.

<SNIP>
>
> Although the messages may 'come from' the kernel, they are not
> produced by the kernel. It is not the responsibility of the kernel
> to display messages.

Yes, I understand that. As I said in my first post, I think it would
be quite difficult to guarantee that every GUI environment running
under a Linux kernel handle stuff like this. I think it's enough that
the kernel makes the message available to the GUI developers. I would
hope that one day the GUI developers see the value of messages like
this from a user POV. To often the developers don't see things the way
new users see (or don't see!) things so the learning curve is pretty
steep.

Maybe one thing kernel messages could do is identify which ones really
should be driven up to the user level, if possible. I wouldn't have a
clue what to do for someone not using a GUI, but getting a dialog
based message about a system hardware problem seems pretty freindly to
a user like me.

Thanks,
Mark
