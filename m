Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbVKHCzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVKHCzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVKHCzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:55:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:18575 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965196AbVKHCzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:55:46 -0500
Subject: CLOCK_REALTIME_RES and nanosecond resolution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 13:55:11 +1100
Message-Id: <1131418511.4652.88.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I noticed that we set

#define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */

Unconditionally in kernel/posix-timer.c

Doesn't that mean that we'll advertise to userland (via clock_getres) a
resolution that is basically HZ ? We do get at lenght to get more
precise (up to ns) resolution in practice on many architectures but we
don't expose that to userland at all. Is this normal ?

Ben.


