Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVCDAKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVCDAKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVCDAIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:08:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:45003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262745AbVCCXh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:37:59 -0500
Date: Thu, 3 Mar 2005 15:37:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
Message-Id: <20050303153754.7a5deecd.akpm@osdl.org>
In-Reply-To: <1109857541.29075.25.camel@localhost.localdomain>
References: <1109857541.29075.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Figureau <brice+lklm@daysofwonder.com> wrote:
>
> I'm reporting an oops on a bi-Xeon database server under 2.6.10-ac10
> quite similar to:
> http://marc.theaimsgroup.com/?l=ext3-users&m=110848085314238&w=2
> 
> I also got another server crashing (a mail server this time), but I
> couldn't get the oops/panic.
> 
> This was after more than two weeks of uptime, I was running 2.6.10-ac1
> before and never got this problem.
> 
> Here are the oops information:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
>  printing eip:
> c01a858d
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT SMP 
> Modules linked in: i2c_i801 i2c_core ip_conntrack_ftp ipt_LOG ipt_limit ipt_REJECT ipt_state iptable_filter ip_conntrack ip_tables
> CPU:    2
> EIP:    0060:[journal_commit_transaction+877/5264]    Not tainted VLI
> EFLAGS: 00010286   (2.6.10-ac10) 
> EIP is at journal_commit_transaction+0x36d/0x1490

Please do:

gdb vmlinux
(gdb) l *0xc01a858d
