Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319189AbSIJPBy>; Tue, 10 Sep 2002 11:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319193AbSIJPBy>; Tue, 10 Sep 2002 11:01:54 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:61938 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319189AbSIJPBx>; Tue, 10 Sep 2002 11:01:53 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain> 
References: <Pine.LNX.4.44.0209092122030.4648-100000@localhost.localdomain> 
To: Ingo Molnar <mingo@elte.hu>
Cc: Zwane Mwaikambo <zwane@mwaikambo.name>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 10 Sep 2002 16:05:08 +0100
Message-ID: <11228.1031670308@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mingo@elte.hu said:
>  this is something i have a 0.5 MB patch for that touches a few
> hundred drivers. I can dust it off if there's demand - it will break
> almost nothing because i've done the hard work of adding the default
> 'no work was done' bit to every driver's IRQ handler. 

Note that you can also survive IRQ storms this way -- if all handlers 
returned 'no work was done' and you get over $N irqs per second, disable 
that IRQ for a while.

--
dwmw2


