Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVJDQDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVJDQDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVJDQDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:03:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42125 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964838AbVJDQDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:03:31 -0400
Date: Tue, 4 Oct 2005 11:03:27 -0500
From: Erik Jacobson <erikj@sgi.com>
To: serue@us.ibm.com
Cc: Erik Jacobson <erikj@sgi.com>, pagg@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Process Notification / pnotify user: Job
Message-ID: <20051004160327.GA29864@sgi.com>
References: <20051003184644.GA19106@sgi.com> <20051003185155.GB19106@sgi.com> <20051003190219.GA20154@sgi.com> <20051004153414.GA9154@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004153414.GA9154@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should it be possible to compile job as a module, or should
> this not be "tristate"?

So I added this to the patch.  I tested it as a kernel module.  Sorry this
was missed in the patch I sent out.

Index: linux/kernel/signal.c
===================================================================
--- linux.orig/kernel/signal.c	2005-09-30 16:05:55.407727738 -0500
+++ linux/kernel/signal.c	2005-10-04 10:48:50.626485968 -0500
@@ -1978,6 +1978,7 @@
 EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
+EXPORT_SYMBOL(send_group_sig_info);
 EXPORT_SYMBOL(sigprocmask);
 EXPORT_SYMBOL(block_all_signals);
 EXPORT_SYMBOL(unblock_all_signals);
