Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWGABeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWGABeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 21:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWGABeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 21:34:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932688AbWGABeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 21:34:20 -0400
Date: Fri, 30 Jun 2006 18:37:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: ltuikov@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
Message-Id: <20060630183744.310f3f0d.akpm@osdl.org>
In-Reply-To: <20060701012658.14951.qmail@web31803.mail.mud.yahoo.com>
References: <20060630181915.638166c2.akpm@osdl.org>
	<20060701012658.14951.qmail@web31803.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> wrote:
>
> > We do occasionally hit task_struct.comm[] truncation, when people use
> > "too-long-a-name%d" for their kernel thread names.  But we seem to manage.
> 
> It would be especially helpful if you want to name a task thread
> the NAA IEEE Registered name format (16 chars, globally unique), for things
> like FC, SAS, etc.  This way you can identify the task thread with
> the device bearing the NAA IEEE name.
> 
> Currently just last character is cut off, since TASK_COMM_LEN is 15+1.
> 
> I think incrementing it would be a good thing, plus other things
> may want to represent 8 bytes as a character array to be the name
> of a task thread.

OK, that's a reason.  Being able to map a kernel thread onto a particular
device is useful.

