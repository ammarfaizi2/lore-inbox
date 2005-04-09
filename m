Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDIBlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDIBlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDIBlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:41:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:14784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261242AbVDIBlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:41:50 -0400
Date: Fri, 8 Apr 2005 18:41:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, arjan@infradead.org,
       ecashin@noserose.net, greg@kroah.com, axboe@suse.de
Subject: Re: [PATCH] make mempool_destroy resilient against NULL pointers.
Message-Id: <20050408184121.0a498a3d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504090334490.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504090334490.2455@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> 
> General rule (as I understand it) is that functions that free resources 
> should handle being passed NULL pointers - mempool_destroy() will 
> currently explode if passed a NULL pointer, the patch below makes it safe 
> to pass it NULL.

The best response to mempool_destroy(0) is an oops.  There's no legitimate
reason for doing it.
