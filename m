Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUJKLFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUJKLFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268781AbUJKLFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:05:19 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:62143 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268779AbUJKLFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:05:13 -0400
Message-ID: <416A68E5.6080608@drzeus.cx>
Date: Mon, 11 Oct 2004 13:05:09 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: MMC performance
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've added SGIO support to my driver now hoping that it would resolve 
the piss-poor performance I've been getting. Didn't do much difference 
though.

Read operations are fairly fast. It queues 8kB at a time. A bit small 
perhaps, but still decent.

Writing, however, only sends a single sector at a time. The queue 
process eats up half of the CPU time on my machine during a write. And 
since MMC cards have to clear a whole bunch of sectors before a write 
shouldn't you send as many sectors as possible to them?

Since I don't have another controller to compare with I don't really 
know if the problem is in my code, the MMC layer, the block layer or the 
filesystem.

I'm going to dig around a bit more but some pointers are welcome. At 
least which layer I should be looking at.

Rgds
Pierre
