Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUHDR2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUHDR2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUHDR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:28:12 -0400
Received: from zero.aec.at ([193.170.194.10]:9476 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267335AbUHDR2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:28:08 -0400
To: "David S. Miller" <davem@redhat.com>
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
References: <2ppN4-1wi-11@gated-at.bofh.it> <2pvps-5xO-33@gated-at.bofh.it>
	<2pvz2-5Lf-19@gated-at.bofh.it> <2pwbQ-68b-43@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 04 Aug 2004 19:28:04 +0200
In-Reply-To: <2pwbQ-68b-43@gated-at.bofh.it> (David S. Miller's message of
 "Wed, 04 Aug 2004 17:50:14 +0200")
Message-ID: <m33c32ke3f.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>
> Or use a more portable well-defined type which does not change
> size nor layout between 32-bit and 64-bit environments.

That is usually a mistake. People get the more subtle issues
like long long handling wrong, and then it is impossible to fix it 
anymore in a compat layer (examples are ipsec and iptables, which
cannot be emulated on x86-64 because of that) 

So please never pass any structures with read/write/netlink.

Thank you.

-Andi

