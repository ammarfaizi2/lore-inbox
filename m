Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVDSK5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVDSK5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 06:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDSK5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 06:57:07 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:4588 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261393AbVDSK4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 06:56:54 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3 regression - certain applications get SIGSEGV
	but are fine with 2.6.12-rc2-mm2
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504191122060.2238@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504191122060.2238@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 12:56:42 +0200
Message-Id: <1113908202.2067.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-04-19 klockan 11:33 +0200 skrev Jesper Juhl:
> Everything is fine with 2.6.12-rc2, 2.6.12-rc2-mm1, 2.6.12-rc2-mm2 & 
> earlier kernels as well, but 2.6.12-rc2-mm3 seems to have a problem.
> I don't know what's causing this, all I can do at the moment is describe 
> the symptoms.
> 
> Certain applications (krootimage and ksplash from KDE 3.4 are 100% 
> reproducible test cases) that used to run fine have started crashing with 
> SIGSEGV on 2.6.12-rc2-mm3. I see nothing suspicious in dmesg.
> I'm including dmesg output as well as strace output from krootimage and 
> ksplash below.
> If someone could give me a hint as to what the cause of this could be or 
> what to try in order to track it down I'd appreciate it.
> This is 100% reproducible.

Try backing out
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/broken-out/sched-unlocked-context-switches.patch

