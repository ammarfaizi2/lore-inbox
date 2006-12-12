Return-Path: <linux-kernel-owner+w=401wt.eu-S932248AbWLLRsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWLLRsb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWLLRsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:48:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50241 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932248AbWLLRsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:48:31 -0500
Date: Tue, 12 Dec 2006 09:48:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix seqlock_init()
Message-Id: <20061212094820.1049a252.akpm@osdl.org>
In-Reply-To: <20061212111028.GA13908@elte.hu>
References: <20061212111028.GA13908@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 12:10:28 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> +#define seqlock_init(x)					\
> +	do {						\
> +		(x)->sequence = 0;			\
> +		spin_lock_init(&(x)->lock);		\
> +	} while (0)

This does not have to be a macro, does it?
