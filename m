Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWKJWcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWKJWcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424455AbWKJWcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:32:47 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:192 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1422737AbWKJWcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:32:47 -0500
Date: Fri, 10 Nov 2006 22:33:04 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Re: MIPS atomic operations, "sync"
Message-ID: <20061110223303.GA17712@linux-mips.org>
References: <20061110184049.GA24977@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110184049.GA24977@Krystal>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 01:40:49PM -0500, Mathieu Desnoyers wrote:

> I am currently creating a "LOCK" prefix free and memory barrier free version
> of atomic.h to fulfill my tracer (LTTng) needs, which is to atomically update
> per-cpu data and have a minimal performance loss.
> 
> I just came across the MIPS atomic.h and system.h implementations in 2.6.18
> which brings a question :
> 
> Why are the primitives in include/asm-mips/atomic.h using the "sync"
> instruction even in the UP case ? system.h cmpxchg only uses the sync in the
> SMP case.

Why are the standard atomic operations insufficient for your needs?

There is an enormous amout of subtilities in those atomic ops for some
architectures you probably do yourself a big favor by avoiding new
variants.

  Ralf
