Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSJIAYw>; Tue, 8 Oct 2002 20:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbSJIAYw>; Tue, 8 Oct 2002 20:24:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7762 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261385AbSJIAYw>; Tue, 8 Oct 2002 20:24:52 -0400
Date: Tue, 8 Oct 2002 20:30:29 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210090030.g990UTe08202@devserv.devel.redhat.com>
To: bidulock@openss7.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: export of sys_call_table
In-Reply-To: <mailman.1034119380.19047.linux-kernel2news@redhat.com>
References: <20021004131547.B2369@openss7.org> <20021004.152116.116611188.davem@redhat.com> <20021004164151.D2962@openss7.org> <20021004.153804.94857396.davem@redhat.com> <mailman.1034119380.19047.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Following is a tested patch for i386 architecture for registration
> of putpmsg and getpmsg system calls.  This version (courtesy of
> Dave Grothe at GCOM) uses up/down semaphore instead of read/write
> spinlocks.  The patch is against 2.4.19 but should apply up and
> down a ways as well.

> +EXPORT_SYMBOL(register_streams_calls);
> +EXPORT_SYMBOL(unregister_streams_calls);

EXPORT_SYMBOL_GPL perhaps? Otherwise it's just a disguised hook,
just like nVidia's shell driver.
 
> +static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;

Does not look like a semaphore to me...

-- Pete
