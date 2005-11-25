Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbVKYBOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbVKYBOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 20:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVKYBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 20:14:53 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:28558 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S932680AbVKYBOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 20:14:52 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200511250115.jAP1FoL4032027@auster.physics.adelaide.edu.au>
Subject: 2.6.14-rt13: high res timer problem?
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Nov 2005 11:45:50 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys

I noticed an odd problem with 2.6.14-rt13 this past week.  If the new-ish
high resolution timer is enabled (not HPET), sleeps take far too long.
For example, "sleep 1" from bash actually delays 38 seconds, not 1 second
as expected.  I've also noticed that the clock on the computer seems to
run slow, but I haven't looked into that in any detail yet.

At the present moment I am running Ingo's rt13 patch with 2.6.14.  I have
not yet had a chance to test an unpatched 2.6.14 - I will try to get to
that soon.  I've also got 2.6.14-rt15 now and I'll test that too.

This is on a Centrino laptop with an i915 chipset.  I can confirm that the
effect persists irrespective of whether any or all of the APIC options are
selected.  The presence or absence of various timer-related options
(ktimers, HPET, PM timer) also don't appear to make any difference.

Please CC replies to me to ensure I see them.  Thanks.

Regards
  jonathan
