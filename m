Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWCRFSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWCRFSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWCRFSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:18:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751582AbWCRFSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:18:24 -0500
Date: Fri, 17 Mar 2006 21:15:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-Id: <20060317211529.26969a16.akpm@osdl.org>
In-Reply-To: <1142658480.8262.38.camel@homer>
References: <1142658480.8262.38.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> +#define EXPIRED_STARVING(rq) \
>  +	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
>  +		(jiffies - (rq)->expired_timestamp >= \
>  +			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
>  +			((rq)->curr->static_prio > (rq)->best_expired_prio))

Does this have to be a macro?
