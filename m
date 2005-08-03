Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVHCBt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVHCBt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVHCBt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:49:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18834 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261971AbVHCBtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:49:03 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: george@mvista.com
cc: Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01 
In-reply-to: Your message of "Tue, 02 Aug 2005 18:12:27 MST."
             <42F019FB.1030200@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Aug 2005 11:48:28 +1000
Message-ID: <4094.1123033708@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2005 18:12:27 -0700, 
George Anzinger <george@mvista.com> wrote:
>How about something like:
>	if (current + THREAD_SIZE/sizeof(long) - (regs + sizeof(pt_regs)) > MAGIC)

current points to the current struct task, regs points to the kernel
stack.  Those two data areas can be completely separate, as they are on
i386.  Also i386 uses a separate kernel stack for interrupts.

