Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWEZRj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWEZRj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEZRj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:39:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55249 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751203AbWEZRjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:39:25 -0400
Date: Fri, 26 May 2006 19:39:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark Knecht <markknecht@gmail.com>,
       Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH -rt 1/2] Dont blindly turn on interrupts in boot_override_clocksource
Message-ID: <20060526173916.GB30208@elte.hu>
References: <20060526160651.870725515@goodmis.org> <20060526161036.586358463@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526161036.586358463@goodmis.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The boot_override_clocksource currently blindly turns on interrupts 
> with the releasing of the lock.  But if you have clocksource=xxx in 
> the command line, this function is called before interrupts are setup, 
> and causes early exception errors.

thanks, applied.

	Ingo
