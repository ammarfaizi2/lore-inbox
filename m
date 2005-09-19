Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVISS31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVISS31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVISS31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:29:27 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:39053 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932555AbVISS30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:29:26 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: ecashin@coraid.com, linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
X-Message-Flag: Warning: May contain useful information
References: <87u0glxhfw.fsf@coraid.com>
	<20050916.163554.79765706.davem@davemloft.net>
	<87slw1b0fz.fsf@coraid.com>
	<20050919.112159.55767801.davem@davemloft.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 19 Sep 2005 11:29:16 -0700
In-Reply-To: <20050919.112159.55767801.davem@davemloft.net> (David S.
 Miller's message of "Mon, 19 Sep 2005 11:21:59 -0700 (PDT)")
Message-ID: <52irwwgbcz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 19 Sep 2005 18:29:17.0724 (UTC) FILETIME=[0B71F5C0:01C5BD48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Although it's very much discouraged to dereference
    David> unaligned pointers, especially in performance critical code
    David> (which this AOE case is not, thankfully), because
    David> performance will be really bad as the trap handler has to
    David> fix up the access on RISC platforms. 

Also, ia64 has a tendency to print an ugly message in the kernel log
for unaligned accesses.  Has anyone tried AoE on ia64?

It might be better to change the AoE code to use get_unaligned(), just
to document what's going on.  Although clearly the sparc64 patch is
correct as well -- we should never silently return the wrong data.

 - R.
