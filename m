Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUIXVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUIXVTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUIXVTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:19:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:27050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268831AbUIXVTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:19:38 -0400
Date: Fri, 24 Sep 2004 14:17:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlock(1)
Message-Id: <20040924141731.7ced31f7.akpm@osdl.org>
In-Reply-To: <41547C16.4070301@pobox.com>
References: <41547C16.4070301@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> How feasible is it to create an mlock(1) utility, that would allow 
>  priveleged users to execute a daemon such that none of the memory the 
>  daemon allocates will ever be swapped out?

It used to be the case that mlockall(MCL_FUTURE) was inherited across fork,
which would do what you want.

But that was a bug and we fixed it a couple of years back, sadly.

I guess we could add a new mlockall mode which _is_ inherited across fork.
