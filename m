Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUGaW7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUGaW7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGaW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 18:59:22 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:39644 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261252AbUGaW7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 18:59:21 -0400
Date: Sat, 31 Jul 2004 19:02:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
In-Reply-To: <20040731205757.GD2334@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0407311902420.4095@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
 <20040731205757.GD2334@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, William Lee Irwin III wrote:

> On Sat, Jul 31, 2004 at 04:52:18PM -0400, Zwane Mwaikambo wrote:
> > The following caused some fireworks whilst merging i386 cpu hotplug.
> > any_online_cpu(0x2) returns 32 on i386 if we're forced to continue past
> > the only set bit due to the additional find_first_bit in the
> > find_next_bit i386 implementation. Not wanting to change current
> > behaviour in the bitops primitives and since the NR_CPUS thing is a
> > cpumask issue, i've opted to fix next_cpu() and first_cpu() instead.
> > Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>
>
> This might save a couple of lines of code.

Nice, i'd prefer that.

