Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVCJRSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVCJRSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVCJRQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:16:24 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:11526 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262753AbVCJRPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:15:12 -0500
Date: Thu, 10 Mar 2005 17:14:29 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: akpm@osdl.org
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, yuasa@hh.iij4u.or.jp
Subject: Re: [patch 4/5] audit mips fix
Message-ID: <20050310171429.GB26269@linux-mips.org>
References: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503042117.j24LHI7l017973@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:16:57PM -0800, akpm@osdl.org wrote:

> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

> @@ -307,7 +308,7 @@ asmlinkage void do_syscall_trace(struct 
>  {
>  	if (unlikely(current->audit_context)) {
>  		if (!entryexit)
> -			audit_syscall_entry(current, regs->orig_eax,
> +			audit_syscall_entry(current, regs->regs[2],

Wrong.  regs[2] can will contain the syscall return value and can be
modified by ptrace also.

  Ralf
