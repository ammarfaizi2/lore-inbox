Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUATXMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbUATXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:12:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:55489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265821AbUATXMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:12:38 -0500
Date: Tue, 20 Jan 2004 15:13:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: More cleanups for swsusp
Message-Id: <20040120151358.09608fc3.akpm@osdl.org>
In-Reply-To: <20040120225219.GA19190@elf.ucw.cz>
References: <20040120225219.GA19190@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +	BUG_ON (sizeof(struct link) != PAGE_SIZE);

Looking at the code, this hardly seems worth checking.  But the compiler
should just rub this code out anwyay, so whatever.

hmm, one could do:

#define compile_time_assert(expr)					\
	do {								\
		if (!(expr))						\
			compile_time_assert_failed();	/* undefined */	\
	} while (0)

