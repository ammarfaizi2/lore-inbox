Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTHTLPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbTHTLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 07:15:22 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:23453
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261891AbTHTLPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 07:15:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>, Voluspa <lista1@comhem.se>
Subject: Re: [PATCH] O17int
Date: Wed, 20 Aug 2003 21:21:42 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030820095103.019969f8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030820095103.019969f8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308202121.56531.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 20 Aug 2003 18:00, Mike Galbraith wrote:
> At 06:55 AM 8/20/2003 +0200, Voluspa wrote:
> >Blender 2.28 can not starve xmms one iota. Within blender itself, I can
> >cause 1 to 5 second freezes while doing a slow "world rotate", but that
> >is something the application programmers have to fix.
>
> I'm not so sure that it's an application bug.  With Nick's patch, I cannot
> trigger any delay what so ever, whereas with stock, or with Ingo's changes
> [as well as my own, damn the bad luck] I can.  I'm not saying it's _not_ a
> bug mind you, but color me suspicious ;-)

/me giggles like a 12 year old girl (teehee)

Try an earlier version of blender and you'll see it goes away. Other ones to 
try are opening a gpg signed mail (like this mail) in kmail. The slower the 
sleep avg decay in any tree the longer the spin. Nick's changes I believe 
cover up the flaw. I'm not discounting Nick's work, but I do believe the apps 
are broken and it's only the current scheduler design that makes it visible. 
I would also like to make it impossible for priority inversion to happen but 
at the moment I've just got to make sure they dont starve anything but their 
dependent cpu hog. Still looking for some useful task dependency tracking.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Q1nQZUg7+tp6mRURAgmIAJ0f6jGLZFjjguhYv+MGEz5S1DuMCwCeO+Id
ii0V4YOXlL9bB7wJ6rn8QEo=
=PygI
-----END PGP SIGNATURE-----

