Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVDSL1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDSL1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 07:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDSL1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 07:27:41 -0400
Received: from mail.dif.dk ([193.138.115.101]:61101 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261232AbVDSL1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 07:27:39 -0400
Date: Tue, 19 Apr 2005 13:30:40 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2-mm3 regression - certain applications get SIGSEGV
 but are fine with 2.6.12-rc2-mm2
In-Reply-To: <1113908202.2067.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0504191328540.2074@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504191122060.2238@dragon.hyggekrogen.localhost>
 <1113908202.2067.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Alexander Nyberg wrote:

> tis 2005-04-19 klockan 11:33 +0200 skrev Jesper Juhl:
> > Everything is fine with 2.6.12-rc2, 2.6.12-rc2-mm1, 2.6.12-rc2-mm2 & 
> > earlier kernels as well, but 2.6.12-rc2-mm3 seems to have a problem.
> > I don't know what's causing this, all I can do at the moment is describe 
> > the symptoms.
> > 
> > Certain applications (krootimage and ksplash from KDE 3.4 are 100% 
> > reproducible test cases) that used to run fine have started crashing with 
> > SIGSEGV on 2.6.12-rc2-mm3. I see nothing suspicious in dmesg.
> > I'm including dmesg output as well as strace output from krootimage and 
> > ksplash below.
> > If someone could give me a hint as to what the cause of this could be or 
> > what to try in order to track it down I'd appreciate it.
> > This is 100% reproducible.
> 
> Try backing out
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/broken-out/sched-unlocked-context-switches.patch
> 
That did the trick. All the apps that segfaulted previously now seem to be 
running just fine again.
Are Ingo, Nick & Andrew aware that this patch has issues?

-- 
Jesper

