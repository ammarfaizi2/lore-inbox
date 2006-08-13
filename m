Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWHMX1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWHMX1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWHMX1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:27:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751722AbWHMX1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:27:33 -0400
Date: Sun, 13 Aug 2006 19:25:50 -0400
From: Dave Jones <davej@redhat.com>
To: Ben Buxton <kernel@bb.cactii.net>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060813232549.GG28540@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Buxton <kernel@bb.cactii.net>, Andrew Morton <akpm@osdl.org>,
	Maciej Rutecki <maciej.rutecki@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813224413.GA21959@cactii.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 12:44:13AM +0200, Ben Buxton wrote:

 > Also, whenever I echo anything to "scaling_governor", I get the
 > following kernel message:
 > 
 > [  734.156000] BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 > [  734.156000]  [<c013c3ec>] lock_cpu_hotplug+0x7c/0x90
 > [  734.156000]  [<c01327f4>] __create_workqueue+0x44/0x140
 > [  734.156000]  [<c02dcf7b>] mutex_lock+0xb/0x20
 > [  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310 [cpufreq_ondemand]

This makes no sense at all, because in -mm __create_workqueue doesn't
call lock_cpu_hotplug().

Are you sure this was from a tree with -mm1 applied ?

		Dave

-- 
http://www.codemonkey.org.uk
