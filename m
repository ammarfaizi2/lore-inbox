Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWAaWz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWAaWz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWAaWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:55:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750847AbWAaWz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:55:28 -0500
Date: Tue, 31 Jan 2006 14:55:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       hiramatu@sdl.hitachi.co.jp, systemtap@sources.redhat.com,
       jkenisto@us.ibm.com, linux-kernel@vger.kernel.org,
       sugita@sdl.hitachi.co.jp, soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH] kretprobe: kretprobe-booster against 2.6.16-rc1 for
 i386
Message-Id: <20060131145540.3e9a78be.akpm@osdl.org>
In-Reply-To: <43DEC13E.8020200@sdl.hitachi.co.jp>
References: <43DE0A53.3060801@sdl.hitachi.co.jp>
	<43DEC13E.8020200@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>
> -	regs->eip = orig_ret_address;
> 
> -	reset_current_kprobe();
>  	spin_unlock_irqrestore(&kretprobe_lock, flags);
> -	preempt_enable_no_resched();

Again, the patch removes a preempt_enable() and doesn't add a
preempt_disable().  Maybe this is to balance the earlier patch.  If so,
they should both be in the same patch so the kernel works OK at each stage.

You didn't include a description of what this patch actually does.

After all the corrections I'm not terribly confident that the three patches
which I ended up with are correct.  Please check them carefully.
