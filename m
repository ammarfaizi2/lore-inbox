Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWJEIQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWJEIQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWJEIQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:16:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWJEIQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:16:41 -0400
Date: Thu, 5 Oct 2006 01:16:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Message-Id: <20061005011608.b69e3461.akpm@osdl.org>
In-Reply-To: <20061004172217.092570000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 17:31:29 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> this is an updated replacement queue against -mm3 , with all the
> fixlets backmerged to the appropriate places (Build-fix-from: added).

That all seems to work OK with the two features configged off.

With CONFIG_HIGH_RES_TIMERS=y, CONFIG_NO_HZ=n it's pretty sick.  It pauses
for several seconds after "input: AlpsPS/2 ALPS GlidePoint as
/class/input/input2" (printk-time claims 2 seconds, but it was longer than
that).

It's been stuck for a minute or more at the 12.980000 time, seems to have
hung.  The cursor is flashing extremely slowly.

See http://userweb.kernel.org/~akpm/hrt/
