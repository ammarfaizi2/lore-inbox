Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVLQUlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVLQUlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLQUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbVLQUi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:57 -0500
Date: Sat, 17 Dec 2005 12:38:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
Message-Id: <20051217123833.1aa430ab.akpm@osdl.org>
In-Reply-To: <200512161548.lRw6KI369ooIXS9o@cisco.com>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com>
	<200512161548.lRw6KI369ooIXS9o@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> + 	.globl ipath_dwordcpy
> +/* rdi	destination, rsi source, rdx count */
> +ipath_dwordcpy:
> +	movl %edx,%ecx
> +	shrl $1,%ecx
> +	andl $1,%edx	
> +	cld
> +	rep 
> +	movsq 
> +	movl %edx,%ecx
> +	rep
> +	movsd
> +	ret

err, we have a portability problem.
