Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTJLL7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTJLL7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:59:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:12249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263468AbTJLL7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:59:14 -0400
Date: Sun, 12 Oct 2003 05:02:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: current_is_kswapd is a function
Message-Id: <20031012050223.0d270c8f.akpm@osdl.org>
In-Reply-To: <20031012021750.GA772@holomorphy.com>
References: <20031012021750.GA772@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> -	if (current_is_kswapd)
>  +	if (current_is_kswapd())

Well damn, I must have looked at that a hundred times when wondering why
/proc/vmstat:pginodesteal was always zero.  Thanks.

It would probably be worthwhile teaching the compiler to generate a warning
in this case; I doubt if anyone is likely to want to find out at runtime
whether the linker happened to place a particular function at address zero.
I shall suggest that.



