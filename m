Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTERADl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTERADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 20:03:41 -0400
Received: from mail.webmaster.com ([216.152.64.131]:6801 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261893AbTERADk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 20:03:40 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Andrea Arcangeli" <andrea@suse.de>, <dak@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Scheduling problem with 2.4?
Date: Sat, 17 May 2003 17:16:33 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIELBDAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030517235048.GB1429@dualathlon.random>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I see what you mean, but I still don't think it is a problem. If
> bandwidth matters you will have to use large writes and reads anyways,
> if bandwidth doesn't matter the number of ctx switches doesn't matter
> either and latency usually is way more important with small messages.

> Andrea

	This is the danger of pre-emption based upon dynamic priorities. You can
get cases where two processes each are permitted to make a very small amount
of progress in alternation. This can happen just as well with large writes
as small ones, the amount of data is irrelevent, it's the amount of CPU time
that's important, or to put it another way, it's how far a process can get
without suffering a context switch.

	I suggest that a process be permitted to use up at least some portion of
its timeslice exempt from any pre-emption based solely on dynamic
priorities.

	DS


