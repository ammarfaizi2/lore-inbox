Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWHMAnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWHMAnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHMAnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:43:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50644
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932439AbWHMAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:43:07 -0400
Date: Sat, 12 Aug 2006 17:43:24 -0700 (PDT)
Message-Id: <20060812.174324.77324010.davem@davemloft.net>
To: akpm@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060812162857.d85632b9.akpm@osdl.org>
References: <20060810110627.GM11829@suse.de>
	<20060812162857.d85632b9.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 12 Aug 2006 16:28:57 -0700

> Maybe I missed the discussion.  But if not, this is yet another case of
> significant changes getting into mainline via a git merge and sneaking
> under everyone's radar.

Scsi has been doing command completions via a per-cpu softirq handler
for as long as we've had an SMP more advanced than lock_kernel() :-)
