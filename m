Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275117AbTHAGtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275119AbTHAGtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:49:22 -0400
Received: from dp.samba.org ([66.70.73.150]:59842 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S275117AbTHAGtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:49:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Cc: "Chmouel Boudjnah" <chmouel@chmouel.com>, flepied@mandrakesoft.com
Subject: Re: 2.6: races between modprobe and depmod in rc.sysinit 
In-reply-to: Your message of "Thu, 31 Jul 2003 21:45:01 +0400."
             <200307312145.01711.arvidjaar@mail.ru> 
Date: Fri, 01 Aug 2003 16:34:41 +1000
Message-Id: <20030801064916.46F842C2B9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200307312145.01711.arvidjaar@mail.ru> you write:
> the only reason I can imagine is that it hits depmod -A that runs in 
> rc.sysinit and does
> 
> truncate /lib/modules/`uname -r`/modules.*
> scan modules
> write files
> 
> So, quesitons
> 
> - would anybody (Rusty?) object if I change depmod to do 
>   build temp name
>   move temp name into original

No, that's definitely my preferred method anyway: please send patch.
Although I double this causes your problem here.

> - Chmouel, Fred - is depmod on every boot really neccessary? When people 
> install modules they are expected to run it actually ...

People get it wrong, and you still want them to boot.  Increasingly we
can live without depmod though: I might fix this in a near-future
version to live without it.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
