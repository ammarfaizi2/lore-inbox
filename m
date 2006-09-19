Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWISQmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWISQmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWISQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:42:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30647 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030240AbWISQmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:42:06 -0400
Date: Tue, 19 Sep 2006 11:41:59 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH] Migration of Standard Timers
Message-ID: <20060919164159.GC26863@sgi.com>
References: <20060919152942.GA26863@sgi.com> <1158683617.11682.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158683617.11682.14.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 12:33:37PM -0400, Lee Revell wrote:
> Which driver or subsystem is doing 100s of usecs of work in a timer?

The longest one I've captured so far results from:

rsp                rip                Function (args)
 ======================= <nmi>
0xffff810257822fd8 0xffffffff803a0e94 rt_check_expire+0x8c
 ======================= <interrupt>  
0xffff81025781fee8 0xffffffff803a0e08 rt_check_expire
0xffff81025781ff08 0xffffffff802386b3 run_timer_softirq+0x133
0xffff81025781ff38 0xffffffff80235262 __do_softirq+0x5e
0xffff81025781ff68 0xffffffff8020a958 call_softirq+0x1c
0xffff81025781ff80 0xffffffff8020bea7 do_softirq+0x2c
0xffff81025781ff90 0xffffffff80235142 irq_exit+0x48

> Shouldn't another mechanism like a workqueue be used instead?

Not quite sure what you're asking here.
