Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVDAARK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVDAARK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVDAAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:15:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:30367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262543AbVDAAOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:14:07 -0500
Date: Thu, 31 Mar 2005 16:13:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trondmy@trondhjem.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for
 asynchronous I/O
Message-Id: <20050331161350.0dc7d376.akpm@osdl.org>
In-Reply-To: <1112309586.27458.19.camel@lade.trondhjem.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	<20050330143409.04f48431.akpm@osdl.org>
	<1112224663.18019.39.camel@lade.trondhjem.org>
	<1112309586.27458.19.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trondmy@trondhjem.org> wrote:
>
>  on den 30.03.2005 Klokka 18:17 (-0500) skreiv Trond Myklebust:
>  > > Or have I misunderstood the intent?  Some /* comments */ would be appropriate..
>  > 
>  > Will do.
> 
>  OK. Plenty of comments added that will hopefully clarify what is going
>  on and how to use the API. Also some cleanups of the code.

Ah, so that's what it does ;)

I guess once we have a caller in-tree we could merge this.  I wonder if
there's other existing code which should be converted to iosems.

You chose to not use the aio kernel threads?

Does iosem_lock_and_schedule_function() need locking?  It nonatomically
alters *lk_state.
