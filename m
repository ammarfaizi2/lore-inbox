Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTIWGfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 02:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTIWGfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 02:35:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55509 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262974AbTIWGfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 02:35:34 -0400
Date: Mon, 22 Sep 2003 23:22:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: peter@chubb.wattle.id.au, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030922232237.28a5ac4a.davem@redhat.com>
In-Reply-To: <20030922203629.B21836@kvack.org>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Sep 2003 20:36:29 -0400
Benjamin LaHaise <bcrl@kvack.org> wrote:

> Denied.  Dave, please explain.

Why should I have anything to explain? :-)

The fact that ia64 is doing a printk for an unaligned kernel
load or store is what you should be asking questions about :)

It's one thing if ia64 keeps track of unaligned accesses as
a counter statistic, but emitting a printk for everyone is
pretty anti-social.

Unaligned accesses in the kernel are perfectly normal, and are
absolutely going to happen in various kinds of networking setups.
