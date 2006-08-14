Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWHNLaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWHNLaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbWHNLaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:30:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24961 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751344AbWHNLaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:30:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060813201118.GA159@oleg> 
References: <20060813201118.GA159@oleg> 
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] elf_fdpic_core_dump: don't take tasklist_lock 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 14 Aug 2006 12:30:06 +0100
Message-ID: <23693.1155555006@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:

> do_each_thread() is rcu-safe, and all tasks which use this ->mm must
> sleep in wait_for_completion(&mm->core_done) at this point, so we can
> use RCU locks.

Looks reasonable.

Acked-By: David Howells <dhowells@redhat.com>
