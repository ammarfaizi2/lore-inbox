Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbSKVJJG>; Fri, 22 Nov 2002 04:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbSKVJJG>; Fri, 22 Nov 2002 04:09:06 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1555
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267033AbSKVJJF>; Fri, 22 Nov 2002 04:09:05 -0500
Subject: Re: calling schedule() from interupt context
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: error27@email.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       torvalds@transmeta.com
In-Reply-To: <20021122.010934.126934922.davem@redhat.com>
References: <20021122085441.2127.qmail@email.com>
	 <20021122.010934.126934922.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037956564.1504.3896.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 22 Nov 2002 04:16:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-22 at 04:09, David S. Miller wrote:
>    From: "dan carpenter" <error27@email.com>
>    Date: Fri, 22 Nov 2002 03:54:41 -0500
> 
>    module_put ==> put_cpu ==> preempt_schedule ==> schedule
> 
> Oh we can't kill module references from interrupts?

No, I think you can.  Or at least the put_cpu() will not hurt you.

Inside the interrupt handlers, the preemption count is bumped so
preempt_schedule() will never call schedule().

	Robert Love

