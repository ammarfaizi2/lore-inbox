Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWEMS5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWEMS5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWEMS5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:57:30 -0400
Received: from ns.firmix.at ([62.141.48.66]:20671 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932494AbWEMS53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:57:29 -0400
Subject: Re: Executable shell scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: Mark Rosenstand <mark@borkware.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513122330.CAA54146AF@hunin.borkware.net>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	 <1147517786.3217.0.camel@laptopd505.fenrus.org>
	 <20060513110324.10A38146AF@hunin.borkware.net>
	 <1147519329.3084.20.camel@gimli.at.home>
	 <20060513114509.3A90D146AF@hunin.borkware.net>
	 <1147521363.3084.34.camel@gimli.at.home>
	 <20060513122330.CAA54146AF@hunin.borkware.net>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sat, 13 May 2006 20:55:26 +0200
Message-Id: <1147546526.3032.6.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.189 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 14:23 +0200, Mark Rosenstand wrote:
> (Cutting Arjan off the CC list, he's been bugged enough for his attempt
> to help.)
> 
> Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Sat, 2006-05-13 at 13:45 +0200, Mark Rosenstand wrote:
> > > Bernd Petrovitsch <bernd@firmix.at> wrote:
> > > > On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > > > [...]
> > > > > A more useful case is when you setuid the script (and no, this doesn't
> > > > > need to be running as root and/or executable by all.)

What just now comes into my mind is: Do you really want to execute a
program (be it a script or a binary) which you aren't allowed to read
before?

> > > > Apart from the permission bug: This has been purposely disabled since it
> > > > is way to easy to write exploitable shell or other scripts.
> > > > Use a real programming languages, sudo or a trivial wrapper in C ....
> > s/languages/language/
> > 
> > And I forgot to mention that a kernel patch is another possibility.
> 
> I'm too stupid to provide such myself, but I'd sure enable the Kconfig
> option if it was there :)

Yes, is probably the best "solution" if someone creates such a patch.

> > > It isn't a bug on systems that support executable shell scripts.
> > 
> > I never wrote that (or anything which implies that directly).
> 
> I was commenting on the "Apart from the permission bug" part.

Sorry, that was not clear to me.

> > > Doing security policy based on programming language seems weird at
> > > best, especially when the only user able to make those decisions is the
> > > superuser.
> > 
> > It boils down to "how easy is it for root to shoot in the foot"?
> > And the workarounds are somewhere between trivial and simple.
> 
> Or "dare we handle root a gun, it's a powerful weapon but can be used
> to shoot at feet." It's obvious what the answer have been for that in
> other operating systems, and probably one of the reasons we're here.

I'm also a "root knows per definition what s/he is doing" person but
more the problem is that root must give sensitive permsisions to scripts
written by God-knows-who. So either
-) root trusts completely some project/persons/... to quote everything
   prefectly and rules injections completely out or
-) root has to check all the SUID scripts (including some of the stuff
   called from there).
Yes, we have more than enough bugs in compiled programs but it is far
more easy to get buggy scripts together.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

