Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVCJBWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVCJBWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCJBUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:20:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:47555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262653AbVCJAwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:52:05 -0500
Date: Wed, 9 Mar 2005 16:51:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, simlo@phys.au.dk, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/9] UML - change semaphores to completions
Message-Id: <20050309165122.47221983.akpm@osdl.org>
In-Reply-To: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
References: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> @@ -197,13 +197,14 @@
>   		{ .list 	 	= LIST_HEAD_INIT(port->list),
>   		  .wait_count		= ATOMIC_INIT(0),
>   		  .has_connection 	= 0,
>  -		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
>  -								  0),
>   		  .lock 		= SPIN_LOCK_UNLOCKED,
>   		  .port 	 	= port_num,
>   		  .fd  			= fd,
>   		  .pending 		= LIST_HEAD_INIT(port->pending),
>   		  .connections 		= LIST_HEAD_INIT(port->connections) });
>  +
>  +	init_completion(&port->done), 
>  +

I'll convert that to a semicolon...
