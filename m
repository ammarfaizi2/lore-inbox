Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWD0Wgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWD0Wgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWD0Wgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:36:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751678AbWD0Wgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:36:53 -0400
Date: Thu, 27 Apr 2006 15:39:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: redzone double-free detection
Message-Id: <20060427153908.480a89a7.akpm@osdl.org>
In-Reply-To: <1146160076.11272.5.camel@localhost>
References: <1146160076.11272.5.camel@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch adds double-free detection to redzone verification when freeing
> an object. As explained by Manfred, when we are freeing an object, both
> redzones should be RED_ACTIVE. However, if both are RED_INACTIVE, we are
> trying to free an object that was already free'd.
> 
> ...
>
>  slab.c |   32 +++++++++++++++++++++++---------

Nice, thanks.

