Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWEPHFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWEPHFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWEPHFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:05:09 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35286 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751612AbWEPHFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:05:08 -0400
Date: Tue, 16 May 2006 03:05:06 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: Over-heating CPU on 2.6.16 with Thinkpad G41
Message-ID: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last night compiling kernels in my hotel, my CPUs kept over-heating.

I have a IBM Thinkpad G41 which has a pentium 4 HT.

Before compiling, my CPU temp would start at 65C and go up to 82 before I
kill the compile. At 80 it warns me.  I rebooted a few times, but it would
always happen.  Thinking this might be bad hardware, I rebooted into
2.6.12, and saw that the CPU temperature would be at 52C??  I had no more
problems compiling.

I recently added the Suspend2 patch and that might be the culprit, But I
just booted, a version of 2.6.16 that doesn't have the patch, and it too
seems to be runnig hot.

Hmm, could this be the "acpi_sleep=s3_bios" that Suspend2 asks for?
I haven't removed that option yet.

Anyone else seen this problem?

-- Steve

