Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbRAHWbX>; Mon, 8 Jan 2001 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRAHWbN>; Mon, 8 Jan 2001 17:31:13 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:59656 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130195AbRAHWbC>;
	Mon, 8 Jan 2001 17:31:02 -0500
Date: Mon, 8 Jan 2001 23:30:12 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101082230.XAA13551@db0bm.ampr.org>
To: kaos@ocs.com.au
Subject: Re: msg : cannot create ksymoops/nnnnn.ksyms
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,
>> NET4: Unix domain sockets 1.0 for Linux NET4.0.
>> insmod: /lib/modules/2.2.19pre6/misc/unix.o: cannot create
> /var/log/ksymoops/20010106112242.ksyms Read-only file system

> man insmod, look for /var/log/ksymoops.  If you define this directory
> then it is expected to be writable when modules are loaded.  Logging
> module data for ksymoops is a user selectable option, you have to
> decide to use it, and you have done so.

Ok, I knew that, the problem is why unix.o is loaded so early ? I've not found
where it is requested / loaded (I've kmod enabled). 

>> insmod:/lib/modules/2.4.0/kernel/net/unix/unix.o : insmod net-pf-1 failed.

> "alias net-pf-1 unix" is a built in alias.  Looks like you did not
> compile for Unix sockets and something in the kernel wants Unix
> sockets.  If you really do not want Unix sockets, "alias net-pf-1 off".

This was a configuration error. I had missed a configuration step. Thank you.

----
Thank you and best regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
