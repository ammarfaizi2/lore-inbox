Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVFGLZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVFGLZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVFGLZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:25:30 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29861 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261832AbVFGLZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:25:24 -0400
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-ia64@vger.kernel.org, linux-altix@sgi.com, edwardsg@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       anton.wilson@camotion.com
In-Reply-To: <20050607053306.GA16181@elte.hu>
References: <1118112390.4533.10.camel@localhost.localdomain>
	 <20050607053306.GA16181@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 07 Jun 2005 07:25:04 -0400
Message-Id: <1118143504.4533.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 07:33 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I tested the patch on an SMP machine where MAX_RT_PRIO = 100 and 
> > MAX_USER_RT_PRIO = 99. Without the patch, the system crashes with a 
> > reboot.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

If this patch does go in, then xpc_activating in
arch/ia64/sn/kernel/xpc_main.c (from rc6) also needs to use MAX_RT_PRIO
instead of MAX_USER_RT_PRIO. Unless it is OK that it runs lower in
priority than other kernel threads.

-- Steve


