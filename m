Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWGKMCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWGKMCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWGKMCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:02:13 -0400
Received: from verein.lst.de ([213.95.11.210]:57739 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751231AbWGKMCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:02:12 -0400
Date: Tue, 11 Jul 2006 14:01:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, bunk@stusta.de
Cc: linux-kernel@vger.kernel.org
Subject: commit '[PATCH] kernel/softirq.c: EXPORT_UNUSED_SYMBOL'
Message-ID: <20060711120159.GA20601@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=80d6679a62fe45f440d042099d997a42e4e8c59d

open_softirq just enables a softirq.  The softirq array is statically
allocated so to add a new one you would have to patch the kernel.  So
there's no point to keep this export at all as any user would have to
patch the enum in include/linux/interrupt.h anyway.  Adrian, care to
submit a patch to kill this senseless export entirely?

