Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTEEQnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTEEQYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:40 -0400
Received: from are.twiddle.net ([64.81.246.98]:22932 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263620AbTEEQWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:22:15 -0400
Date: Mon, 5 May 2003 09:34:44 -0700
From: Richard Henderson <rth@twiddle.net>
To: David.Mosberger@acm.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
Message-ID: <20030505163444.GB9342@twiddle.net>
Mail-Followup-To: David.Mosberger@acm.org, linux-kernel@vger.kernel.org
References: <20030502004014$08e2@gated-at.bofh.it> <20030503210015$292c@gated-at.bofh.it> <20030504063010$279f@gated-at.bofh.it> <ugade16g78.fsf@panda.mostang.com> <20030505074248.GA7812@twiddle.net> <16054.32214.804891.702812@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16054.32214.804891.702812@panda.mostang.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:05:58AM -0700, David Mosberger-Tang wrote:
>   Richard> Why?  Certainly it isn't needed for x86.
> 
> Certain applications (such as debuggers) want to know.  Sure, you can
> do symbol matching (if you have the symbol table) or code-reading
> (assuming you know the exact sigreturn sequence), but having a marker
> would be more reliable and faster.

Eh.  The whole point was to *eliminate* the special cases.

If the debugger does nothing special now, it'll see the symbol
from the VDSO in the backtrace and print __kernel_sigreturn.
Isn't this sufficient for the user to recognize what's going on?
Does it really need to print <signal frame>?



r~
