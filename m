Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTEEIdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTEEIdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:33:31 -0400
Received: from [12.47.58.20] ([12.47.58.20]:38520 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262098AbTEEIda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:33:30 -0400
Date: Mon, 5 May 2003 01:47:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505014729.5db76f70.akpm@digeo.com>
In-Reply-To: <20030505081300.6B2ED2C016@lists.samba.org>
References: <20030505081300.6B2ED2C016@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 08:45:53.0244 (UTC) FILETIME=[BC9731C0:01C312E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> This is the kmalloc_percpu patch.

How does it work?  What restrictions does it have, and
what compromises were made?

+#define PERCPU_POOL_SIZE 32768

What's this?


The current implementation of kmalloc_per_cpu() turned out to be fairly
disappointing because of the number of derefs which were necessary to get at
the data in fastpaths.   How does this implementation compare?


Thanks.
