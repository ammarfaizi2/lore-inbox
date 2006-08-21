Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWHUUKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWHUUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWHUUKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:10:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:26517 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750892AbWHUUKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:10:15 -0400
Date: Mon, 21 Aug 2006 22:10:09 +0200
From: Andi Kleen <ak@suse.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: vgoyal@in.ibm.com, Magnus Damm <magnus.damm@gmail.com>,
       Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is
 used.
Message-Id: <20060821221009.a43cfbf0.ak@suse.de>
In-Reply-To: <m1fyfpuabb.fsf@ebiederm.dsl.xmission.com>
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<200608211624.11005.ak@suse.de>
	<20060821144657.GE9549@in.ibm.com>
	<200608211704.03061.ak@suse.de>
	<m1fyfpuabb.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not certain I caught everything but as far as I know I did.
> Part of that was by having the code run at a fixed virtual address so
> we still live in the last 2GB of the virtual address space.

You changed the -2GB (or rather -40MB unpatched) mapping to not necessarily 
be linear? There are a couple of assumptions that it is, including at boot up
(it doubles as the 1:1 mapping then) and in change_page_attr() and in suspend/resume.

-Andi
