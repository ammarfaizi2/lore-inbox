Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVBIB0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVBIB0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVBIB0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:26:15 -0500
Received: from are.twiddle.net ([64.81.246.98]:56449 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261731AbVBIB0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:26:10 -0500
Date: Tue, 8 Feb 2005 17:25:43 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
Message-ID: <20050209012543.GA13802@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org> <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 05:20:06PM -0800, Linus Torvalds wrote:
> +3:	movl %eax,(%ecx)
...
> +3:	movl %eax,(%ecx)
> +4:	movl %edx,4(%ecx)
...
> +	.long 3b,bad_put_user
> +	.long 4b,bad_put_user

The first 3 gets lost.


r~
