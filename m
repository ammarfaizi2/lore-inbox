Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWEXHlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWEXHlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWEXHlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:41:19 -0400
Received: from www.osadl.org ([213.239.205.134]:37079 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932641AbWEXHlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:41:19 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yann.LEPROVOST@wavecom.fr, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148393971.4997.24.camel@localhost.localdomain>
References: <OF20E79D4D.33810FF5-ONC1257177.00493588-C1257177.004BB870@wavecom.fr>
	 <1148393971.4997.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 May 2006 16:26:46 +0200
Message-Id: <1148394406.5239.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 10:19 -0400, Steven Rostedt wrote:
> It looks like the timer interrupt on this board is having a NULL regs
> passed to it when hard interrupts are threads.  Which might mean that
> the timer interrupt is itself a thread.

Yes, the timer interrupt must be setup with SA_INTERUPT | SA_NODELAY
set.

	tglx


