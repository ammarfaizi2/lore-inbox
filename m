Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275875AbSIUDyI>; Fri, 20 Sep 2002 23:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275877AbSIUDyH>; Fri, 20 Sep 2002 23:54:07 -0400
Received: from dp.samba.org ([66.70.73.150]:59064 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S275875AbSIUDyB>;
	Fri, 20 Sep 2002 23:54:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, kaos@ocs.com.au, Roman Zippel <zippel@linux-m68k.org>,
       akpm@zip.com.au
Subject: [PATCH] Updated module rewrite: 20 September
Date: Sat, 21 Sep 2002 13:46:55 +1000
Message-Id: <20020921035907.162592C0B0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convenient mega-patch [63k]:
http://www.kernel.org/pub/linux/people/rusty/module-x86-20-09-2002.2.5.36.diff.gz

You'll want the 0.4 version of module init tools [36k]:
http://www.kernel.org/pub/linux/people/rusty/module-init-tools-0.4.tar.gz

Changes since yesterday:

	o PARAM() introduced
		o Unification of __setup and MODULE_PARM
		o Does type-checking
		o Collapses - to _ in options
		o Obsoletes __setup

	o __setup replaced in core code (ie. ones I need to compile).

	o x86 implementation of module_put_return
		o Makes it possible to safely control own refcnts sometimes.

	o Old-style module parameters implemented
		o Because there are too many modules for me to convert.

	o Module refcount cleanup to out-of-line the "not a
	  module" case.

	o Probably lots of other things I forgot.

I have an exception table cleanup patch, but it conflicts with the
others (fairly trivially), so it's not in the megapatch:

http://www.kernel.org/pub/linux/people/rusty/Module/extable.patch.2.5.35.gz

Cheers & thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
