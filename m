Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbTDESoy (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTDESoy (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:44:54 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32016
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262509AbTDESox 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 13:44:53 -0500
Subject: Re: [PATCH] New cpu macro and i386 cleanup
From: Robert Love <rml@tech9.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200304050525_MC3-1-331B-F7E3@compuserve.com>
References: <200304050525_MC3-1-331B-F7E3@compuserve.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049568966.753.142.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 05 Apr 2003 13:56:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-05 at 05:24, Chuck Ebbert wrote:

> I was wondering whether the code I converted was running with preempt
> disabled or not but didn't check.  (The very thought of preempt on
> SMP scares me anyway, so I avoid it.)

On a glance, it looked like at least some of them were.

> smp_processor_id() is not preempt-safe either, since the id could
> change before you even get a chance to use the value.  How many
> thousands of lines of code remain that were written assuming things
> would not change underneath them in kernel mode?

Code that needs the processor number to remain fixed now uses get_cpu()
and put_cpu() which disable preemption.

> > Maybe put a comment above it like:
> 
> 
> How about one for the whole kernel?
> 
>         /**********
>          * WARNING: Use preempt at your own risk.
>          **********/

No :)

	Robert Love

