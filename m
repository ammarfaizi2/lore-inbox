Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWE3BgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWE3BgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWE3BbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932103AbWE3BbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:03 -0400
Date: Mon, 29 May 2006 18:35:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 27/61] lock validator: prove spinlock/rwlock locking
 correctness
Message-Id: <20060529183512.38a6e367.akpm@osdl.org>
In-Reply-To: <20060529212523.GA3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212523.GA3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:25:23 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> +# define spin_lock_init_key(lock, key)				\
> +	__spin_lock_init((lock), #lock, key)

erk.  This adds a whole new layer of obfuscation on top of the existing
spinlock header files.  You already need to run the preprocessor and
disassembler to even work out which flavour you're presently using.

Ho hum.
