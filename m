Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFPIPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTFPIPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:15:33 -0400
Received: from dp.samba.org ([66.70.73.150]:19609 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263547AbTFPIPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:15:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Diehl <lists@mdiehl.de>
Cc: NeilBrown <neilb@cse.unsw.edu.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules. 
In-reply-to: Your message of "Mon, 16 Jun 2003 09:58:43 +0200."
             <Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de> 
Date: Mon, 16 Jun 2003 18:09:23 +1000
Message-Id: <20030616082925.AF5EE2C0D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de> you write:
> Why using keventd? Personally I'd prefer a synchronous thread start/stop, 
> particularly with the thread living in a module.
> Maybe some generalisation of:

It would be syncronous: but doing kernel_thread yourself means trying
to clean up using daemonize et al, which is incomplete and always
makes me nervous.

An implementation detail to users, but IMHO an important one.

Also, this replaces complete_and_exit: the thread can just exit.  This
simplifies things for the users, too...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
