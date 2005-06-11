Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVFKVOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFKVOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVFKVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 17:14:17 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:46114 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261519AbVFKVOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 17:14:12 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050611184819.GA21033@elte.hu>
References: <20050608112801.GA31084@elte.hu>
	 <1118507720.12860.8.camel@twins>  <20050611184819.GA21033@elte.hu>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 23:14:08 +0200
Message-Id: <1118524448.12682.5.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 20:48 +0200, Ingo Molnar wrote: 
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Hi Ingo,
> > 
> > I'm having some difficulty with your latest patches; more specifically
> > linux-2.6.12-rc6-git4-RT-V0.7.48-10 floods me with BUGs like these:
> 
> > I gather these are because of:
> > 
> > drivers/usb/code/hcd.c:rh_report_status
> > 
> > static void rh_report_status (unsigned long ptr)
> 
> does the patch below help?
> 
Yes, it does.

> > On another note; X seems to have trouble getting up. It consumes a 
> > full CPU right after mode switching (afaict) without getting any 
> > progress. I'll try and get a nice trace of X using sysrq-t.
> 
> could this be due to the messages spamming the console?

No, no output at all on my (serial) console. Nor does sysrq work; except
for powerOff which really doesn't help :-|, nor does it work with my
current 'good' kernel 2.6.12-rc5-git4-RT-V0.7.47-12. Also any process
touching the X process hangs along with it. I tried strace, gdb etc..

I'll try some more tomorrow..

Peter Zijlstra

