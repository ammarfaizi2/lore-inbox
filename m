Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbULMNDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbULMNDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbULMNDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:03:33 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:9134 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262257AbULMNDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:03:23 -0500
Date: Mon, 13 Dec 2004 14:01:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041213130142.GZ16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local> <20041213112229.GS6272@elf.ucw.cz> <1102942270.17225.81.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102942270.17225.81.camel@linux.local>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 01:51:11PM +0100, Hans Kristian Rosbach wrote:
> then in the rest of the code we can use ex:
> schedule_timeout(varX*100) for 100ms no matter what hz is.

There's not real difference between a multiplication or a division,
and for either cases it doesn't worth to optimize such usage IMHO. I
believe the only real cost is the cacheline anyway.
