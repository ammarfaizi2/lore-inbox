Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTKJWti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTKJWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:49:38 -0500
Received: from dp.samba.org ([66.70.73.150]:30624 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264153AbTKJWth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:49:37 -0500
Date: Tue, 11 Nov 2003 09:48:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Dong V Nguyen <dvnguyen@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel: Bind interrupt question.
Message-ID: <20031110224822.GE930@krispykreme>
References: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFEED7A2D8.B2402087-ON87256DDA.007B9132@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Have you seen any problems with interrupt binding on 2.6.0-drv45003 ?
> I tried this command to bind interrupt, but it does not work:
> ============================
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000
> echo 01 > /proc/irq/165/smp_affinity
> cat  /proc/irq/165/smp_affinity
> ffffffff00000000

This is probably a ppc64 specific issue, we can continue this on
linuxppc64-dev@lists.linuxppc.org

> There is nothing changed after binding.
> One thing I see is it shows 16 digits "ffffffff00000000" on 2.6.0 while
> only 8 digits in 2.4 .

Its part of the support for > 32way machines, but it looks like its
broken for some configurations (Im guessing you have CONFIG_NR_CPUS set
to 32).

Anton
