Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUL1DXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUL1DXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbUL1DKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:10:48 -0500
Received: from holomorphy.com ([207.189.100.168]:15318 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262046AbUL1DJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:09:32 -0500
Date: Mon, 27 Dec 2004 19:09:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, akpm@osdl.org,
       James.Bottomley@HansenPartnership.com, paulus@samba.org,
       davem@davemloft.net, lethal@linux-sh.org, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ak@suse.de, rth@twiddle.net, matthew@wil.cx
Subject: Re: [PATCH] fix conflicting cpu_idle() declarations
Message-ID: <20041228030917.GJ771@holomorphy.com>
References: <41D033FE.7AD17627@tv-sign.ru> <20041228.115516.783400549.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041228.115516.783400549.takata.hirokazu@renesas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 11:55:16AM +0900, Hirokazu Takata wrote:
> I think it is OK for m32r.
> BTW, you moved the definition of cpu_idle() to smp.h.
> It may not be included from arch/*/process.c in some archs.
> Is it OK?

It should be okay to include even on UP-only arches, IIRC it has stubs
for UP versions of various locking primitives etc. used widely
throughout the kernel.


-- wli
