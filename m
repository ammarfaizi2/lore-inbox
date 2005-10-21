Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVJUNtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVJUNtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVJUNtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:49:50 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25279
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964952AbVJUNtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:49:49 -0400
Subject: Re: False positive (well not really) on RT backward clock check
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
References: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 21 Oct 2005 15:52:21 +0200
Message-Id: <1129902741.15748.4.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 09:45 -0400, Steven Rostedt wrote:
> Ingo,
> 
> Just want to let you know that I got the warning of the clock going
> backwards on boot up.  But it happened right after I got this message.
> 
> Ktimers: Switched to high resolution mode CPU 0
> 
> So I'm assuming that the clock can go backwards by the switch to high res
> timers.

Can you provide the boot messages up to the switch please ? It's more
likely that this is the switch of the clocksource from jiffies to TSC.
The ktimers high res switch is done in this context.

	tglx


