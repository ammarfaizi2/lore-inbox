Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUIEMt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUIEMt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUIEMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:49:28 -0400
Received: from smtp.wp.pl ([212.77.101.160]:32077 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S266613AbUIEMt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:49:26 -0400
From: Piotr Neuman <sikkh@wp.pl>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: Scheduler experiences
Date: Sun, 5 Sep 2004 14:49:24 +0200
User-Agent: KMail/1.6.2
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1094386464.18114.0.camel@localhost>
In-Reply-To: <1094386464.18114.0.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409051449.24392.sikkh@wp.pl>
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-AS1: NOSPAM  Body=2 Fuz1=2  Fuz2=2                        
X-WP-AS2: NOSPAM 
X-WP-SPAM: NO 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey, i wonder which scheduler you people have the best experiences with,
> staircase or nicksched?

I'm using staircase exclusively, but I did compare it to vanilla kernel's 
scheduler and yes the interactivity is very good (I'm running x.org and KDE 
3.2.3 here).

I have had no sound skips or tvtime problems no matter what kind of disk IO 
was being done, which includes MySQL database updates, cron scripts (running 
rpm -V on all packages) and wwwoffle purging cached files (note I use the 
default as IO sched). Also kernel compilation is no threat to interactivity 
with staircase.

I'm a Mandrake user and since the release of Mandrake 10 it does not renice X 
server to higher priority so I guess Nick's scheduler would force me to tweak 
X startup script.

The other things I like about staircase are that it gives you kernel.compute 
and kernel.interactive sysctls that allow to perform serious computational 
tasks with it. Also ability to use scheduling policies with schedtool is a 
great plus, for example using SCHED_BATCH for cpu bound applications like 
seti@home or folding@home.

Overall staircase has been a great experience for me.

Regards

Piotr Neuman
