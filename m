Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWAKMg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWAKMg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWAKMg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:36:29 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58272 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751439AbWAKMg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:36:29 -0500
Subject: 2.6.15-rt3-sr1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 07:36:21 -0500
Message-Id: <1136982981.6197.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

While trying to exploit the race in the hrtimer code in your kernel
(still unsuccessful), I found a bug that I introduced with the
wait_on_softirqd patch.   The wake_up is called within preempt_disable,
and thus might schedule and cause a bug output.  I've uploaded my latest
with the fix for this.

http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt3-sr1
http://home.stny.rr.com/rostedt/patches/patches-2.6.15-rt3-sr1.tar.bz2

-- Steve


