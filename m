Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUK3DYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUK3DYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUK3DYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:24:20 -0500
Received: from ozlabs.org ([203.10.76.45]:47332 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261962AbUK3DYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:24:08 -0500
Subject: Re: [ANNOUNCE 1/7] Diskdump 1.0 Release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkdump-develop@lists.sourceforge.net
In-Reply-To: <3BC4D5FF6ADE0Findou.takao@soft.fujitsu.com>
References: <3AC4D5FF1413D5indou.takao@soft.fujitsu.com>
	 <3BC4D5FF6ADE0Findou.takao@soft.fujitsu.com>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 14:23:59 +1100
Message-Id: <1101785039.14565.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 19:37 +0900, Takao Indoh wrote:
> This is a patch for diskdump common layer.
...

> +static int fallback_on_err = 1;
> +static int allow_risky_dumps = 1;
> +static unsigned int block_order = 2;
> +static int sample_rate = 8;
> +module_param_named(fallback_on_err, fallback_on_err, bool, S_IRUGO|S_IWUSR);
> +module_param_named(allow_risky_dumps, allow_risky_dumps, bool, S_IRUGO|S_IWUSR);
> +module_param_named(block_order, block_order, uint, S_IRUGO|S_IWUSR);
> +module_param_named(sample_rate, sample_rate, int, S_IRUGO|S_IWUSR);

You can just use "module_param" here (and elsewhere in the patch), since
the name is the same as the variable name.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

