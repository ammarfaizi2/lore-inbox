Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJRTTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTJRTTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:19:37 -0400
Received: from ns.suse.de ([195.135.220.2]:31155 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261775AbTJRTTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:19:35 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <20031015225055.GS17986@fs.tum.de.suse.lists.linux.kernel>
	<20031015161251.7de440ab.akpm@osdl.org.suse.lists.linux.kernel>
	<20031015232440.GU17986@fs.tum.de.suse.lists.linux.kernel>
	<20031015165205.0cc40606.akpm@osdl.org.suse.lists.linux.kernel>
	<20031018102127.GE12423@fs.tum.de.suse.lists.linux.kernel>
	<649730000.1066491920@[10.10.2.4].suse.lists.linux.kernel>
	<20031018102402.3576af6c.akpm@osdl.org.suse.lists.linux.kernel>
	<20031018174434.GJ12423@fs.tum.de.suse.lists.linux.kernel>
	<20031018105733.380ea8d2.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Oct 2003 21:19:32 +0200
In-Reply-To: <20031018105733.380ea8d2.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p731xtapd4r.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> And bear in mind that you can see significant changes in benchmark results
> between equivalent kernels even when the optimisation level is kept the
> same, due to aliasing and alignment luck.

It also depends on a lot on the compiler version. On 2.95 
it was common wisdom that -Os is often fastest, but that changed
in later versions.

Best would be actually a mix of both - setting it case by case.
That's already done in specific cases, e.g. ACPI is always compiled
with -Os. This could be done for other files which are clearly
slow path too.

Profile feedback is unfortunately not an option because it is too
unpredictable and causes maintenance problems.

-Andi
