Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWBCWGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWBCWGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBCWGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWBCWGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:06:14 -0500
Date: Fri, 3 Feb 2006 14:07:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, shai@scalex86.org,
       clameter@engr.sgi.com, alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 0/3] NUMA slab locking fixes
Message-Id: <20060203140748.082c11ee.akpm@osdl.org>
In-Reply-To: <20060203205341.GC3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> There were some locking oddities in the NUMA slab allocator which broke cpu
> hotplug.  Here is a patchset to correct locking and also fix the
> breakage with cpu hotplug Sonny Rao noticed on POWER5.

These patches are on rc1-mm4, which unfortunately contains quite a lot of
-mm-only debugging stuff in slab.c.

Could you please redo/retest these patches so that they apply on
2.6.16-rc2.  Also, please arrange for any bugfixes to be staged ahead of
any optimisations - the optimisations we can defer until 2.6.17.
