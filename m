Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSGHPYn>; Mon, 8 Jul 2002 11:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSGHPYl>; Mon, 8 Jul 2002 11:24:41 -0400
Received: from c-3e0072d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.0.62]:54365
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id <S316973AbSGHPYd>; Mon, 8 Jul 2002 11:24:33 -0400
Subject: Module removal [newbie thoughts]
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Jul 2002 17:27:12 +0200
Message-Id: <1026142032.2058.24.camel@big.pomac.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,(CC me)

As a newbie i'm kinda expecting flames here... but, I just had to share
my thoughts =/


Couldn't the kernel module subsystem work something like this:

When a module is loaded it gets it's own mutex (for shared locks).

Each program/module/kernel part that uses it obtains a lock.
If we load a new module that replaces a older module we could have lock
migrations to the new module.

This would make sure that all use of the module has ceased before it's
removed.

This would also require a "usage count" per module/kernel/program
though. But that could be included in the module subsystem imho or am i
wrong?

If a module is replaced by a newer/other module how do we manage the
transgression to the new module? Well depending on how the sub system
works it could be done automagically i think...

One problem with this is that it'll use more memory... 
And i bet that there are better less complicated ways of doing this but
i really think that the modules should be removable, it might take a
hour or so (worst case senario) but it should be removed eventually... 

//Ian Kumlien

PS. This is more or less a brainfart... so there might be huge holes in
the idea etc. And don't forget to CC me since i'm not on the list.
DS.


