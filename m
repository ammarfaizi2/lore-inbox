Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUDRPjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUDRPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 11:39:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:22210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbUDRPjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 11:39:05 -0400
Date: Sun, 18 Apr 2004 08:38:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: raven@themaw.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm6
Message-Id: <20040418083843.23c87622.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404181756430.5049@donald.themaw.net>
References: <20040414230413.4f5aa917.akpm@osdl.org>
	<Pine.LNX.4.58.0404181756430.5049@donald.themaw.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raven@themaw.net wrote:
>
> 
> Looks like something was missed here.
> 
> arch/sparc64/kernel/signal.c: In function `do_signal':
> arch/sparc64/kernel/signal.c:627: warning: passing arg 2 of 
> `get_signal_to_deliver' from incompatible pointer type
> arch/sparc64/kernel/signal.c:627: warning: passing arg 3 of 
> `get_signal_to_deliver' from incompatible pointer type
> arch/sparc64/kernel/signal.c:627: error: too few arguments to function 
> `get_signal_to_deliver'
> 

You'll need to revert signal-race-fix.patch for now - nobody has done the
sparc64 bit.  And I haven't pushed for it because the whole thing needs to
be redone, if that's at all practical.

