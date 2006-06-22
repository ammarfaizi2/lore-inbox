Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWFVJJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWFVJJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWFVJJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:09:54 -0400
Received: from www.osadl.org ([213.239.205.134]:64733 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932537AbWFVJJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:09:53 -0400
Message-Id: <20060622082758.669511000@cruncher.tec.linutronix.de>
Date: Thu, 22 Jun 2006 09:08:37 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [patch 0/3] rtmutex: Propagate priority setting into lock chains
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please add the following patches to the rtmutex / pi-futex patchset.

This ensures that asynchronous setscheduler() calls are properly propagated
into a already blocked task's lock dependency chain.
The testsuite has also been improved to verify this behaviour.

	tglx

--

