Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTGFJ4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 05:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTGFJ4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 05:56:42 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.27]:45669 "EHLO
	mwinf0403.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261566AbTGFJ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 05:56:41 -0400
Message-ID: <3F0814B1.1000401@wanadoo.fr>
Date: Sun, 06 Jul 2003 12:23:13 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernardo Innocenti <bernie@develer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C99 types VS Linus types
References: <200307060703.58533.bernie@develer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> Hello,
hi,

> Since C99, the C language has acquired a standard set of machine
> independent types that can be used for machine independent
> fixed-width declarations.
> 
> Getting rid of all non-ISO types from kernel code could be a
> desiderable long-term goal. Besides the inexplicable goodness
> of standards compliance, my favourite argument is that not
> depending on custom definitions makes copying code from/to
> other projects a little easier.

alpha user space .h define uint64_t as unsigned long,
include/asm-alpha/types.h defines it as unsigned long long.
Using a different definition (if it's possible) will be
confusing. Using the same definition as user space means
than code like:

uint64 t u;
printk("%lu", u);

will not compile on alpha. This problem is solved in C99
by using PRI_xxx format specifier macro, I'm not a great
fan of this idea.

> Ok, "int32_t" is a little more typing than "s32_t", but in
> exchange you get it syntax hilighted in vim like built-in
> types ;-)

surely vim allow to define your own set of type ?

regards,
Philippe Elie


