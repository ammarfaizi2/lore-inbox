Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSIXHBy>; Tue, 24 Sep 2002 03:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbSIXHBy>; Tue, 24 Sep 2002 03:01:54 -0400
Received: from dp.samba.org ([66.70.73.150]:64186 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261587AbSIXHBx>;
	Tue, 24 Sep 2002 03:01:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template generation 
In-reply-to: Your message of "Tue, 24 Sep 2002 02:05:45 -0400."
             <3D9000B9.4000001@pobox.com> 
Date: Tue, 24 Sep 2002 17:06:27 +1000
Message-Id: <20020924070706.D3A332C189@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D9000B9.4000001@pobox.com> you write:
> The backend is fairly sound.  And I agree in general event logging is 
> useful, and I fully support integrating [sane] support into the kernel.
> 
> But the kernel API is utter crap.
> 
> Adding <foo>_problem.h for every subsystem?

<sigh>.  That's an extension, designed to make things *easier* on the
author, for example to share code between network drivers.  But I'm
more than happy to grow them on demand (you know IBM programmers,
they're always want "completeness"). 

> Changing every printk() in the damn kernel?
> 
> Come on dude, I _know_ you have more taste than that.

I'm not interested in changing all the printks.  I'm interested in
designing the simplest regularized logging interface I can.  If it's
done right, driver authors will migrate to it because it's easier for
them, and their bug reports become clearer, and sysadmins get happier.

And even though they don't care about the eventlogging tools, all that
stuff becomes exponentially more useful as a bonus.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
