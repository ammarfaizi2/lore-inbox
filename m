Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRJUViN>; Sun, 21 Oct 2001 17:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJUViD>; Sun, 21 Oct 2001 17:38:03 -0400
Received: from destructo.gearboxsoftware.com ([12.37.36.2]:49426 "HELO
	gearboxsoftware.com") by vger.kernel.org with SMTP
	id <S270619AbRJUVhw> convert rfc822-to-8bit; Sun, 21 Oct 2001 17:37:52 -0400
From: "Sean Cavanaugh" <seanc@gearboxsoftware.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: The new X-Kernel !
Date: Sun, 21 Oct 2001 16:38:26 -0500
Message-ID: <000801c15a78$b79a4280$150a10ac@gearboxsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This side thread is funny, everyone here is thinking too much like a
developer :)

Normal users really don't need to see the startup message spam on boot,
unless there is an error (at which point it should be able to present
the error to the user).  Any kind of of progress indicator' s really
more for feedback that the boot is proceeding ok.  The fact the boot
sequence isn't even interactive should also be a big hint that it isn't
really necessary (except for kernel and driver developers).

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Gábor Lénárt
Sent: Sunday, October 21, 2001 3:04 PM
To: john slee
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !


On Mon, Oct 22, 2001 at 01:37:47AM +1000, john slee wrote:
> On Sun, Oct 21, 2001 at 02:54:15PM +0200, Tim Jansen wrote:
> > But what the kernel COULD do is include something like the Linux 
> > Progress
> > Patch (http://lpp.freelords.org/). It replaces the text output of
the kernel 
> > with graphics and a progress bar, so people are not frightened by
cryptic 
> > text output while booting.
> 
> this is something for distributions to do...  even if the world turned

> inside out and it got included there'd be endless flamewars (and
> patches) concerning what colour the progress bar should be by default.
> 
> i read an interesting essay about that sort of thing on a freebsd list

> once - search on freebsd archives for "garden shed" or similar.

Errrm ;-) It's very bad thing to hide boot messages even for novice
users. They can't bugreport in this way ... I thing the best way would
be the penguin logo at the top, and some pixel progress bar under Tux.
The messages should remain IMHO. But this bar indicator confuses me. How
do you calculate the remaining percentage? And of course this is kernel
boot only. After init, you can start costum process to show an indicator
bar to messure remaining tasks before hitting
xdm/kdm/gdm/login/whatever.

But IMHO *hiding* kernel messages is the worst thing you can do ...
Probably a versatile parameterable boot logo + indicator setting tool
should be implemented (and of course the right code to the kernel to
render them on startup). It can include (let's say:)

position and size of text area inside the screen (kernel messages)
background picture progress bar indicator attributes, position

and so on

Again: I'm AGAINST this stupid thing but if many user wants  ... However
HIDING kernel messages would be bad move ....

Major distributions include default kernels patched for nice boot
screens, so IMHO it isn't an issue for us. A user how can COMPILE kernel
himself probably does not want gfx-only boot screens .... or at least he
can patch kernel before compile it.

- Gabor
-

