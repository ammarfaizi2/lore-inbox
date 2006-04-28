Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWD1QgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWD1QgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWD1QgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:36:11 -0400
Received: from arkroyal.concentric.net ([207.155.252.5]:4605 "EHLO
	arkroyal.cnchost.com") by vger.kernel.org with ESMTP
	id S1030469AbWD1QgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:36:10 -0400
Message-ID: <200604281636.MAA06562@arkroyal.cnchost.com>
From: Rick Niles <niles@rickniles.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: Rick Niles <niles@rickniles.com>
Subject: add a few integer math ops (sqrt, atan) to kernel headers?
Date: Fri, 28 Apr 2006 12:36:09 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if it's already in the kernel somewhere, but I need some basic (large) integer based math functions for a GPS device driver I maintain (OSGPS on sourceforge)and I've got to wonder if other drivers might be able use them.  Right now we have: sqrt(x), atan2(y, x), and rss(x,y) [root-sum-squared].  The functions just deal with large integers to compute anything reasonable.  Of course they're approximations since the output has to be an integer. The atan2() function returns an angle such that 1 radian == 16384.  It seems like these should go in some integer math kernel header file for everyone to use.

I know what some of you are thinking right now.  That sort of math belongs in userspace, but to close a correlator tracking loop in real-time you need it in the device driver. Either than or require your userland program be a real-time program, which I'd rather not do.

They're all less than 30 lines long. If people think this is a good idea, then I can submit a patch.  Suggestions about what to call this header file or where to put it are appreciated.  Also, if anyone wants to add more functions or improve the algorithm we use that would also be nice.
