Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVBBN1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVBBN1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVBBN1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:27:49 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:14747 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262457AbVBBN1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:27:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: cpufreq problem wrt suspend/resume on Athlon64
Date: Wed, 2 Feb 2005 14:28:11 +0100
User-Agent: KMail/1.7.1
Cc: Dave Jones <davej@codemonkey.org.uk>, Pavel Machek <pavel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502021428.12134.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed that the condition (cur_freq != cpu_policy->cur), which is
unlikely() according to cpufreq.c:cpufreq_resume(), occurs on every resume
on my box (Athlon64-based Asus).  Every time the box resumes, I get a message
like that:

Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1600000, is 1800000 kHz.

(the numbers vary: there may be 800000 vs 1600000 or even 800000 vs 1800000).

Also, when the box is suspended on AC power and resumed on batteries, it often
reboots.

Please let me know if there's anything (relatively simple :-)) that I can do
about it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
