Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266702AbUGQKUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266702AbUGQKUv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266701AbUGQKUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 06:20:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:30165 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266682AbUGQKUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 06:20:48 -0400
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: fix for unkillable zombie task
References: <16632.21429.257483.650452@napali.hpl.hp.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I want to read my new poem about pork brains and outer space...
Date: Sat, 17 Jul 2004 12:20:46 +0200
In-Reply-To: <16632.21429.257483.650452@napali.hpl.hp.com> (David
 Mosberger's message of "Fri, 16 Jul 2004 15:16:21 -0700")
Message-ID: <jesmbr3pfl.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

> I got a bugreport where a ptrace'd task would end up in an unkillable
> zombie state if the (real) parent of the task happened to ignore
> SIGCHLD.  The patch below should fix the problem.  I attached a
> self-contained test program.  If the bug is present, you should
> see:
>
>  FAILURE: child PID seems to be still around!
>
> at the end (and there will be an unkillable zombie).

Could this be the same problem as discussed in the thread at
<http://marc.theaimsgroup.com/?t=108857537300002&r=1&w=2>?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
