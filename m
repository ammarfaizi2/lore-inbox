Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVHEKlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVHEKlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVHEKio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:38:44 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:42380 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262962AbVHEKid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:38:33 -0400
Message-Id: <200508051040.AA00185@TNESB9756.bsd.tnes.nec.co.jp>
From: Akira Fujita <a-fujita@bsd.tnes.nec.co.jp>
Date: Fri, 05 Aug 2005 19:40:41 +0900
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems still left in 2.6.13-rc3
In-Replay-To: <20050729164806.32ecd152.akpm@osdl.org>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

 > But it's not possible to say that the system has really leaked pages
 >unless you first put a lot of memory reclaim pressure on the machine
 >to try to reclaim those oddball pages.

I tried putting a memory pressure on the machine, then unused pages on 
the page LRU could be reclaimed.  In short, as you said, they were
not really leaked at all!

But I also saw the situation that memory and swap were exhausted when
I laid heavy load on ext3 for 20 consecutive days.  It seemed that the
pages couldn't be reclaimed then.
So I'll try to reproduce and let you know if something happens.

Best regards,  Akira Fujita
