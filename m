Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUIAKWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUIAKWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUIAKWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:22:15 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:4017 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265795AbUIAKWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:22:02 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1 : Weirdness after shutdown - ACPI or Suspend bug?
Date: Wed, 1 Sep 2004 20:20:41 +1000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409012020.42482.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this one is weirding me out.

Note that when using 2.6.8.1 all is fine. The following situation only happens 
in 2.6.9-rc1 or later.

If I shutdown my laptop (ie: halt) it goes through the motions and everything 
goes off. If the lid switch changes state AFTER powerdown, the laptop starts 
up. Removing AC power, or with AC power connected and removing the battery 
does not trigger this, just seemingly the lid switch. This works on lid close, 
AND lid open.

I noticed it and thought my laptop was dying, and consequently made sure I 
shut the lid before the machine actually powered off, and didn't correlate it 
to 2.6.9-rc1. But when I was trying to compile 2.6.9-rc1-mm2 I had some 
other issues (general weirdness), and decided to boot back to 2.6.8.1 in case 
2.6.9-rc1 was at fault. When I shut down I noticed it didn't have 
this behaviour, and went and did a little reboot test at random between 
2.6.9-rc1 & 2.6.8.1 that showed this as consistent behaviour.

Note that once the laptop restarts, if I shut it down using the power switch 
at the lilo prompt, the machine stays off, regardless of the lid switch 
state.

Any ideas or suggestions? Going to start going back thru csets when I get a 
chance if no one has an ideas.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
