Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbULGRZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbULGRZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULGRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:25:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10631 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261858AbULGRZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:25:21 -0500
Date: Tue, 7 Dec 2004 11:25:10 -0600
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: What is a reasonable upper limit to the rt_hash_table.
Message-ID: <20041207172510.GC11423@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a system with a very large amount of memory.  We are noticing
pauses of approximately 5 seconds every 10 minutes.  We tracked it down
to rt_run_flush holding off other timer processing while it scans the
rt_hash_table.  The following is from the boot:

IP: routing cache hash table of 33554432 buckets, 524288Kbytes

This seems like an outrageously large value.  I realize the 2.6 kernel
has rhash_entries as a boot option.

Can I get some guidance on what a reasonable upper limit would be?
What is this guidance based upon?

What is the reason for not making that upper limit a default and let
rhash_entries override to make it larger if a site actually needed it?

Thank you in advance,
Robin Holt
