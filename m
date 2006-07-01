Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGAExX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGAExX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 00:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWGAExX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 00:53:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964808AbWGAExW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 00:53:22 -0400
Date: Fri, 30 Jun 2006 21:53:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: ltuikov@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
Message-Id: <20060630215312.b1389820.akpm@osdl.org>
In-Reply-To: <44A5FE17.1000607@garzik.org>
References: <20060630181915.638166c2.akpm@osdl.org>
	<20060701012658.14951.qmail@web31803.mail.mud.yahoo.com>
	<20060630183744.310f3f0d.akpm@osdl.org>
	<44A5FE17.1000607@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 00:46:15 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > Luben Tuikov <ltuikov@yahoo.com> wrote:
> >>> We do occasionally hit task_struct.comm[] truncation, when people use
> >>> "too-long-a-name%d" for their kernel thread names.  But we seem to manage.
> >> It would be especially helpful if you want to name a task thread
> >> the NAA IEEE Registered name format (16 chars, globally unique), for things
> >> like FC, SAS, etc.  This way you can identify the task thread with
> >> the device bearing the NAA IEEE name.
> >>
> >> Currently just last character is cut off, since TASK_COMM_LEN is 15+1.
> >>
> >> I think incrementing it would be a good thing, plus other things
> >> may want to represent 8 bytes as a character array to be the name
> >> of a task thread.
> > 
> > OK, that's a reason.  Being able to map a kernel thread onto a particular
> > device is useful.
> 
> But will it wind up this way, when the does-not-exist-yet-upstream code 
> appears?
> 
> I would think it would make more sense to increase the size of the key 
> task structure only when there are justified, merged users in the kernel.
> 

Well yes - I assumed that would be happening fairly soon.  Luben?
