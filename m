Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUCGMKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCGMKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:10:25 -0500
Received: from zero.aec.at ([193.170.194.10]:39685 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261841AbUCGMKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:10:24 -0500
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <1uofN-4Rh-25@gated-at.bofh.it> <1vRz3-5p2-11@gated-at.bofh.it>
	<1vRSn-5Fc-11@gated-at.bofh.it> <1vS26-5On-21@gated-at.bofh.it>
	<1wkUr-3QW-11@gated-at.bofh.it> <1wolx-7ET-31@gated-at.bofh.it>
	<1woEJ-7Yx-25@gated-at.bofh.it> <1wp8c-7x-5@gated-at.bofh.it>
	<1wprd-qI-21@gated-at.bofh.it> <1wpUz-Tw-21@gated-at.bofh.it>
	<1x293-2nT-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 12 Mar 2004 22:25:05 +0100
In-Reply-To: <1x293-2nT-7@gated-at.bofh.it> (Ingo Molnar's message of "Sun,
 07 Mar 2004 09:50:09 +0100")
Message-ID: <m3ekrx4v2m.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> but i'm quite strongly convinced that 'getting rid' of the 'pte chain
> overhead' in favor of questionable lowmem space gains for a dying
> (high-end server) platform is very shortsighted. [getting rid of them
> for purposes of the 64-bit platforms could be OK, but the argumentation
> isnt that strong there i think.]

pte chain locking seems to be still quite far up in profile logs of
2.6 on x86-64 for common workloads. It's nonexistent in mainline
2.4. I would consider this a strong reason to do something about that.

-Andi

