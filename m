Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVANBSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVANBSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVANBGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:06:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60941
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261749AbVANBBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:01:19 -0500
Date: Fri, 14 Jan 2005 02:01:32 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: lcall disappeared? kernel CVS destabilized?
Message-ID: <20050114010132.GJ5949@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm porting the seccomp patch to 2.6.10, do you have an idea where lcall
(i.e. call gates for binary compatibility with other OS) went? I can't
find it anywhere. Looks like it was dropped but I must be sure of that,
and especially I must be sure that you don't add it again without me
noticing that I had to patch it ;). Is lcall definitely dead code that I
can forget about or am I missing something? Thanks.

Kernel CVS is broken here, it doesn't even show me the changeset where
lcall disappeared, this returns nothing obvious:

	cvsps -g -r v2_6_8 -f arch/i386/kernel/entry.S

If I use cvsps -x --bkcvs the changesets are screwed.

Note that the entry.S of the kernel CVS has not the lcall, it's
magically forgetting to show me a chageset, and I doubt cvsps is to
blame here, since it was working well for a long time before the thing
destabilized.

Can somebody confirm the kernel CVS is unstable or am I the only one
having deep troubles?
