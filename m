Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUAOB3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266355AbUAOB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:29:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:49544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266352AbUAOB27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:28:59 -0500
Date: Wed, 14 Jan 2004 17:29:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: jsun@mvista.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program
 returns pages to kernel
Message-Id: <20040114172946.03e54706.akpm@osdl.org>
In-Reply-To: <20040114171252.4d873c51.akpm@osdl.org>
References: <20040114163920.E13471@mvista.com>
	<20040114171252.4d873c51.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> I think that's wrong, really.  We've discussed this before and decided that
> these flushing operations should be open-coded in the main .c file rather
> than embedded in arch functions which happen to undocumentedly do other
> stuff.

err, OK, I give up.  Lots of architectures do the cache flush in
tlb_start_vma().  I guess mips may as well do the same.

