Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTIWLER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 07:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTIWLER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 07:04:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10968 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263343AbTIWLEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 07:04:15 -0400
Date: Tue, 23 Sep 2003 03:51:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: bcrl@kvack.org, peter@chubb.wattle.id.au, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923035118.578203d5.davem@redhat.com>
In-Reply-To: <16240.8965.91289.460763@wombat.chubb.wattle.id.au>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
	<16240.8965.91289.460763@wombat.chubb.wattle.id.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 20:40:05 +1000
Peter Chubb <peter@chubb.wattle.id.au> wrote:

> How expensive is it to take the trap and do a fix up, compared to
> making an aligned copy?  As it involves raising and handling a fault
> disassembling the instruction that caused the fault, etc., I'd be
> surprised if it's much less than 1000 cycles, even without the printk,
> although I haven't measured it yet, and can't find enough info in the
> architecture manuals to know what it is.

A cache miss can cause 100 or so cycles. :)

And unlike the fixup trap, the printk wakes up a process and
causes disk activity as syslogd writes to the kernel message
log file.
