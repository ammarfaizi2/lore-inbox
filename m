Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJOFVC>; Tue, 15 Oct 2002 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSJOFVC>; Tue, 15 Oct 2002 01:21:02 -0400
Received: from dp.samba.org ([66.70.73.150]:15809 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262410AbSJOFVB>;
	Tue, 15 Oct 2002 01:21:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 'virtual => physical page mapping cache' take #2, vcache-2.5.38-C4 
In-reply-to: Your message of "Fri, 27 Sep 2002 20:54:31 +0200."
             <Pine.LNX.4.44.0209272043260.17678-100000@localhost.localdomain> 
Date: Tue, 15 Oct 2002 15:15:13 +1000
Message-Id: <20021015052656.2AB992C06B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209272043260.17678-100000@localhost.localdomain> you
 write:
> +	page = pin_page(uaddr - offset);
> +	ret = IS_ERR(page);
> +	if (ret)
> +		goto out;
> +	head = hash_futex(page, offset);

Um, you mean:
	if (IS_ERR(page)) {
		ret = PTR_ERR(page);
		goto out;
	}

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
