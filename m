Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUI0PmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUI0PmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUI0PmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:42:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266481AbUI0PmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:42:01 -0400
Date: Mon, 27 Sep 2004 11:41:43 -0400
From: Alan Cox <alan@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: TTY ldisc and termios locking work
Message-ID: <20040927154143.GA16399@devserv.devel.redhat.com>
References: <20040927143047.GA2921@devserv.devel.redhat.com> <Pine.LNX.4.58.0409270832490.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409270832490.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 08:34:50AM -0700, Linus Torvalds wrote:
> +       ld = tty_ldisc_ref(tty);
> +       if (ld != NULL) {
> +               ld->flush_buffer)
> +                       ld->flush_buffer(tty);
> +               tty_ldisc_deref(ld);
> +       }
> 
> I can see the missing "if (" in my mind, but I'm wondering what else I 
> might have missed. Ie can we have this patch be tested a bit more first?

Its been running for several days. generic_serial got missed because its
BROKEN_ON_SMP for all users and so never got built. Fixed in my tree now.

Alan


