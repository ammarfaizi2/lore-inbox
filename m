Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVE0BAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVE0BAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVE0BAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:00:14 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:23631 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261302AbVE0BAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:00:08 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org
Subject: [patch 0/8] uml: some fixes for 2.6.12
Date: Fri, 27 May 2005 03:02:06 +0200
User-Agent: KMail/1.7.2
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270302.07501.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now I'm sending some other fixes intended for 2.6.12... they are either very 
simple or potentially critical (as the PREEMPT_ACTIVE fix). Some of these 
are/were still in -mm queue, but since they seem to have been dropped and 
anyway haven't been merged, I'm resending them anyway.

Also, we have one big 2.6.10 regression which is still unfixed: top always 
shows ksoftirqd/0 as runnable, while it gets 0% cpu time, and loadavg goes 
then to 1.0, while no real load is generated...

Possible culprits could be the IRQ code rewrite, maybe; I've not found what 
the hell can be arch-specific for this (except that UML does not support 
PREEMPT and that SMP, and locking in general, isn't well tested yet, even if 
the biggest problems are just theoretical, luckily).

I've not yet had the time to analyze it successfully (but while looking at 
this I saw the PREEMPT_ACTIVE problem, which also extends to other archs, see 
my other mail).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
