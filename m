Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbSJFJgs>; Sun, 6 Oct 2002 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSJFJgs>; Sun, 6 Oct 2002 05:36:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30468 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263365AbSJFJgr>; Sun, 6 Oct 2002 05:36:47 -0400
Date: Sun, 6 Oct 2002 10:42:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Rob Landley <landley@trommello.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021006104219.A27487@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <3D9F9CD5.CEB61219@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9F9CD5.CEB61219@digeo.com>; from akpm@digeo.com on Sat, Oct 05, 2002 at 07:15:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 07:15:49PM -0700, Andrew Morton wrote:
> It's not all kernel though.  Application (KDE) startup is *slow*,
> even when zero I/O is performed.  Presumably because of the vtable
> dynamic linking thing.  I'm not sure how the prelinking work is
> getting along, but the initial figures I saw on that indicated
> that the benefit may not be sufficient.

As a mad guy who runs gnome on an ARM box virtually every day, and
compared the speed of gnome during startup and in operation with
traditional X applications, gnome is severely lacking in speed
and "snappyness".

Eg, a pure X setup starts up in less than 5 seconds.  With gnome,
you're looking at around 30.  Gnome 1.2 was slower than Gnome 1.4.
I haven't tested Gnome 2 yet.

Flipping around between workspaces is something I do regularly (6 of
them.)  With a fairly old (1997) fvwm + fvwmpager + gnome 1.2 its
adequately fast - less than 1 second.  With sawfish + gnome 1.4,
even the refresh of other applications is noticably slower, and with
fvwm + gnome 1.4 its unbearable (because the gnome panel is obtaining
a complete list of windows and clients with the X server grabbed, and
quering various properties - because fvwm isn't gnome-compliant, the
panel can't ask the wm.)

The start up of rxvt - less than 1 second.  The start up of
gnome-terminal - around 15-20 seconds.

What I'm not saying here is that anything one thing sucks (except maybe
ARM on a desktop box running Gnome.)  The point I'm trying to make is
that you can give the kernel as much "interactive" feel as you like, but
until user space gets It Right (tm), the kernel isn't really going to
make one blind bit of difference to the "feel" the user experiences.

I just wish someone would take away all the gnome developers high
performance machines and give them slow old 486's.  8)

(PS, before the "use the source" mob start running about, I'm a full time
kernel hacker.  To get up to speed on gnome to fix this would require me
to leave the kernel for a considerable amount of time.  This isn't going
to happen any time soon; there is only a certain number of hours in a day.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

