Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVGFW3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVGFW3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVGFW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:28:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262560AbVGFWVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:21:24 -0400
Date: Wed, 6 Jul 2005 15:21:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-audit@redhat.com
Subject: Re: audit function doc. question
Message-ID: <20050706222115.GJ9153@shell0.pdx.osdl.net>
References: <20050706115904.43a95978.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706115904.43a95978.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* randy_dunlap (rdunlap@xenotime.net) wrote:
> kernel/audit.c (2.6.13-rc1-git5) audit_log_start() says:
> 
> /* Obtain an audit buffer.  This routine does locking to obtain the
>  * audit buffer, but then no locking is required for calls to
>  * audit_log_*format.  If the tsk is a task that is currently in a
>  * syscall, then the syscall is marked as auditable and an audit record
>  * will be written at syscall exit.  If there is no associated task, tsk
>  * should be NULL. */
> struct audit_buffer *audit_log_start(struct audit_context *ctx, int type)
> {
> 
> What does <tsk> refer to in the function description?
> There is no <tsk> in this function.

It refers to tsk, tsk, stale comment.  It's task->audit_context (which is
ctx there).  Interested in preparing a patch, could even move to proper
kerneldoc format ;-)

thanks,
-chris
