Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUI0S0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUI0S0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUI0S0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:26:40 -0400
Received: from sa8.bezeqint.net ([192.115.104.22]:5575 "EHLO sa8.bezeqint.net")
	by vger.kernel.org with ESMTP id S266905AbUI0S0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:26:39 -0400
Date: Mon, 27 Sep 2004 21:27:45 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc2-mm4 + alps locks input in X
Message-ID: <20040927192744.GA8947@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a conflict between the new changes to the input
system (as in 2.6.9-rc2-mm4 and 2.6.9-rc2-bk13) and the alps patch.

I tried both with mm4 with the already included alps patch and with
bk11 and bk13 with the patch manually applied. In both cases when
starting X with the alps driver input is completely dead in X, both
mouse and keyboard, including sysrq keys and num-lock/caps-lock.

I can ssh in, kill X and everything is functional again (although the
keyboard behaves as if num-lock is presses, enabling/disabling it
solves that).

If I start X with the ImPS/2 driver with the same kernel then the input
works fine except for the mouse being a bit slow.

In console everything is working fine.

The same setup works in 2.6.9-rc2 and backward with the alps patch.

I've mostly exhausted my knowledge. Will be happy for pointers/ideas to
locate the cause.
