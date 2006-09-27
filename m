Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030829AbWI0Uyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030829AbWI0Uyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030830AbWI0Uyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:54:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030829AbWI0Uym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:54:42 -0400
Date: Wed, 27 Sep 2006 16:54:35 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: oom kill oddness.
Message-ID: <20060927205435.GF1319@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I have two boxes that are very similar.
Both have 2GB of RAM & 1GB of swap space.
One has a 2.8GHz CPU, the other a 2.93GHz CPU, both dualcore.

The slower box survives a 'make -j bzImage' of a 2.6.18 kernel tree
without incident. (Although it takes ~4 minutes longer than a -j2)

The faster box goes absolutely nuts, oomkilling everything in sight,
until eventually after about 10 minutes, the box locks up dead,
and won't even respond to pings.

Oh, the only other difference - the slower box has 1 disk, whereas the
faster box has two in RAID0.   I'm not surprised that stuff is getting
oom-killed given the pathological scenario, but the fact that the
box never recovered at all is a little odd.  Does md lack some means
of dealing with low memory scenarios ?

	Dave
