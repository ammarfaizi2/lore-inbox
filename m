Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTHTPJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTHTPJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:09:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:57276 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262004AbTHTPJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:09:07 -0400
Date: Wed, 20 Aug 2003 08:09:03 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE wierdness
Message-ID: <20030820150903.GA7246@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The primary drive in our file server started to flake out on us (caught by
the integrity checker we use as part of our backups, files that hadn't been
modified in a couple of years started having different CRC's).  I pulled 
the data off and stuck in a new drive.

I wanted to see if the old drive could be salvaged and used as a test box
drive.  The drive seems to be degenerating fast.  When I put that drive
in a 3ware card the 3ware card only sees 1/3 of the drives.  Strange.
When I put all 3 drives in a promise card, it sees them but if I try and
copy data from the bad drive to any other drive the system locks up hard,
no console, no pings, no response to the reset switch, it takes a power
cycle to get things back.

I verified that behaviour on two different systems so it isn't the box.
I also cycled through 3 different 3ware cards to make sure that wasn't
the problem (isn't sys admin fun?).

It's clear to me that I don't want to use this drive but I'm wondering if
there is any interest in debugging the lock up.  I've only done it on
2.4.18 as shipped by redhat but I could try 2.6 or whatever you like.

If the concensus is that it is OK that bad hardware locks you up then I'll
toss the drive and move on.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
