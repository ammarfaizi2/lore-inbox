Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWAKVQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWAKVQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWAKVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:16:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:65255
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964854AbWAKVQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:16:39 -0500
Subject: Re: 2.6.15-rt4-sr1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1137012431.6197.117.camel@localhost.localdomain>
References: <1137012431.6197.117.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 22:16:38 +0100
Message-Id: <1137014199.7593.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 15:47 -0500, Steven Rostedt wrote:
> - posix_timers deadlock - There's a loop in the posix_timeres code that 
>     is entered if the current process is a higher priority than the 
>     softirqd thread, and it spins until the softirqd thread is finished.
>     But since the thread is of a higher priority than the softirqd, it
>     deadlocks.

Good catch, thanks

	tglx


