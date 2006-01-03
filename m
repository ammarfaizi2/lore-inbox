Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWACMW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWACMW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWACMW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:22:56 -0500
Received: from smtp104.plus.mail.mud.yahoo.com ([68.142.206.237]:24930 "HELO
	smtp104.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751389AbWACMW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:22:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=48HsAuYe3aMZ5Mm27pb+YQOxuoEhVcfsueBo2ywSfT/9vxKRd1JBH7Z9OY5ddU7sJ5+MDslVJZRgc4MJWV9GiGkQNDc77bzd9HySxhghufx9zHBx8j4M+QIpDV7Vr/gVsjvKmzxLUyFHjtbPrwYi14jSSixMzbdZknL24kBMG8k=  ;
Message-ID: <43BA6C96.2060305@yahoo.com.au>
Date: Tue, 03 Jan 2006 23:22:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 16/19] mutex subsystem, semaphore to completion: SX8
References: <20060103100924.GP23289@elte.hu>
In-Reply-To: <20060103100924.GP23289@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> change SX8 semaphores to completions.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ----
> 
>  drivers/block/sx8.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> Index: linux/drivers/block/sx8.c
> ===================================================================
> --- linux.orig/drivers/block/sx8.c
> +++ linux/drivers/block/sx8.c
> @@ -27,6 +27,7 @@
>  #include <linux/time.h>
>  #include <linux/hdreg.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/completion.h>
>  #include <asm/io.h>
>  #include <asm/semaphore.h>

These patches should remove the asm/semaphore.h when appropriate too.
At a glance, this looks like one such case.

Also, these aren't really part of a mutex subsystem patch series are
they?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
