Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJEJvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTJEJvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:51:04 -0400
Received: from zero.aec.at ([193.170.194.10]:59140 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263053AbTJEJvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:51:03 -0400
To: David B Harris <david@eelf.ddts.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6 scheduler goodness
From: Andi Kleen <ak@muc.de>
Date: Sun, 05 Oct 2003 11:50:52 +0200
In-Reply-To: <D0zL.3Ew.19@gated-at.bofh.it> (David B Harris's message of
 "Sat, 04 Oct 2003 21:50:10 +0200")
Message-ID: <m3n0cgau83.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <D0zL.3Ew.19@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David B Harris <david@eelf.ddts.net> writes:

> 4) In either 2.6.0-test5, or 2.6.0-test6 (I'm using 2.6.0-test6, I
> skipped test5), responsiveness was magically fixed for my workload case.
> I still have lower throughput, apparently (big compiles and whatnot take
> about 20% longer), but I recently got a CPU upgrade so I don't

Everything CPU bound should run a few percent slower on 2.6 because
it uses HZ=1000. You could recompile with HZ=100 and see if that fixes
that (just change HZ to 100 in asm/param.h)

20% sounds a big high just for HZ degradation though.

-Andi

