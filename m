Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUCQPma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUCQPma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 10:42:30 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60817
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261611AbUCQPm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 10:42:29 -0500
Date: Wed, 17 Mar 2004 16:43:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-rc1 shm paging blocker
Message-ID: <20040317154314.GG2106@dualathlon.random>
References: <20040317061522.GN30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040317061522.GN30940@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it seems the testing I did on 2.6.5-rc1 was incorrect (after testing
another 2 combinations of kernels were the problem exists I may have not
waited long enough while testing 2.6.5-rc1 for the first time and I
mistaken a sluggishness for a live lock and I clicked reboot too early,
that's the only reasonable explanation), it's working correctly now
(like it works fine with 2.6.5-rc1 - backout + objrmap + anon_vma so
it's impossible that it was my changes triggering it). If it happens
again I'll let you know. I still have to find what cause it in another
combinations of vm patches. Andrew, now that you've the testcase could
you test the -mm tree, and see if happens there, some -mm patch is one
of the diffs between the working tree and the non-working one.

However now I'll repeat all tests, if they works all flawlessy today I
will be very annoyed, since the thing was definitely not swapping at all
yesterday, no matter how long I awaited.

Now I start to wonder if kbuild may have screwed my kernel, effectively
it was a development tree, I don't run make distclean anymore in between
the kernel compiles (I almost don't feel the need of ccache anymoe ;),
but maybe I'm wrong trusting the buildsystem can be smart enough.
