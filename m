Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWBHVO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWBHVO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWBHVO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:14:57 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:52892 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964987AbWBHVO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:14:57 -0500
Date: Wed, 8 Feb 2006 16:14:55 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060208211455.GC2480@csclub.uwaterloo.ca>
References: <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr> <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208210219.GB9166@DervishD>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:02:19PM +0100, DervishD wrote:
>     Joerg, I know you're going to ignore this email just as you
> ignored other emails I sent you in the past regarding cdrecord, the
> annoying numbering scheme and the stupid "your DMA speed is too slow,
> you cannot write at more than 12x" (fortunately, my CD writer doesn't
> know that and writes correctly at 50x and even more). Anyway, I want
> to tell you that I've been a cdrecord _real_ user for more than 5
> years, and while I consider your work valuable and clever, you have
> NO respect for anybody who doesn't think the same as you. I know many
> cdrecord users (_real_ ones, IMHO), and ALL of them think that the
> numbering scheme to access their writers is CRAP: crappy design,
> crappy coding and crappy user interface.
> 
>     I'm going to be a bit more respectful: I don't consider it crap.
> I just consider it bad. Bad because cdrecord is the only program in
> my system that forces me to think what the heck is the correct number
> for my CD writer (which is /dev/cdrw in my system) or which number do
> I have to use to READ a CD image using "readcd" (instead of /dev/cdrw
> or /dev/dvd, or even the ugly /dev/hdc). I end up using "-scanbus"
> everytime I use a system which is not mine, and that's bad, because
> most of those systems have /dev/cdrw, or /dev/cdrecorder, or
> something like that.
> 
>     Joerg, the problem is that you never listen to things you don't
> like. I understand, because I sometimes do exactly the same, but I
> don't maintain a program with thousand of users...

I agree entirely and wish I could have put it that well.

>     cdrecord is GPL, so in the end nobody has the right to ask you to
> modify it in ways you don't like or you don't want it to. That goes
> with free software: you don't pay, you don't have the right to ask
> for things. But, how about trying to listen to third parties? I mean,
> you are probably OK ignoring my suggestions, I am probably a mediocre
> programmer, but... do you _really_ think that you are more clever
> than ALL the programmers in this mailing list? Do you _really_ think
> that you have the correct answer and that ALL of them are plainly
> wrong? Do you _REALLY_ think that EVERYBODY is wrong *except* you in
> this issue about the user interface?

Hmm, perhaps what should be done is that someone needs to write and
maintain a patch that linux users can apply to cdrecord (since other OSs
are different and hence have no reason to use such a patch), to make it
behave in a manner which is sane on linux.  It should of course be
clearly marked as having been changed in such a way.  It should use udev
if available and HAL and whatever else is appropriate on a modern linux
system, and if on an old system it should at least not break the
interfaces that already worked on those systems in cdrecord.

cdrecord does a wonderful job writing CDs, once you get the silly
command line syntax right and figure out which device option it wants
you to tell it to access your write.  I still find the syntax of
driveropts=option=value is a bit odd, although the linux kernel does the
same thing for some kernel boot arguments as far as I recall, so who am
I to argue.

growisofs has a lovely simple interface, although it probably only has
about 1% as many options as cdrecord.  Perhaps there are just a lot
fewer weird variations on DVDs so far so less options are needed, or
perhaps there are a lot more options but they are all secret and in the
source code.  I haven't needed to use them at least.

Len Sorensen
