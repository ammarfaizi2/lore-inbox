Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTFQA5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTFQA5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:57:44 -0400
Received: from dp.samba.org ([66.70.73.150]:41864 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264494AbTFQA5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:57:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Diehl <lists@mdiehl.de>
Cc: NeilBrown <neilb@cse.unsw.edu.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules. 
In-reply-to: Your message of "Mon, 16 Jun 2003 12:27:42 +0200."
             <Pine.LNX.4.44.0306161145570.2079-100000@notebook.home.mdiehl.de> 
Date: Tue, 17 Jun 2003 11:11:14 +1000
Message-Id: <20030617011137.AF4562C074@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306161145570.2079-100000@notebook.home.mdiehl.de> you write:
> IMHO cleanup_thread would be something one MUST NOT call with any lock 
> hold, not even a semaphore if it might get acquired anywhere else in 
> keventd-context.

Err, yes.  I thought this was fairly clear.  cf. del_timer_sync and a
timer function.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
