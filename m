Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135814AbRECRlM>; Thu, 3 May 2001 13:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135823AbRECRkx>; Thu, 3 May 2001 13:40:53 -0400
Received: from jhuml4.jhu.edu ([128.220.2.67]:2255 "EHLO jhuml4.jhu.edu")
	by vger.kernel.org with ESMTP id <S135814AbRECRkt>;
	Thu, 3 May 2001 13:40:49 -0400
Date: Thu, 03 May 2001 13:36:32 -0400 (EDT)
From: afei@jhu.edu
Subject: The 2.4 /proc module change
In-Reply-To: <Pine.LNX.4.21.0104231003480.13206-100000@penguin.transmeta.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <Pine.GSO.4.05.10105031325030.13150-100000@aa.eps.jhu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the old 2.x kernels, a /proc module registers itself through
proc_register(&proc_root, &proc_self) and unregister itself through
proc_unregister(&proc_root, inode)

But in the 2.4.x kernels, proc_register and proc_unregister are no longer
available. Compilation yields "implicit declaration of proc_register" that
means they are not defined in any header files. Besides, they are defined
as static now, so EXPORT_SYMBOL(proc_regiser) does not make it work
either. When trying "insmod proc_dev", the kernel says "unresolved
symbol: proc_register". I have searched and checked archives on
registering /proc entry, but I got no fruitful result. I am wondering if
this is a bug or /proc entry registration has been changed to another
undocumented method. The Linux kernel API shows register_sysctl_table
under "the proc filesystem" category. Is this the new API to register a
proc system. But its description says it will register an entry under
/proc/sys only.

I would appreciate it if you can give me some suggestions.

Fei Liu

Please send email directly to afei@jhu.edu



