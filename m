Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWBBVn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWBBVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWBBVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:43:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932297AbWBBVn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:43:57 -0500
Date: Thu, 2 Feb 2006 13:45:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       herbert@13thfloor.at
Subject: Re: [PATCH] pidhash:  Kill switch_exec_pids
Message-Id: <20060202134552.6c1e879e.akpm@osdl.org>
In-Reply-To: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
References: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew my apologies for the patch thrash, but I'm not certain
> which patches are in your tree at the moment (I know there are
> things that don't appear in -mm4) or I would send you an incremental
> patch.

Yes, it has been pretty chaotic.  Here's what I currently have:

exec-allow-init-to-exec-from-any-thread.patch
remove-dead-kill_sl-prototype-from-schedh.patch
do_tty_hangup-use-group_send_sig_info-not.patch
do_sak-dont-depend-on-session-id-0.patch
pidhash-dont-count-idle-threads.patch
pidhash-dont-use-zero-pids.patch
dont-touch-current-tasks-in-de_thread.patch

Plus a couple more patches from Oleg in the todo-queue: "choose_new_parent:
remove unused arg, sanitize exit_state check" and "simplify exec from
init's subthread", which we can assume I'll merge up.

