Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUJIJ5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUJIJ5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUJIJ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:57:30 -0400
Received: from zero.aec.at ([193.170.194.10]:44559 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266663AbUJIJ53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:57:29 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (11/12): crypto device driver.
References: <2N7vD-4KV-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 09 Oct 2004 11:57:25 +0200
In-Reply-To: <2N7vD-4KV-33@gated-at.bofh.it> (Martin Schwidefsky's message
 of "Fri, 08 Oct 2004 20:20:13 +0200")
Message-ID: <m34ql4ciyi.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> writes:

> +/**
> + * If we are not using the sparse checker, __user has no use.
> + */
> +#ifdef __CHECKER__
> +# define __user		__attribute__((noderef, address_space(1)))
> +#else
> +# define __user
> +#endif

__user should be already defined elsewhere in the kernel.

-Andi

