Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbUCZAC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUCYX7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:59:01 -0500
Received: from waste.org ([209.173.204.2]:46745 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263808AbUCYX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:57:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.524465763@selenic.com>
Subject: [PATCH 0/22] /dev/random: Assorted fixes and cleanups
Date: Thu, 25 Mar 2004 17:57:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of fixes and cleanups for the Linux /dev/random
driver including:

- more robust/correct entropy accounting and reseed logic
- starvation avoidance for simultaneous /dev/random and /dev/urandom
  users
- remove entropy batching
- wakeup bug fix
- remove various legacy code
- remove i386isms

I've broken this into a bunch of very simple bits, so I'm afraid the
patch count is rather high by non-gregkh standards.

These patches have been tested by various people since pre-2.6.0 and
have been in my -tiny tree since its inception. Andrew, please queue
these in -mm for wider testing/review.
