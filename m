Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUBRQM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUBRQM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:12:27 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:64385 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263793AbUBRQMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:12:25 -0500
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20040217235431.GF6242@redhat.com>
	<wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org>
	<20040218111612.GM6242@redhat.com>
	<wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
	<20040218155317.GQ6242@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 18 Feb 2004 17:12:15 +0100
Message-ID: <wrp8yj04ba8.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040218155317.GQ6242@redhat.com> (Dave Jones's message of
 "Wed, 18 Feb 2004 15:53:17 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> kernel: kobject_register failed for hp100 (-17)

-17 == -EEXIST.

Looks like the driver was already loaded once, or managed to leave
some sh*t into sysfs.

Dave> Something also seems awry someplace else..

Dave> (15:54:51:root@mindphaser:linux-2.6.2)# cat /proc/modules  | grep hp100
Dave> (15:54:55:root@mindphaser:linux-2.6.2)# rmmod hp100
Dave> ERROR: Module hp100 does not exist in /proc/modules
Dave> (15:55:18:root@mindphaser:linux-2.6.2)# modprobe hp100
Dave> FATAL: Module hp100 already in kernel.
Dave> (15:55:25:root@mindphaser:linux-2.6.2)# cat /proc/modules | grep hp100
Dave> (15:55:33:root@mindphaser:linux-2.6.2)#

Dave> Odd.

I've already seen that with half-initialized modules...

	M.
-- 
Places change, faces change. Life is so very strange.
