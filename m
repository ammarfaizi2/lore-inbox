Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTJAHY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJAHY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:24:27 -0400
Received: from ns.suse.de ([195.135.220.2]:23775 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262034AbTJAHY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:24:26 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel>
	<20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel>
	<20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel>
	<20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Oct 2003 09:24:23 +0200
In-Reply-To: <20031001065705.GI1131@mail.shareable.org.suse.lists.linux.kernel>
Message-ID: <p73brt1zahk.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> It is easy enough to fix by making the fault handler not take
> mmap_sem if the fault's in the kernel address range.  (With apologies
> to the folk running kernel mode userspace...)

It won't work because kernel can cause user space faults
(think get_user). And handling these must be protected.

-Andi
