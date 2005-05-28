Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVE1Qct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVE1Qct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 12:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVE1Qct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 12:32:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59402 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261165AbVE1Qcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 12:32:48 -0400
Date: Sat, 28 May 2005 17:32:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050528173241.C4711@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org> <20050525135130.GA27088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050525135130.GA27088@elte.hu>; from mingo@elte.hu on Wed, May 25, 2005 at 03:51:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 03:51:30PM +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> > Are all the other architectures busted as well?
> 
> oh damn, they are indeed, because they need to hit schedule() at least 
> once.
> 
> The patch below should address this problem for all architectures, by 
> doing an explicit schedule() in the init code before calling into 
> cpu_idle().

Yuck - wouldn't it be better just to fix all the architectures instead
of applying band aid?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
