Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbTE1KvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbTE1KvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:51:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:18469 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264668AbTE1KvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:51:17 -0400
Date: Wed, 28 May 2003 04:04:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Inline vm_acct_memory
Message-Id: <20030528040444.331575f1.akpm@digeo.com>
In-Reply-To: <20030528110552.GF5604@in.ibm.com>
References: <20030528110552.GF5604@in.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 11:04:32.0543 (UTC) FILETIME=[EAC7BAF0:01C32508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> I found that inlining vm_acct_memory speeds up vm_enough_memory.  
>  Since vm_acct_memory is only called by vm_enough_memory,
>  theoritically inlining should help, and my tests proved so -- there was
>  an improvement of about 10 % in profile ticks (vm_enough_memory) on a 
>  4 processor PIII Xeon running kernbench.

OK.  But with just a single call site we may as well implement vm_acct_memory()
inside mm/memory.c.  Could you please make that change?

Thanks.
