Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUK3DRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUK3DRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUK3DRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:17:13 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54199
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261936AbUK3DRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:17:10 -0500
Date: Mon, 29 Nov 2004 19:14:29 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, wli@holomorphy.com
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for
 CONFIG_XEN
Message-Id: <20041129191429.3e17192f.davem@davemloft.net>
In-Reply-To: <20041130030812.GN4365@dualathlon.random>
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk>
	<E1CVI5c-0004bf-00@mta1.cl.cam.ac.uk>
	<20041130030812.GN4365@dualathlon.random>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 04:08:12 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> There's also an issue with io_remap_page_range where sparc has 6 args
> while everyone else has 5 args.

It's there to handle larger than 32-bit I/O physical addresses
on sparc32.

WLI's work on remap_pfn_range() was meant to eventually turn
the various io_remap_page_range() routines over the be pfn
based as well.  Then sparc32 wouldn't need that extra arg
any longer.
