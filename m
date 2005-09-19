Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVISBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVISBBX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 21:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVISBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 21:01:23 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:8118 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S932270AbVISBBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 21:01:22 -0400
Mime-Version: 1.0
Message-Id: <a06230970bf53b4a0dfad@[129.98.90.227]>
In-Reply-To: <mailman.3.1127041200.14075.linux-kernel-daily-digest@lists.us.dell.com>
References: <mailman.3.1127041200.14075.linux-kernel-daily-digest@lists.us.dell.com>
Date: Sun, 18 Sep 2005 21:03:00 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Cc: andrew@walrond.org, bert.hubert@netherlabs.nl
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 6:00 AM -0500 9/18/05, 
linux-kernel-daily-digest-request@lists.us.dell.com wrote:
>  >
>>  I have been seeing a similar thing:
>>
>>  ./current:Sep 17 18:00:01 [kernel] mkdir[7696]: segfault at
>>  0000000000000000 rip 000000000040184d rsp 00007fffff826350 error 4
>>
>>  I'm using the plain 2.6.13 (from gentoo vanilla sources), though it
>>  was compiled with
>>  gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)
>
>x86_64 ? If so see http://bugzilla.kernel.org/show_bug.cgi?id=4851

Dual Opteron, and this looks like my issue. It recommends echo 0 > 
/proc/sys/kernel/randomize_va_space but that has not stopped it from 
happening, so I'll probably wait for the patch to get merged.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
