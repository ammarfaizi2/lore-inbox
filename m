Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWD0Etm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWD0Etm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWD0Etm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:49:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964926AbWD0Etl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:49:41 -0400
Date: Wed, 26 Apr 2006 21:48:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros -v2
Message-Id: <20060426214808.6c478edc.akpm@osdl.org>
In-Reply-To: <200604262145.k3QLjixA005676@dwalker1.mvista.com>
References: <200604262145.k3QLjixA005676@dwalker1.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> wrote:
>
> Changes are switched to test_and_set_bit()/clear_bit() , 
>  comment explaining test_and_set_bit(), and most every
>  other comment ..

I too am getting undefined you_cannot_kmalloc_that_much on x86_64.  Coming
out of

	cache_kobject[cpu] = kmalloc(sizeof(struct kobject), GFP_KERNEL);

in arch/i386/kernel/cpu/intel_cacheinfo.c

It has to be a compiler bug, I think.

	gcc (GCC) 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)

I cannot use this patch until we find a workaround.
