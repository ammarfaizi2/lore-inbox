Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVD2KRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVD2KRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVD2KRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:17:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:51882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbVD2KRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:17:51 -0400
Date: Fri, 29 Apr 2005 03:17:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3 regression - certain applications get SIGSEGV
 but are fine with 2.6.12-rc2-mm2
Message-Id: <20050429031708.6b0e1731.akpm@osdl.org>
In-Reply-To: <1113908202.2067.1.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0504191122060.2238@dragon.hyggekrogen.localhost>
	<1113908202.2067.1.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
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

y'know, if I'd been cc'ed on this email I'd have saved three hours.

Ho hum.
