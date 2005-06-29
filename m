Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVF2ANu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVF2ANu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVF2ANr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:13:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261242AbVF2AK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:10:58 -0400
Date: Tue, 28 Jun 2005 17:10:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 14/16] IB uverbs: add mthca user CQ support
Message-Id: <20050628171046.6fa7de0d.akpm@osdl.org>
In-Reply-To: <2005628163.jWivrrVepuPgy40z@cisco.com>
References: <2005628163.XfYnZThlsTGb61Td@cisco.com>
	<2005628163.jWivrrVepuPgy40z@cisco.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Add support for userspace completion queues (CQs) to mthca.
> 

There are more interesting things happening here ;)

> @@ -177,6 +177,7 @@ struct mthca_cq {
>  	int                    cqn;
>  	u32                    cons_index;
>  	int                    is_direct;
> +	int                    is_kernel;
>  
>  	/* Next fields are Arbel only */
>  	int                    set_ci_db_index;

I assume we have one body of code which is capable of handling data
structures in either kenrel memory of user memory?  (guess).

If so, that's a fairly sensitive thing to be doing.  Tell us more, please.
