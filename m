Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULFS0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULFS0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbULFS0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:26:44 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:18959 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261601AbULFS0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:26:30 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Correctly determine amount of "free memory"
Date: Mon, 6 Dec 2004 10:26:20 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKELNAEAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <06EF4EE36118C94BB3331391E2CDAAD9CD060A@exil1.paradigmgeo.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 06 Dec 2004 10:02:36 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 06 Dec 2004 10:02:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Assuming that I define "free memory" as maximum memory that can be
> allocated without causing swapping, is there a way I can give the best
> "free memory" amount estimate?

	That's not really a meaningful question. In fact, technically, no matter
how much memory you allocate you won't change the amount of swapping because
allocation has no affect on the working set size.

> I've tried to play with /proc/meminfo values with some progress, but I'd
> like to get a qualified answer from people working with VM bits and
> bytes.

	The qualified answer is that /proc/meminfo gives you the available
information and what number you want depends upon what you plan to do with
it. Swapping is not necessarily the right metric for two reasons. First, a
system might swap even though it's under a perfectly normal (or even low)
load. Second, there are bad memory situations a system can get in even if
it's not swapping, for example, a system with no buffer cache for file I/O
wouldn't be swapping, but it wouldn't perform well either.

	DS


