Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTLORD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 12:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTLORD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 12:03:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:57318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263840AbTLORD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 12:03:28 -0500
Date: Mon, 15 Dec 2003 09:03:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rearrange cpumask.h headers in conventional structure
Message-Id: <20031215090331.2ca5a755.akpm@osdl.org>
In-Reply-To: <20031215001045.41b98136.pj@sgi.com>
References: <20031215001045.41b98136.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> ...
> The convention for any facility that is partially generic,
>  partially arch specific is for each include/asm-* arch to
>  have it's own arch-specific header file (picked up via the
>  include/asm symlink to the current arch), and for those
>  arch-specific header files in turn to include asm-generic
>  headers, if and to the extend that they choose to make use of
>  the generic implementation.
> 
> ...
>  -#include <linux/cpumask.h>
>  +#include <asm/cpumask.h>

Personally, I rather prefer that include/linux/cpumask.h be retained, and
that it perform the inclusion of <asm/cpumask.h>.  This provides some level
of information hiding and gives us somewhere to place cpumask things which
we _know_ are arch-independent.

