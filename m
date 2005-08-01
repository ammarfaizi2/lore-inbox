Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVHAB6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVHAB6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 21:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVHAB6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 21:58:48 -0400
Received: from fmr17.intel.com ([134.134.136.16]:28319 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261881AbVHAB6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 21:58:47 -0400
Subject: Re: revert yenta free_irq on suspend
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Adam Belay <ambx1@neo.rr.com>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Len Brown <len.brown@intel.com>
In-Reply-To: <2e00842e116e.2e116e2e0084@columbus.rr.com>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 09:59:02 +0800
Message-Id: <1122861542.2953.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> In general, I think that calling free_irq is the right behavior.
> Although irqs changing after suspend is rare, there are also some
> more serious issues.  This has been discussed in the past, and a
> summary is as follows:
irqs actually isn't changed after suspend currently, it's a considering
for future usage like hotplug.
Calling free_irq actually isn't a complete ACPI issue, but ACPI requires
it to solve nasty 'sleep in atomic' warning. You will find such break
with swsusp without ACPI. Could we revert the ACPI change in Linus's
tree but keep it in -mm tree? So we get a chance to fix drivers.

Thanks,
Shaohua

