Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266050AbUBQGsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBQGsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:48:21 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:56327 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S266050AbUBQGsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:48:01 -0500
Date: Mon, 16 Feb 2004 22:47:55 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040217064755.GC9466@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040216155534.GA17323@mail.shareable.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Annoy potential new customers!  Reach new depths of advertising opportunism!  Contact this email address to see your product or service featured in this space.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 03:55:34PM +0000, Jamie Lokier wrote:
> jw schultz wrote:
> > If you have a filesystem with filenames that don't conform
> > to your policy write userspace tools to detect and/or fix
> > them.  If you have programs creating non-conforming
> > filenames, fix or rm those programs.
> 
> You do understand that GNU coreutils, bash etc. are among those

Doesn't matter where they come from.

> programs, right?  As in "touch zöe.txt" creates a non-conforming
> filename...

Your concrete example is a good one.  Where did that
filename come from?  It would seem to have come from the
keyboard via a tty (or simulator) which also had to display
it.  I'd say this is an argument for the terminal to display
UTF-8 and convert intput into UTF-8.  That is something that
seems to be not consistantly done as yet.  Ultimately it
seems to be a responsiblity of the user interface, whether
tty or GUI.  Until that happens the shells might be able to
fill the gap, however poorly.

Perhaps the utilities that don't attempt to interpret
filenames should treat filenames exactly like the kernel
does.

> > OK.  The questions have been asked and answered.
> > Asking again and again and again won't change the answer.
> 
> The question of what a program like this should do has not been
> answered:
> 
>    perl -e 'for (glob "*") { rename $_, "??i-".$_ or die "rename: $!\n"; }'
> 
>    (NB: The prefix string is N WITH CEDILLA followed by "i-").
> 
> Hint: it mangles perfectly fine non-ASCII file names, instead of just
> prefixing the prefix string.  If you change the program to correctly
> prepend the prefix string, then it mangles non-UTF-8 names, which is
> arguably correct, but can result in you losing some files.

Then if there is incorrect behavior is it the shell, tty or perl that is
getting things wrong here.

> This _is_ a userspace problem, but it is a genuine problem for which
> no good answer is yet apparent.

I'll buy that.  Then the first question to ask is "what is
the correct forum for resolving this".

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
