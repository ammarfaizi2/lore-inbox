Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTDDH2d (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDDH2d (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:28:33 -0500
Received: from [12.47.58.55] ([12.47.58.55]:58064 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263436AbTDDH22 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 02:28:28 -0500
Date: Thu, 3 Apr 2003 23:40:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for show_task
Message-Id: <20030403234040.4b3afc48.akpm@digeo.com>
In-Reply-To: <20030404014844.B30163@devserv.devel.redhat.com>
References: <20030404013829.A30163@devserv.devel.redhat.com>
	<20030403224346.51d9680e.akpm@digeo.com>
	<20030404014844.B30163@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 07:39:50.0547 (UTC) FILETIME=[5FD55E30:01C2FA7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> I see. What do you say to adding thread_saved_sp() in addition
> to thread_saved_pc()? E.g. on sparc that would return
> p->thread_info->ti_ksp, then you can calculate free stack.
> 

I don't think the current sp value is very interesting really.

What that code is trying to do is to tell you the minimum amount of stack
which was *ever* available to that process.  Now that is interesting.  But it
requires that the kernel stack be zeroed out when it is created, and there's
no code in there to do that.

It is probably a useful thing to retain though.  A new CONFIG_DEBUG_STACK
would suit.
