Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263908AbUDUBkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbUDUBkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUDUBkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:40:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:62424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263908AbUDUBjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:39:42 -0400
Date: Tue, 20 Apr 2004 18:39:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: agl@us.ibm.com, mlxk@mellanox.co.il, linux-kernel@vger.kernel.org
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq shows
 impossible call stack)
Message-Id: <20040420183915.4eee560c.akpm@osdl.org>
In-Reply-To: <52llkqw5me.fsf@topspin.com>
References: <408545AA.6030807@mellanox.co.il>
	<52ekqizkd2.fsf@topspin.com>
	<40855F95.7080003@mellanox.co.il>
	<5265buzgfn.fsf_-_@topspin.com>
	<1082492730.716.76.camel@agtpad>
	<52llkqw5me.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Adam> This problem was annoying me a few months ago so I coded up
>     Adam> a stack trace patch that actually uses the frame pointer.
>     Adam> It is currently maintained in -mjb but I have pasted below.
>     Adam> Hope this helps.
> 
> Thanks, that looks really useful.  What is the chance of this moving
> from -mjb to mainline?

Good, but it needs to be updated to do the right thing with 4k stacks when
called from interrupt context.

See how the the current version of show_trace() does this.
