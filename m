Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUHQAYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUHQAYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUHQAXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:23:02 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:40638 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268039AbUHQAWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:22:32 -0400
Message-ID: <20040817002231.14910.qmail@web14928.mail.yahoo.com>
Date: Mon, 16 Aug 2004 17:22:31 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: DRM and probing (was: your mail)
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408170052571.26072@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building a shared stub driver that fbdev and DRM both use is just a
waste of time. While it may simplify probing in the current model it
does nothing to fix the conflicting use of registers and framebuffer
memory management. The stub driver approach touches about 25 device
drivers and would be a huge testing problem. Probing is not what
crashes systems; the other two issues cause the crashes. 

Please read the overall plan for fixing things: 
http://lkml.org/lkml/2004/8/2/111
We welcome anyone who wants to help work on the solution.

That list is not set in stone but many, many people have reviewed and
commented on it. It was started in March and it has under gone many
revisions. If you think there are problems with this plan please let us
know now since several of the items have already been written and
others are being worked on. Most graphics discussion and review happens
on dri-dev and fb-dev not lkml.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
