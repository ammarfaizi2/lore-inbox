Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTEERZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEERZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:25:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6467 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261151AbTEERZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:25:03 -0400
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 May 2003 11:34:24 -0600
In-Reply-To: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
Message-ID: <m1d6ixb8m7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So summarize:
1) Run multiple kernels (minimally kernels A and B)
2) Migrate processes from kernel A to kernel B
3) Use kexec to replace kernel A once all processes have left.
4) Repeat for all other kernels.

On two simple machines working in tandem (The most common variation
used for high availability this should be easy to do).  And it is
preferable to a reboot because of the additional control and speed.

Thank you for the perspective.  This looks like I line I can
sell to get some official time to work on kexec and it's friends
more actively.

>From what I have seen process migration/process check-pointing is
currently the very rough area.

The interesting thing becomes how do you measure system uptime.

Eric
