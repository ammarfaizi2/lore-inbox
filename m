Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVBODSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVBODSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVBODSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:18:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:15029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261608AbVBODSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:18:03 -0500
Date: Mon, 14 Feb 2005 19:17:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-Id: <20050214191735.6330ce1f.akpm@osdl.org>
In-Reply-To: <20050214214148.GM13712@opteron.random>
References: <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com>
	<20050210190521.GN18573@opteron.random>
	<Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com>
	<20050210204025.GS18573@opteron.random>
	<Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com>
	<20050211085239.GD18573@opteron.random>
	<Pine.LNX.4.61.0502111258310.7808@goblin.wat.veritas.com>
	<20050214174158.GE13712@opteron.random>
	<Pine.LNX.4.61.0502141815320.9608@goblin.wat.veritas.com>
	<20050214214148.GM13712@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> you're right something might be different now
>  that we don't follow a swapout virtual address space order anymore

There's a patch in -mm which attempts to do so, and afair, succeeds.

However the performance seems to be crappy.  Its main benefit at present
is in reducing worst-case scheduling latencies (scan_swap_map).

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm2/broken-out/swapspace-layout-improvements-fix.patch
