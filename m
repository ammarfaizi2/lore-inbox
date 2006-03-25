Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWCYMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWCYMpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWCYMpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:45:17 -0500
Received: from www.osadl.org ([213.239.205.134]:12509 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750796AbWCYMpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:45:16 -0500
Message-Id: <20060325121219.172731000@localhost.localdomain>
Date: Sat, 25 Mar 2006 12:46:00 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 0/2] hrtimer: generic sleeper infrastructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

the removal of the data field in the hrtimer structure introduced a
private sleeper implementation for nanosleep. wakeup is the most common
callback case for timers and we should use a generic implementation
instead of forcing users to reimplement it all over the place.
    
        tglx

--

