Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUDNPn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUDNPn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:43:58 -0400
Received: from ns.suse.de ([195.135.220.2]:182 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261418AbUDNPn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:43:56 -0400
Date: Wed, 14 Apr 2004 17:43:53 +0200
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, announce@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: x86-64 2.4 tree in strict maintenance mode now
Message-Id: <20040414174353.1dcbda16.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.26 has been finally released. It includes the patches for Intel support and
a few other bug fixes for x86-64. This was about the latest feature I planned
to merge (in fact one more than originally planned) 

2.4/x86-64 is currently in a quite good shape. It is widely used and seems to
generally work well. 2.6 is also good enough now to be used in production.

As far as I'm concerned the 2.4 port of x86-64 is in strict maintenance mode now. 
This means no features will not be accepted anymore; only very clear bug fixes that
fix serious bugs (like oopses or security holes) 

In particular this means that the 32bit emulation is frozen now; any missing ioctls 
etc. are not bugs and will not be fixed in mainline. 

I will also not add workarounds for broken hardware to 2.4 anymore unless the change
is very simple and obvious (and even then it may be not worth it)

For example the recent VIA IOMMU breakage workaround is already 2.6 
only with no plans to backport. If you have buggy or very new hardware you may need 
to migrate to 2.6.

This also means that the 2.4 CVS kernel tree on x86-64.org will be retired.
I expect that the small obvious bug fixes that should be still merged will
be all sent directly to Marcelo and put into the main tree; so there is no need
for an x86-64 private tree anymore.

If you want to do any features or cleanups for x86-64 work on 2.6.

-Andi
