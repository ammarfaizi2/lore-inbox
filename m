Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWEQNUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWEQNUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWEQNUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:20:15 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:63183 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932263AbWEQNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:20:14 -0400
Date: Wed, 17 May 2006 09:20:13 -0400
To: linux cbon <linuxcbon@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060517132013.GA23933@csclub.uwaterloo.ca>
References: <Pine.LNX.4.64.0605161513590.24814@blackbox.fnordora.org> <20060517114722.90648.qmail@web26603.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517114722.90648.qmail@web26603.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 01:47:22PM +0200, linux cbon wrote:
> X Window System has many problems affecting directly
> the kernel.
> 
> http://en.wikipedia.org/wiki/X_Window_System#Limitations_and_criticisms_of_X
> -Many current implementations of X manipulate the
> video hardware directly.

Not a problem with X, just with some implementations.

> -X deliberately contains no specification as to user
> interface or most inter-application communication.

Why should it?  Let someone else deal with that.  X has no business
getting involved in applications talking to each other.

> -The X protocol provides no facilities for handling
> sound,

True.  It is a display/input protocol.  There are other protocols
that handle remote sound.  There isn't really a reason they need to
be combined.  X is event driven.  Audio tends to require streams.  Very
different tasks.

> -Until recently, X did not include a good solution to
> print screen-displays. 

Hmm, I guess I never noticed.  Was this missed by anyone?  Screen
captures were just fine as far as I can tell.

> -One cannot currently detach an X client or session
> from one server and reattach it to another.

Some people have worked on ways to do that.  Given things like DGA and
shared memory and such, some applications simply can't be detached
unless the application was written to support some kind of shutdown the
gui and then go connect to another X server and start the gui again.

> I would add :
> -X needs to be root so it opens many security holes.

Some implementations need to be root.  I think it may be possible to run
a framebuffer based X without root, although you would also have to do
something about the keyboard and mouse drivers I imagine.

> -X has more code than the kernel and it is almost an
> OS in itself.

So?  That doesn't make it bad, it just has a lot of features and
includes a lot of utilities.

> -if a "closed-source" graphical card driver has
> security holes, what do you do ?
> etc.

Same as with anything else closed source.  This is not a flaw in X.

> Some people are working on replacement like Y windows
> :
> http://www.doc.ic.ac.uk/teaching/projects/Distinguished03/MarkThomas.pdf
> http://www.y-windows.org/
> 
> There are some questions like :
> - should the next generation window versions Y,Z etc.
> remain backward compatible with X ?
> I think they should start something better and simpler
> from scratch and not backward compatible.

Lack of application support (which requires backwards compatibility) is
what dooms projects.  If you don't want to be backwards compatible (just
through emulation is fine) then don't bother.  Other than a fun hobby it
won't go anywhere ever.  I think ALSA might have been doomed had it not
emulated OSS.  By allowing emulation it slowly has gained support from
applications as they were ready to start taking advantages of the new
and improved interface.  Linux evolves, which is why it's still here.
Starting from scratch almost never succeeds.

> - should the kernel remain pure "shell" or include
> some basic universal graphical universal window system
> ?
> I think second answer.

It should very much stay purely text based.  Lots of systems have no
graphics abilities at all, and run linux very well.  The simpler the
better for the kernel interface.  The less special hardware support it
needs to show stuff to the user the easier it is to fix problems.

Windows is majorly annoying and broken that way.  You can't really fix
anything if you can't boot as far as starting the GUI.

Len Sorensen
