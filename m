Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbUJZHZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUJZHZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUJZHZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:25:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:12702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbUJZHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:25:41 -0400
Date: Tue, 26 Oct 2004 00:23:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make buffer head argument of buffer_##name "const"
Message-Id: <20041026002342.5fb15ab3.akpm@osdl.org>
In-Reply-To: <20041026033241.B7983@almesberger.net>
References: <20041026033241.B7983@almesberger.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> wrote:
>
> --- linux-2.6.9/include/linux/buffer_head.h.orig	Tue Oct 26 02:57:54 2004
>  +++ linux-2.6.9/include/linux/buffer_head.h	Tue Oct 26 02:21:04 2004
>  @@ -76,7 +76,7 @@
>   {									\
>   	clear_bit(BH_##bit, &(bh)->b_state);				\
>   }									\
>  -static inline int buffer_##name(struct buffer_head *bh)			\
>  +static inline int buffer_##name(const struct buffer_head *bh)		\
>   {									\
>   	return test_bit(BH_##bit, &(bh)->b_state);			\
>   }

OK, but why?  Does it generate better code or something?
