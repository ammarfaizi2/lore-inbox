Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbVCKA7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbVCKA7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVCKA7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:59:32 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:50890 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262950AbVCKA6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:58:51 -0500
Date: Fri, 11 Mar 2005 09:58:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] audit mips fix
Message-Id: <20050311095839.77d7a350.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050310171429.GB26269@linux-mips.org>
References: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
	<20050310171429.GB26269@linux-mips.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Thu, 10 Mar 2005 17:14:29 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Mar 04, 2005 at 01:16:57PM -0800, akpm@osdl.org wrote:
> 
> > Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> > @@ -307,7 +308,7 @@ asmlinkage void do_syscall_trace(struct 
> >  {
> >  	if (unlikely(current->audit_context)) {
> >  		if (!entryexit)
> > -			audit_syscall_entry(current, regs->orig_eax,
> > +			audit_syscall_entry(current, regs->regs[2],
> 
> Wrong.  regs[2] can will contain the syscall return value and can be
> modified by ptrace also.

Thank you for your comment,
I consider a good way based on your comment. 

Do you already have a good idea?

Yoichi
