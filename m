Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265779AbUEZTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbUEZTcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUEZTcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:32:39 -0400
Received: from zero.aec.at ([193.170.194.10]:774 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265779AbUEZTch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:32:37 -0400
To: "David S. Miller" <davem@redhat.com>
cc: joern@wohnheim.fh-wedel.de, mingo@elte.hu, andrea@suse.de, riel@redhat.com,
       torvalds@osdl.org, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it>
	<1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it>
	<206b3-5WN-33@gated-at.bofh.it> <20baw-1Lz-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 26 May 2004 21:32:32 +0200
In-Reply-To: <20baw-1Lz-15@gated-at.bofh.it> (David S. Miller's message of
 "Wed, 26 May 2004 20:20:08 +0200")
Message-ID: <m38yff7zn3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>> Change gcc to catch stack overflows before the fact and disallow
>> module load unless modules have those checks as well.

It's impossible to do anything but panic, so it's not too helpful
in practice. You can only do better for interrupts
(not handle an interrupt when the stack is too low).

> That's easy, just enable profiling then implement a suitable
> _mcount that checks for stack overflow.  I bet someone has done
> this already.

I did it for x86-64 a long time ago. Should be easy to port to i386 
too.

ftp://ftp.x86-64.org/pub/linux/debug/stackcheck-1

-Andi

