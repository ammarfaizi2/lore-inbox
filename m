Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUJLT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUJLT5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJLT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:57:42 -0400
Received: from zero.aec.at ([193.170.194.10]:12560 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267708AbUJLT5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:57:30 -0400
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: NUMA: Patch for node based swapping
References: <2OwBD-HV-31@gated-at.bofh.it> <2OwUX-Ua-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 12 Oct 2004 21:57:09 +0200
In-Reply-To: <2OwUX-Ua-23@gated-at.bofh.it> (Rik van Riel's message of "Tue,
 12 Oct 2004 17:40:11 +0200")
Message-ID: <m3llebn20a.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> writes:

> On Tue, 12 Oct 2004, Christoph Lameter wrote:
>
>> The minimum may be controlled through /proc/sys/vm/node_swap.
>> By default node_swap is set to 100 which means that kswapd will be run on
>> a zone if less than 10% are available after allocation.
>
> That sounds like an extraordinarily bad idea for eg. AMD64
> systems, which have a very low numa factor.

As a optional sysctl it makes sense even on AMD64. On some benchmarks
you see the differences between local and remote memory very clearly.

-Andi

