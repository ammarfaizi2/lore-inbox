Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUDMPap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUDMPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:30:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:43905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263594AbUDMPaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:30:39 -0400
Date: Tue, 13 Apr 2004 08:30:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Johnson <dj@david-web.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5-1 compile error on Alpha
Message-Id: <20040413083022.4556815d.akpm@osdl.org>
In-Reply-To: <200404131226.15241.dj@david-web.co.uk>
References: <200404131226.15241.dj@david-web.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Johnson <dj@david-web.co.uk> wrote:
>
> Hi,
> 
> I'm getting an error trying to compile 2.6.5-mm5-1 on Alpha:
> 
>   CC      arch/alpha/kernel/osf_sys.o
>   CC      arch/alpha/kernel/irq.o
>   CC      arch/alpha/kernel/irq_alpha.o
>   CC      arch/alpha/kernel/signal.o
> arch/alpha/kernel/signal.c: In function `do_signal':
> arch/alpha/kernel/signal.c:616: warning: passing arg 2 of 
> `get_signal_to_deliver' from incompatible pointer type
> arch/alpha/kernel/signal.c:616: error: too few arguments to function 
> `get_signal_to_deliver'
> make[1]: *** [arch/alpha/kernel/signal.o] Error 1
> make: *** [arch/alpha/kernel] Error 2
> 

yup, sorry, the signal changes haven't been ported to alpha yet.  I might
drop them anyway, if I can think of a better way of fixing the race which
they fix.  It's on the todo list somewhere.

