Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbULIKJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbULIKJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbULIKJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:09:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:48304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261464AbULIKJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:09:36 -0500
Date: Thu, 9 Dec 2004 02:09:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
Message-Id: <20041209020919.6f17e322.akpm@osdl.org>
In-Reply-To: <41B77D54.4080909@xfs.org>
References: <41B77D54.4080909@xfs.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> wrote:
>
> I have seen this stat go negative (just from booting up a multi cpu box),
>  and looking at the code, it is manipulated without locking in a number
>  of places. I have only seen this in real life on a 2.4 kernel, but 2.6
>  also looks vulnerable.

In 2.6, both dentry_stat.nr_unused and dentry_stat.nr_dentry are covered
by dcache_lock.  I just double-checked and all seems well.
