Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUDACQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUDACQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:16:54 -0500
Received: from ozlabs.org ([203.10.76.45]:57237 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261951AbUDACQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:16:48 -0500
Subject: Re: [2.6.2] Badness in futex_wait revisited
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dirk Morris <dmorris@metavize.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <406B1522.9050204@metavize.com>
References: <40311703.8070309@metavize.com>
	 <20040217051911.6AC112C066@lists.samba.org>
	 <20040331165656.GG19280@mail.shareable.org> <406B0219.3000309@metavize.com>
	 <20040331183243.GA20418@mail.shareable.org> <406B1522.9050204@metavize.com>
Content-Type: multipart/mixed; boundary="=-MUoLT++9bTVYW/i46pa0"
Message-Id: <1080785801.32535.116.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Apr 2004 12:16:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MUoLT++9bTVYW/i46pa0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-04-01 at 04:59, Dirk Morris wrote:
> Jamie Lokier wrote:
> 
> >If you have a small test program (or pair of programs) that
> >consistently triggers this message on any machine running 2.6.4, that
> >would be very helpful indeed.
> >  
> >
> Here ya go. :)

Doesn't work for me (2.6.5-rc1 Debian unstable 2xi686).

strace -f output attached below.

rusty@mingo:/tmp$ strace -f -o /tmp/foo.out ./foo
Process 3993 attached
Process 3994 attached
Process 3993 suspended
Process 3993 resumed
Process 3994 detached
sem_wait: Interrupted system call
Process 3995 attached
Process 3993 suspended
Process 3993 resumed
Process 3995 detached
sem_wait: Interrupted system call
Process 3996 attached
Process 3993 suspended
Process 3993 resumed
Process 3996 detached
sem_wait: Interrupted system call
PANIC: handle_group_exit: 3993 leader 3992

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

--=-MUoLT++9bTVYW/i46pa0
Content-Disposition: attachment; filename=foo.out.bz2
Content-Type: application/x-bzip; name=foo.out.bz2
Content-Transfer-Encoding: base64

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

--=-MUoLT++9bTVYW/i46pa0--

