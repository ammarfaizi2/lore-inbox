Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUAEEyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUAEEyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:54:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:2988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264401AbUAEExN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:53:13 -0500
Date: Sun, 4 Jan 2004 20:52:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401042043020.2162@home.osdl.org>
References: <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
 <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
 <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> > If nothing else, things like SATA will end up meaning that the device you 
> > were used to seeign as /dev/hdc will suddenly show up as /dev/scd0 
> > instead. Just because you changed the cabling while you upgraded to a 
> > newer version of your CD-ROM drive.
> 
> If I open the damn box, I sure as hell can be bothered to edit stuff in
> /etc...

Actually, not necessarily.

The thing is, _the_ most common reason I have for opening the box is that 
the effing thing started having problems.

At which point I want to just remove the disk, move it to another box, and 
boot up the other box.

And THAT is exactly the kind of situation where I sure as hell don't want
to care exactly where the disk was. I can't "prepare" for it by editing
files in /etc, since I don't know that the CPU fan or whatever is going to
die on me.

And this is _exactly_ why we should try to get away from device numbering
having any meaning. Because if we do this right, something like the CPU
fan dying, and me moving a disk to a new machine that has SATA (with the
disk having both SATA and PATA connectors), I shouldn't need to even
_think_ about it.

That's where "mount by label" does part of the job. But if the system is 
_always_ set up to do things like NFS exports according to some separate 
UUID, that too would "just work".

There's a lot to be said for "just work".  Even if sometimes it takes some 
pain when you break old (and broken) assumptions.

> > because "pine" still doesn't get UTF-8 right, and nobody is apparently
> > ever going to fix it. Oh, well. But at least I know I'm doing something
> > _wrong_, which in itself is a good thing.).
> 
> Heh.  Took you long enough - "using pine" should've been a dead giveaway
> from the very beginning ;-)

Those are them fighting words.

But since you brought it up: do you actually have anything else that can
open a remote IMAP file with a few thousand messages without taking ages
for it, and that you don't have to mouse around with? I'd like a graphical
interface for configuring stuff etc, but I sure as hell don't want to find
some f*ing icon to save a few messages that I selected in-order to my
"doit" queue or go to the next one, or pipe the thing to a shell-script,
or any number of things that are my actual _job_.

And the "no mousing" means that I don't want to have some popup window 
that asks me what file I want to save into or similar crap. I can type 
fast enough if I stay on the keyboard and can focus on one part of the 
screen, but if I have to switch my focus around, I'm a goner.

On a related matter, I'm probably a retard, but I've tried alternatives to
"trn" too, and there really aren't any. None of the graphical news readers
can show me one full page of threads, select the 3-4 threads from _that_
one page that I want (from the keyboard), and then kill _that_ one page.
Not the whole newsgroup: only the part that shows in the window at that
time.

In "trn", the magic command is capital-D, for "discard".

		Linus
