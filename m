Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWHTIie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWHTIie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWHTIie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:38:34 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:17075 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751492AbWHTIid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:38:33 -0400
Date: Sun, 20 Aug 2006 10:27:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Complaint about return code convention in queue_work() etc.
In-Reply-To: <Pine.LNX.4.44L0.0608191050170.30951-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.61.0608201024330.9707@yvahk01.tjqt.qr>
References: <Pine.LNX.4.44L0.0608191050170.30951-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1279926190-1156062469=:9707"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1279926190-1156062469=:9707
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> > >I'd like to lodge a bitter complaint about the return codes used by
>> > >queue_work() and related functions:
>> > >
>> > >	Why do the damn things return 0 for error and 1 for success???
>> > >	Why don't they use negative error codes for failure, like
>> > >	everything else in the kernel?!!
>> >
>> > It's a standard programming idiom:  return false (0) for failure, true
>> > (non-zero) for success.  Boolean.
>> 
>> There are at least 3 idioms:
>> 
>> 1) return 0 on success, -E on fail¹.
>> 2) return 1 on YES, 0 on NO.
>> 3) return valid pointer on OK, NULL on fail.

I wrote something up some time ago,
http://svn.sourceforge.net/viewvc/vitalnix/trunk/src/doc/extra-aee.php?revision=1

>Functions can return values of many different kinds, and one of the most
>common is a value indicating whether the function succeeded or failed.  
>Such a value can be represented as a "status" integer (0 = success, -Exxx
>= failure) or a "succeeded" boolean (1 = success, 0 = failure).
>
>Mixing up these two sorts of representations is a fertile source of
>difficult-to-find bugs.  If the C language included a strong distinction
>between integers and booleans then the compiler would find these mistakes
>for us... but it doesn't.

Recently introduced "bool".



Jan Engelhardt
-- 
--1283855629-1279926190-1156062469=:9707--
