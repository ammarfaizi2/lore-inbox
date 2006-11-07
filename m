Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753999AbWKGEWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbWKGEWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 23:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbWKGEWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 23:22:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48136 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753999AbWKGEWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 23:22:13 -0500
Date: Tue, 7 Nov 2006 05:22:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
Message-ID: <20061107042214.GC8099@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061105064801.GV13381@stusta.de> <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 08:17:53AM -0700, Eric W. Biederman wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> >
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> >
> > Due to the huge amount of recipients, please trim the Cc when answering.
> >
> >
> > Subject    : ipath driver MCEs system on load when HT chip present
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=7455
> > Submitter  : Bryan O'Sullivan <bos@serpentine.com>
> > Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
> > Status     : unknown
> 
> Status in problem is being debugged. I have posted some infrastructure
> patches that should allow Bryan to fix his driver cleanly.  
> 
> I did not cause this. The ipath HTX card driver's irq handling has
> never been anything but a hack.  It has never worked correctly even in
> the instances it worked.  It only worked on i386 or x86_64 when
> CONFIG_PCI_MSI was enabled but did not use MSI.  It was relying on the
> implementation detail that the architecture specific vector number was
> placed in the dev->irq.  dev->irq is actually meaningless on this card
> as it doesn't have any ordinary pci interrupts.
> 
> So while I am happy to take credit for flushing this bug out I did not
> introduce it.

My notion of "regression" is from a user's perspective.

Therefore, if a hack that worked at least for some users no longer 
works, that's a regression. That's independent of the technical question 
whose fault it actually was.

We should either get this fixed before 2.6.19 or at least make it clear 
for users that support for this hardware won't be back before 2.6.20.

> Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

