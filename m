Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSGJTgd>; Wed, 10 Jul 2002 15:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSGJTgc>; Wed, 10 Jul 2002 15:36:32 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:40689 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317582AbSGJTgb>; Wed, 10 Jul 2002 15:36:31 -0400
Date: Wed, 10 Jul 2002 02:30:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020710003047.GA596@elf.ucw.cz>
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com> <20020707205543.GA18298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020707205543.GA18298@kroah.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I would mind the BKL a lot less if it was as well understood 
> > everywhere as it is in VFS.  The funny part is that a lock like the 
> > BKL would not last very long if it were well understood or documented 
> > everywhere it was used.
> 
> I would mind it a whole lot less if when you try to remove the BKL, you
> do it correctly.  So far it seems like you enjoy doing "hit and run"
> patches, without even fully understanding or testing your patches out
> (the driverfs and input layer patches are proof of that.)  This does
> nothing but aggravate the developers who have to go clean up after you.
> 
> Also, stay away from instances of it's use WHERE IT DOES NOT MATTER for
> performance.  If I grab the BKL on insertion or removal of a USB device,
> who cares?  I know you are trying to remove it entirely out of the

Well, BKL has some rather nasty semantics (release over schedule(),
IIRC), so killing it completely would simplify both documentation and
code.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
