Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVHARaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVHARaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 13:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVHARaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 13:30:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbVHARaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 13:30:13 -0400
Date: Mon, 1 Aug 2005 10:29:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: mort@sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] remove sys_set_zone_reclaim()
Message-Id: <20050801102903.378da54f.akpm@osdl.org>
In-Reply-To: <20050801113913.GA7000@elte.hu>
References: <20050801113913.GA7000@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> the patch below removes sys_set_zone_reclaim() for now.

Probably the right thing to do.

> ...
>  Firstly, the syscall lacks basic syscall design: e.g. it allows the 
>  global setting of VM policy for unprivileged users. (!)

Martin sent a patch to make it CAP_SYS_ADMIN-only.

>  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,

That would be more appropriate.

(I'm still not sure what happened to the idea of adding a call to "clear
out this node+zone's pagecache now" rather than "set this noed+zone's
policy")
