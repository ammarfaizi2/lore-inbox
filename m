Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUHJJix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUHJJix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUHJJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:38:53 -0400
Received: from holomorphy.com ([207.189.100.168]:34279 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263733AbUHJJiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:38:46 -0400
Date: Tue, 10 Aug 2004 02:38:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810093831.GM11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080430.GA25866@elte.hu> <20040810090051.GK11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810090051.GK11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:45:46PM -0700, William Lee Irwin III wrote:
>>> None of the printk()'s in do_boot_cpu() appear essential. The
>>> following also boots:

On Tue, Aug 10, 2004 at 10:04:30AM +0200, Ingo Molnar wrote:
>> the key seems to be not doing fork_idle() call via keventd?
>> i'm wondering about:

On Tue, Aug 10, 2004 at 02:00:51AM -0700, William Lee Irwin III wrote:
> It deadlocks with or without the fork_idle() call being via keventd;
> the printk change is what makes the difference. =(

Okay, it deadlocks with both mdelay(1000) and yield() in place of the
printk(). Trying manual calls to schedule() and local_irq_enable() next.


-- wli
