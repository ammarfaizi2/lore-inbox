Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUG0UK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUG0UK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUG0UK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:10:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24785 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266568AbUG0UKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:10:24 -0400
Date: Mon, 26 Jul 2004 23:02:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Avi Kivity <avi@exanet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Deadlock during heavy write activity to userspace NFS server on local NFS mount
Message-ID: <20040726210229.GC21889@openzaurus.ucw.cz>
References: <41050300.90800@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41050300.90800@exanet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On heavy write activity, allocators wait synchronously for kswapd to
> free some memory. But if kswapd is freeing memory via a userspace NFS
> server, that server could be waiting for kswapd, and the system seizes
> instantly.
> 
> This patch (against RHEL 2.4.21-15EL, but should apply either 
> literally
> or conceptually to other kernels) allows a process to declare itself 
> as
> kswapd's little helper, and thus will not have to wait on kswapd.

Ok, but what if its memory runs out, anyway?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

