Return-Path: <linux-kernel-owner+w=401wt.eu-S932731AbWLNODd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWLNODd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWLNODJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:03:09 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:58510
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbWLNODG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:03:06 -0500
Date: Thu, 14 Dec 2006 05:35:04 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] lock stat kills lock meter for -rt
Message-ID: <20061214133504.GA22081@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm back with another annoying announcement and post of my "lock stat"
patches for Ingo's 2.6.19-rt14 patch. I want review, comments and
eventually inclusion into the -rt.

Changes in this release:

- forward ported to 2,6.19-rt14

- rt_mutex_slowtrylock() path now works with lock stat after an
initialization check. Apparently there's a try-lock some where before
my lock stat stuff is initialized and it hard crashes the machine on
boot. This is fixed now.

- Addes a new field to track adaptive spins in the rtmutex as a future
feature.

bill

