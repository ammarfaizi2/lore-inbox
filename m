Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUINMVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUINMVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269360AbUINMUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:20:46 -0400
Received: from math.ut.ee ([193.40.5.125]:28111 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S269330AbUINLrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:47:16 -0400
Date: Tue, 14 Sep 2004 14:47:14 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: kconfig: selecting an undefined symbol
Message-ID: <Pine.GSO.4.44.0409141444300.10355-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/Kconfig:466:warning: 'select' used by config symbol 'FB_I810' refer to undefined symbol 'AGP'
drivers/video/Kconfig:467:warning: 'select' used by config symbol 'FB_I810' refer to undefined symbol 'AGP_INTEL'

This comes from

config FB_I810
        tristate "Intel 810/815 support (EXPERIMENTAL)"
        depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64
        select AGP
        select AGP_INTEL
        select FB_MODE_HELPERS

it really depends on X86 but AGP and AGP_INTEL are still not selectable
on sparc64.

Any good way to cure it?

-- 
Meelis Roos (mroos@linux.ee)

