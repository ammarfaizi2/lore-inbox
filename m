Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUETWto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUETWto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbUETWto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:49:44 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:38407 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265253AbUETWtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:49:43 -0400
Date: Thu, 20 May 2004 15:52:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-Id: <20040520155217.7afad53b.akpm@osdl.org>
In-Reply-To: <20040520093817.GX30909@devserv.devel.redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2004 22:49:37.0123 (UTC) FILETIME=[BA28DB30:01C43EBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> wrote:
>
>  asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
> -			  struct timespec __user *utime, u32 __user *uaddr2)
> +			  struct timespec __user *utime, u32 __user *uaddr2,
> +			  int val3)

Is it safe to go adding a new argument to an existing syscall in this manner?

It'll work OK on x86 because of the stack layout but is the same true of
all other supported architectures?
