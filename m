Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWISS1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWISS1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWISS1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:27:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27576 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750834AbWISS1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:27:36 -0400
Date: Tue, 19 Sep 2006 20:27:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Joshua Brindle <method@gentoo.org>
Cc: casey@schaufler-ca.com, David Madore <david.madore@ens.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060919182736.GF7099@elf.ucw.cz>
References: <20060918160217.97076.qmail@web36601.mail.mud.yahoo.com> <450F38F7.6080006@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450F38F7.6080006@gentoo.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The first system I took through evaluation
> >(that is, independent 3rd party analysis) stored
> >security attributes in a file while the second
> >and third systems attached the attributes
> >directly (XFS). The 1st evaluation required
> >5 years, the 2nd 1 year. It is possible that
> >I just got a lot smarter with age, but I
> >ascribe a significant amount of the improvement
> >to the direct association of the attributes
> >to the file.
> Thats great but entirely irrelevant in this context. The patch and caps 
> in question are not attached to the file via some externally observable 
> property (eg., xattr) but instead are embedded in the source code so 
> that it can drop caps at certain points during the execution or before 
> executing another app, thus unanalyzable.

I do not know why this is unanalyzable... It seems very analyzable
when reading the source code... and actually priviledge
operations in source code mean that you can't get them wrong with
wrong xattrs.

Plus systems like qmail already use setuid() in source this way.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
