Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbULBU0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbULBU0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULBU0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:26:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:5782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261748AbULBU0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:26:43 -0500
Date: Thu, 2 Dec 2004 12:25:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: zaphodb@zaphods.net, marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041202122546.59ff814f.akpm@osdl.org>
In-Reply-To: <20041202195422.GA20771@mail.muni.cz>
References: <20041109203348.GD8414@logos.cnet>
	<20041110212818.GC25410@mail.muni.cz>
	<20041110181148.GA12867@logos.cnet>
	<20041111214435.GB29112@mail.muni.cz>
	<4194A7F9.5080503@cyberone.com.au>
	<20041113144743.GL20754@zaphods.net>
	<20041116093311.GD11482@logos.cnet>
	<20041116170527.GA3525@mail.muni.cz>
	<20041121014350.GJ4999@zaphods.net>
	<20041121024226.GK4999@zaphods.net>
	<20041202195422.GA20771@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> I found out that 2.6.6-bk4 kernel is OK. 

That kernel didn't have the TSO thing.  Pretty much all of these reports
have been against e1000_alloc_rx_buffers() since the TSO changes went in.

I may have been asleep at the time.  Could someone pleeeeze explain to me
why the introduction of TSO has thrown this additional pressure onto the
atomic memory allocations?

Did you try disabling TSO, btw?

