Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUHIRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUHIRMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHIRMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:12:37 -0400
Received: from mail.zmailer.org ([62.78.96.67]:34188 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S266749AbUHIRMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:12:35 -0400
Date: Mon, 9 Aug 2004 20:12:31 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Bob Deblier <bob.deblier@telenet.be>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
Message-ID: <20040809171231.GG2716@mea-ext.zmailer.org>
References: <2riR3-7U5-3@gated-at.bofh.it> <m3d620v11e.fsf@averell.firstfloor.org> <1092067328.4332.40.camel@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092067328.4332.40.camel@orion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 06:02:08PM +0200, Bob Deblier wrote:
...
> BeeCrypt contains benchmarks in the 'tests' subdirectory. Running of
> 'make bench' will execute them. Benchmarks results below for repeatedly
> looping over the same 16K block, produced by 'benchbc', without any
> tweaks (YMMV):

Usage of MMX inside the Linux kernel is like the usage of FP inside
the Linux kernel:  Can be done after jumping complex hoops, BUT NOT
RECOMMENDED... (MMX in intertwined with FP hardware, after all.)

You have to do lots of the MMXes in order to win after amortizing those
necessary hoops...  RAID-5 code does XOR via MMX code, under some 
conditions.  ... where that happens to become a win.

> P4 2400, with MMX:
> ECB encrypted 738304 KB in 10.00 seconds = 73823.02 KB/s
> CBC encrypted 659456 KB in 10.00 seconds = 65925.82 KB/s
> ECB decrypted 765952 KB in 10.00 seconds = 76564.57 KB/s
> CBC decrypted 616448 KB in 10.02 seconds = 61546.33 KB/s
> 
> P4 2400, plain i386:
> ECB encrypted 584704 KB in 10.01 seconds = 58435.34 KB/s
> CBC encrypted 570368 KB in 10.01 seconds = 56979.82 KB/s
> ECB decrypted 444416 KB in 10.02 seconds = 44357.32 KB/s
> CBC decrypted 423936 KB in 10.02 seconds = 42304.76 KB/s
...
> Sincerely,
> 
> Bob Deblier

/Matti Aarnio
