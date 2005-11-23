Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVKWMn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKWMn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKWMn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:43:28 -0500
Received: from [139.30.44.16] ([139.30.44.16]:13159 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1750751AbVKWMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:43:27 -0500
Date: Wed, 23 Nov 2005 13:41:35 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: akpm@osdl.org
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: + dont-include-schedh-from-moduleh.patch added to -mm tree
In-Reply-To: <200511050726.jA57QPs7009905@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.63.0511231328020.27662@gockel.physik3.uni-rostock.de>
References: <200511050726.jA57QPs7009905@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things seem to converge in Linus' tree now.

I've rerun my ctags+grep based analysis for all architecures on 
2.6.15-rc1-git6 and 2.6.5-rc2 with the following patches from -mm applied:
  fix-missing-includes-for-2614-git11.patch
  fix-missing-includes-for-2615-rc1.patch
  dont-include-schedh-from-moduleh.patch
I also compile-tested these trees on alpha, arm, i386, ia64, mips, powerpc,  
ppc64, and x86_64 and checked that make -i outputs the same diagnostic 
messages (modulo line number and include order changes) for allnoconfig, 
defconfig, and allmodconfig, whether or not 
dont-include-schedh-from-moduleh.patch was applied to the tree.

None of this brought up any problems.
So from my point of view these patches are okay to go into mainline now.

Andrew, what are your plans for these patches?
Shall I send an updated dont-include-schedh-from-moduleh.patch whose 
changelog reflects the current state of testing?

Thanks,
Tim
