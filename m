Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUJ2Js6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUJ2Js6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUJ2Js6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:48:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:25807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbUJ2Js4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:48:56 -0400
Date: Fri, 29 Oct 2004 02:46:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-Id: <20041029024651.1ebadf82.akpm@osdl.org>
In-Reply-To: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
>    I know about a few people who would like to use some functionality of
>  the Magic Sysrq but don't want to enable all the functions it provides.

That's a new one.  Can you tell us more about why people want to do such a
thing?

>  So I wrote a patch which should allow them to do so. It allows to
>  configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
>  interface is backward compatible). If you think it's useful then use it :)
>  Andrew, do you think it can go into mainline or it's just an overdesign?

Patch looks reasonable - we just need to decide whether the requirement
warrants its inclusion.

There have been a few changes in the sysrq code since 2.6.9 and there are
more changes queued up in -mm.  The patch applies OK, but it'll need
checking and redoing.  There's a new `sysrq-f' command in the pipeline
which causes a manual oom-killer call.

