Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTHSX6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbTHSX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:58:03 -0400
Received: from colin2.muc.de ([193.149.48.15]:42505 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261539AbTHSX6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:58:01 -0400
Date: 20 Aug 2003 01:57:59 +0200
Date: Wed, 20 Aug 2003 01:57:59 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by cpumask_t conversion
Message-ID: <20030819235759.GB65297@colin2.muc.de>
References: <mnCB.1md.29@gated-at.bofh.it> <m3y8xpqktd.fsf@averell.firstfloor.org> <20030819235126.GC4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819235126.GC4306@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Odd; I have a UP IO-APIC ia32 box here and it appears to do okay; there
> is a question of sparse APIC ID's and APIC ID space needing to be
> independent of NR_CPUS handled in the ia32 code that isn't handled in
> the x86_64 code. It was handled for ia32 by using a bitmap of size
> MAX_APICS (physid_mask_t) instead of cpumask_t for the things, which
> appears to eliminate various special cases for xAPIC's too.

Ok, then the physid_mask_t code needs to be ported over to x86-64.

-Andi
