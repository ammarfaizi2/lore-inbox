Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbUKTHF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUKTHF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKTHFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:05:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:3997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbUKTHEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:04:38 -0500
Date: Fri, 19 Nov 2004 23:04:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: nickpiggin@yahoo.com.au, wli@holomorphy.com, torvalds@osdl.org,
       clameter@sgi.com, benh@kernel.crashing.org, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-Id: <20041119230418.6070ab89.akpm@osdl.org>
In-Reply-To: <20041119225701.0279f846.akpm@osdl.org>
References: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org>
	<20041120020306.GA2714@holomorphy.com>
	<419EBBE0.4010303@yahoo.com.au>
	<20041120035510.GH2714@holomorphy.com>
	<419EC205.5030604@yahoo.com.au>
	<20041120042340.GJ2714@holomorphy.com>
	<419EC829.4040704@yahoo.com.au>
	<20041120053802.GL2714@holomorphy.com>
	<419EDB21.3070707@yahoo.com.au>
	<20041120062341.GM2714@holomorphy.com>
	<419EE911.20205@yahoo.com.au>
	<20041119225701.0279f846.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I'd expect that just shoving a pointer into mm_struct which points at a
>  dynamically allocated array[NR_CPUS] of longs would suffice.

One might even be able to use percpu_counter.h, although that might end up
hurting many-cpu fork times, due to all that work in __alloc_percpu().
