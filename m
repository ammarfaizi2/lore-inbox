Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162852AbWLBJDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162852AbWLBJDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 04:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162851AbWLBJDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 04:03:34 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:15297 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1162839AbWLBJDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 04:03:32 -0500
Date: Sat, 2 Dec 2006 10:02:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Schwartz <davids@webmaster.com>
cc: mrmacman_g4@mac.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEEAABAC.davids@webmaster.com>
Message-ID: <Pine.LNX.4.61.0612020959070.1635@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKCEEAABAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Next you stick a my_other_func declaration in a header and use
>> my_other_func instead of my_func() in the main function.  Now the
>> result is that the compiler has no damn clue what my_other_func()
>> contains so it can't optimize it out of the loop with either
>> version.  You cannot treat "volatile" the way you are saying it is
>> treated without severely violating both the C99 spec *and* common sense.
>
>The compiler *happens* to have no damn clue because such inter-module
>optimizations don't exist. That doesn't make the code correct, just not
>likely to demonstrate its brokenness.

GCC has inter-module optimization, it's just not used everyday. I think 
I have seen a discussion on this.

Right there it is -> http://lkml.org/lkml/2006/8/24/212



	-`J'
-- 
