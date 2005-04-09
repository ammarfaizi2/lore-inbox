Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVDIWtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDIWtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 18:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVDIWtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 18:49:49 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:12958
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261398AbVDIWtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 18:49:46 -0400
Date: Sat, 9 Apr 2005 15:46:12 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mingo@elte.hu, tony.luck@intel.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-Id: <20050409154612.55d6a6fa.davem@davemloft.net>
In-Reply-To: <1113038543.9568.430.camel@gaston>
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com>
	<20050409043848.GA2677@elte.hu>
	<1113038543.9568.430.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Apr 2005 19:22:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> ppc64 already has a local_irq_save/restore in switch_to, around the low
> level asm bits, so it should be fine.

Sparc64 essentially does as well.  In fact, it uses an IRQ disable
which is stronger  than local_irq_save in that it disables reception
of CPU cross-calls as well.
