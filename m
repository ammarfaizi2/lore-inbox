Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUG0T0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUG0T0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUG0T0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:26:35 -0400
Received: from [195.199.63.65] ([195.199.63.65]:50611 "EHLO cinke.fazekas.hu")
	by vger.kernel.org with ESMTP id S266502AbUG0TZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:25:56 -0400
Date: Tue, 27 Jul 2004 21:25:33 +0200 (CEST)
From: Balint Marton <cus@fazekas.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_random_bytes returns the same on every boot
In-Reply-To: <m3ekmxmjm6.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0407272020591.23550@cinke.fazekas.hu>
References: <2kUHO-6hJ-15@gated-at.bofh.it> <m3ekmxmjm6.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andi Kleen wrote:
> That still is an easily predictible value and may not even be 
> unique when lots of systems are powered up at the same time
> (e.g. after a power failure) 
Yes, my patch is not an ultimate solution, rather a step in the working
way :)
 
> Also BTW your problem presents a strong case why compiling in
> DHCP probes is bad and such stuff should run from initrd/initramfs.
I wouldn't say, its bad, it is only not supported yet under all
circumstances. But DHCP support may be improved for example by adding the
MAC address as entropy bytes to the secondary pool. Since we don't
add bytes to the primary pool, we don't harm things that really require
secure random data. Any opinions about this workaround?

Cus
