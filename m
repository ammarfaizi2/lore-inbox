Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbTHBAaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 20:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTHBAaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 20:30:10 -0400
Received: from dp.samba.org ([66.70.73.150]:65195 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270939AbTHBAaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 20:30:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: races between modprobe and depmod in rc.sysinit 
In-reply-to: Your message of "Sat, 02 Aug 2003 01:22:55 +0400."
             <200308020122.55169.arvidjaar@mail.ru> 
Date: Sat, 02 Aug 2003 10:29:24 +1000
Message-Id: <20030802003007.6D00D2C2AF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200308020122.55169.arvidjaar@mail.ru> you write:
> anyway here is patch against 0.9.13-pre that makes depmod output in temp file
> and rename it after. It fixed the problem for sure for me (like commenting 
> out depmod in rc.sysinit did but most people seem to object to it).

Thanks, I've applied this with a fix (you left the declaration of
skipchars in main(), so it shadowed the new global one).

I also repaired the testsuite after this patch (and found another bug
along the way), which also would have caught the mistake (Hint hint!).

I've put the lot up in the usual place, masquerading as 0.9.13-pre2.

	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.9.13-pre2.tar.gz

Feedback welcome!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

