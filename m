Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVANIFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVANIFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVANIFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:05:23 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:35332 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261603AbVANIFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:05:17 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: NUMA or not on dual Opteron
Date: Fri, 14 Jan 2005 00:04:32 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEGKBBAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <E1CpCRr-0002lv-00@calista.eckenfels.6bone.ka-ip.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 13 Jan 2005 23:40:25 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 13 Jan 2005 23:40:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In article <20050113094537.GB2547@favonius> you wrote:

> > I was under the impression that NUMA is useful on > 2-way systems only.
> > Is this true, and if not, under what circumstances is NUMA useful on
> > 2-way Opteron systems?

> NUMA is good for all situations where you have more than one CPU and the
> CPUs have different access speeds for some parts of the memory (i.e. cpu
> local memory). This is true for SMP Opterons, not for the usual Intel
> Boards.

	Not quite. It's good if and only if the NU of the MA is sufficient to
overcome the overhead associated with the NUMA code. Whether or not this is
true depends upon two factors:

	1) How non-uniform is the memory access? On 2 CPU Opteron systems, the
answer is generally not very at all, it's nearly uniform.

	2) How much overhead does the NUMA code add? On most of the benchmarks I've
seen, the answer is a lot, so much that the memory access would have to be
very non-uniform (factor of 2 at least) to justify enabling the NUMA code.

	With more CPUs, 1 goes up, being an advantage to NUMA. As time goes by, 2
has been going down, being another advantage to NUMA.

	Perhaps others have seen more recent benchmarks with smarter NUMA code?

	DS


