Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbULECW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbULECW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbULECW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:22:26 -0500
Received: from av13-1-sn4.m-sp.skanova.net ([81.228.10.104]:29596 "EHLO
	av13-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261227AbULECWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:22:22 -0500
Date: Sun, 5 Dec 2004 03:22:21 +0100 (CET)
Message-Id: <200412050222.iB52MLD03362@d1o405.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: tglx@linutronix.de
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-12-05 03:22:21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-04 21:02:03 Thomas Gleixner wrote:

> Mats. I don't understand why this did not work for you. The change has
> to be reverted to the original line "might_sleep_if(wait)" !

Well, I'm no coder and therefore follow instructions to the letter, 
almost (; <-- ehum), which meant that "put back" became lines 613-615 in 
mm/page_alloc.c

might_sleep_if(wait);
if (wait)
        cond_resched();

Now interpreting it as the lines should be

might_sleep_if(wait);

/*

the kernel boots without problems. Have yet to test the oom-killer with 
my rogue app. Won't return unless there's problems.

Mvh
Mats Johannesson

