Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbTAOGvS>; Wed, 15 Jan 2003 01:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTAOGvH>; Wed, 15 Jan 2003 01:51:07 -0500
Received: from dp.samba.org ([66.70.73.150]:41158 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265689AbTAOGvF>;
	Wed, 15 Jan 2003 01:51:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Olaf Dietsche <olaf.dietsche@t-online.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-reply-to: Your message of "Tue, 14 Jan 2003 12:48:11 BST."
             <87bs2kkl50.fsf@goat.bogus.local> 
Date: Wed, 15 Jan 2003 17:55:29 +1100
Message-Id: <20030115065959.6FEE32C30A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <87bs2kkl50.fsf@goat.bogus.local> you write:
> +extern void *kmemdup(const void *, __kernel_size_t, int);
> +  
> +static inline char *kstrdup(const char *s, int flags)
> +	{ return kmemdup(s, strlen(s) + 1, flags); }
> +static inline char *strdup(const char *s) { return kstrdup(s, GFP_KERNEL); }

I disagree with this approach.  (1) because strdup hides an allocation
assumption: it's too dangerous an interface, (2) because introducing a
new interface is a much bigger deal than consolidating existing ones.

But really, I only keep the kstrdup patch around to irritate Linus.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
