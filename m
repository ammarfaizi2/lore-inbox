Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbSJHXyp>; Tue, 8 Oct 2002 19:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSJHXyp>; Tue, 8 Oct 2002 19:54:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1041
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261760AbSJHXyo>; Tue, 8 Oct 2002 19:54:44 -0400
Subject: Re: [PATCH] Re: export of sys_call_table
From: Robert Love <rml@tech9.net>
To: bidulock@openss7.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021008162017.A11261@openss7.org>
References: <20021004131547.B2369@openss7.org>
	<20021004.152116.116611188.davem@redhat.com>
	<20021004164151.D2962@openss7.org>
	<20021004.153804.94857396.davem@redhat.com> 
	<20021008162017.A11261@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 20:00:25 -0400
Message-Id: <1034121625.29467.1883.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-08 at 18:20, Brian F. G. Bidulock wrote:

> This version (courtesy of Dave Grothe at GCOM) uses up/down
> semaphore instead of read/write spinlocks.

> +static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;
> +	read_lock(&streams_call_lock);
> +	read_unlock(&streams_call_lock);
> +	read_lock(&streams_call_lock);
> +	read_unlock(&streams_call_lock);
> +	write_lock(&streams_call_lock);
> +	write_unlock(&streams_call_lock);

Eh?  These are all read-write spinlocks, not semaphores.

	Robert Love

