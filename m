Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSGITbs>; Tue, 9 Jul 2002 15:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSGITbq>; Tue, 9 Jul 2002 15:31:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29926 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317400AbSGITbo>;
	Tue, 9 Jul 2002 15:31:44 -0400
Message-Id: <200207091933.g69JXE417419@eng4.beaverton.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 21:38:58 PDT."
             <20020709043857.GA24418@kroah.com> 
Date: Tue, 09 Jul 2002 12:33:13 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Wait!  You're still not getting it.  I'm not against removing the
    BKL.  I'm not saying we should add it to more places.  What I am
    complaining about (and I'm not the only one) is the method that
    people who are trying to remove the BKL from various kernel
    subsystems are using.

    [ ... ]

    So please, no more "hit and run" BKL patches that break things.
    Please come offering to help, with detailed reasons why BKL usage
    is wrong in the specific portions of the code, and how possibly it
    might be cleaned up, with patches that have _actually been
    tested_.

I understand.  But there's a bit of a problem here.  We don't have
every device available to us that uses the BKL.  The maintainers, I
presume, do.  While we can inspect to our little hearts' content, and
code up "obviously" correct patches, nothing really tests it like,
well, testing it.  In the past, in writing to maintainers, we have
sometimes found that a) they ignore email that does not include actual
patches, or b) they don't know themselves if it is safe, and are afraid
or unwilling to try it themselves.  So there's no means to discuss
changes, no means to test them, and (some) maintainers then refuse to
apply ANY changes.

(Others take the opposite approach, and apply anything that looks like
a patch -- ALSO probably not the desired result :)

This is not to say that you, as a maintainer, behave this way.  But we
HAVE observed this behavior in our efforts.  What is the proper
response when a maintainer won't apply a change, won't help test it,
and won't even help derive a correct one?  About all that's left at
that point, it seems, is to provide a patch, appeal to the community at
large, and ask them to try it or comment upon it.

Rick
