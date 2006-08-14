Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWHNL4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWHNL4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbWHNL4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:56:40 -0400
Received: from us.cactii.net ([66.160.141.151]:13839 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1751994AbWHNL4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:56:39 -0400
Date: Mon, 14 Aug 2006 13:55:56 +0200
From: Ben Buxton <kernel@bb.cactii.net>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814115556.GA13159@cactii.net>
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net> <20060813232549.GG28540@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813232549.GG28540@redhat.com>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> uttered the following thing:
> On Mon, Aug 14, 2006 at 12:44:13AM +0200, Ben Buxton wrote:
> 
>  > Also, whenever I echo anything to "scaling_governor", I get the
>  > following kernel message:
>  > 
>  > [  734.156000] BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
>  > [  734.156000]  [<c013c3ec>] lock_cpu_hotplug+0x7c/0x90
>  > [  734.156000]  [<c01327f4>] __create_workqueue+0x44/0x140
>  > [  734.156000]  [<c02dcf7b>] mutex_lock+0xb/0x20
>  > [  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310 [cpufreq_ondemand]
> 
> This makes no sense at all, because in -mm __create_workqueue doesn't
> call lock_cpu_hotplug().
> 
> Are you sure this was from a tree with -mm1 applied ?

Definitely 2.6.18-rc4-mm1, and I've done a clean rebuild + removal of
all modules under /lib/modules beforehand.

BB

