Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSISMyE>; Thu, 19 Sep 2002 08:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbSISMyE>; Thu, 19 Sep 2002 08:54:04 -0400
Received: from dp.samba.org ([66.70.73.150]:42980 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267052AbSISMyB>;
	Thu, 19 Sep 2002 08:54:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, kaos@ocs.com.au, Roman Zippel <zippel@linux-m68k.org>,
       akpm@zip.com.au
Subject: [PATCH] Updated module rewrite.
Date: Thu, 19 Sep 2002 22:58:45 +1000
Message-Id: <20020919125906.279BC2C2A0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convenient mega-patch:
http://www.kernel.org/pub/linux/people/rusty/MODULE-X86-19-09-2002.2.5.36.diff.gz

You'll want the 0.4 version of module init tools:
http://www.kernel.org/pub/linux/people/rusty/module-init-tools-0.4.tar.gz

Changes (roughly, it's been busy here):

	o Updated to 2.5.36
	o bigrefs and modules use a non-schedule-intrusive synchronize_kernel()
		o Makes it almost impossible to safely control own refcnts.
	o Mark unsafe modules at runtime
	o Experimental -F option to unload unconditionally
	o bigrefs use atomics
	o 0.4 module init tools do backwards compatibility exec of xxx.old
	o Probably lots of other things I forgot.

Cheers & thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
