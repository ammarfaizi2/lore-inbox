Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUFVMB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUFVMB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUFVMB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:01:58 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:50637 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262756AbUFVMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:01:42 -0400
Date: Tue, 22 Jun 2004 05:01:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dean Nelson <dcn@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add wait_event_interruptible_exclusive() macro
Message-ID: <20040622120130.GA16246@taniwha.stupidest.org>
References: <40D30646.mailxA8X155I80@aqua.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D30646.mailxA8X155I80@aqua.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 10:12:06AM -0500, Dean Nelson wrote:

> +#define __wait_event_interruptible_exclusive(wq, condition, ret)	\
> +do {									\
> +	wait_queue_t __wait;						\
> +	init_waitqueue_entry(&__wait, current);				\
> +									\
> +	add_wait_queue_exclusive(&wq, &__wait);
> \

[...]

Thsi reminds me...

I really loath all the preprocessor macros.  I know there are plenty
of this already, but I don't see the advantage of macros over (static)
inline functions which IMO look cleaner and give gcc some change to
sanitize what it's looking at without actually having to have it used.

Is there a reason why we keep doing this?



   --cw

