Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945921AbWJSAVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945921AbWJSAVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945922AbWJSAVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:21:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945921AbWJSAVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:21:43 -0400
Date: Wed, 18 Oct 2006 17:21:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018172139.3a77a927.akpm@osdl.org>
In-Reply-To: <1161216479.18117.45.camel@dyn9047017100.beaverton.ibm.com>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	<45364CE9.7050002@yahoo.com.au>
	<1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	<45366515.4050308@yahoo.com.au>
	<1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	<20061018154402.ef49874a.akpm@osdl.org>
	<1161212465.18117.35.camel@dyn9047017100.beaverton.ibm.com>
	<20061018162507.efa7b91a.akpm@osdl.org>
	<1161216479.18117.45.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 17:07:59 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> > What does it say in /proc/interrupts?
> > 
> > The x86_64 nmi watchdog handling looks rather complex.
> > 
> > <checks a couple of x86-64 machines>
> > 
> > The /proc/interrutps NMI count seems to be going up by about
> > one-per-minute.  How odd.   Maybe you just need to wait longer.
> 
> 
> While the soft lock up messages are getting printed..
> (waited for 5 min for these messages)..
> 
> # while :; do grep NMI /proc/interrupts; sleep 30; done
> NMI:        265         73         41         47
> NMI:        265         81         62         47
> NMI:        265         81         71         69
> NMI:        265         81         93         77
> NMI:        265         81        101         99
> NMI:        288         82        101        107
> NMI:        296         82        131        129
> NMI:        296         82        153        137
> NMI:        296         82        161        160
> NMI:        296        105        161        167
> NMI:        296        112        184        167
> 
> Looking at the messages, I don't think trace all cpus
> is working ..

nfi what's going on there.  On my Conroe machine each CPU's NMI count goes
up by what apepars to be one-per-second when the CPUs are flat out busy,
but the count increases by random small amounts (like yours) when the
machine is idle.

Did you try setting nmi_watchdog=?
