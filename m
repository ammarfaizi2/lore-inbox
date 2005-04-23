Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVDWUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVDWUAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVDWUAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 16:00:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:31908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbVDWUAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 16:00:18 -0400
Date: Sat, 23 Apr 2005 13:01:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <20050423184613.GE20410@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.58.0504231300140.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <20050423184613.GE20410@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Apr 2005, Jan Harkes wrote:
> 
> It is a bit more messy, but it can be done with a detached signature.

Ok, this looks more like it.

Except:

> To sign,
>     gpg -ab unsigned_commit
>     cat unsigned_commit unsigned_commit.asc > signed_commit
> 
> To verify,
>     cat signed_commit | sed '/-----BEGIN PGP/Q' | gpg --verify signed_commit -

Except I think you'd need to searc for the "---BEGIN PGP" starting from
the end, rather than the beginning.

Anyway, that should be workable. I'll whip something up.

		Linus
