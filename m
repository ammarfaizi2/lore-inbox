Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWBMMPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWBMMPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWBMMPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:15:18 -0500
Received: from THUNK.ORG ([69.25.196.29]:53188 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932298AbWBMMPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:15:16 -0500
Date: Mon, 13 Feb 2006 07:15:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213121503.GA31745@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org> <43ECA934.nailJHD2NPUCH@burner> <20060210155711.GA11566@thunk.org> <43F0634C.nailKUS6JSGJH@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0634C.nailKUS6JSGJH@burner>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 11:45:32AM +0100, Joerg Schilling wrote:
> If you did try to understand the reason why I did introduce the POSIX
> claim, you would know that if Linux did try to follow the POSIX rule,
> a side effect would be that removable devices need to have a stable 
> mapping in the kernel

It is _not_ a POSIX rule, as I and others have shown.  You claimed it
was required by POSIX, but you are quite clearly incorrect.  It has
never worked that way with Unix systems, and POSIX was always designed
to codify existing practice.  On Unix systems fixed disks would and
did have their devices numbering schemes move around under a number of
conditions.

> > In the context of mounted files, the only guarantee given by POSIX is
> > that st_dev and st_ino for a particular file is unique.  But that
> > clearly is true while the containing filesystem is mounted.  Even with
> > Solaris, if a particular removable filesystem is unmounted and removed
> > from one device (say one Jazz/Zip drive) and inserted into another
> > device (say another Jazz/Zip drive), st_dev will change --- while the
> > system is running.
> 
> Please don't confuse the fact that you will _always_ be able to find
> ways to confuse a system with the fact that this needs to happen in 
> all cases.

_Needs to happen_?  According to whom?

And by your definition, if it _needs_ to happen "in all cases", then
clearly since Solaris can be confused in this particular way, your
favorite operating system is also "broken", yes?  And if you still
claim that it is a "Posix rule", then by your reasoning Solaris must
not be Posix compliant either.  Go ahead and tell your OpenSolaris
friends that, and see what they say.  :-)

						- Ted
