Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131452AbRAFMhy>; Sat, 6 Jan 2001 07:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130983AbRAFMhf>; Sat, 6 Jan 2001 07:37:35 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64005 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131452AbRAFMhZ>;
	Sat, 6 Jan 2001 07:37:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: msg : cannot create ksymoops/nnnnn.ksyms 
In-Reply-To: Your message of "Sat, 06 Jan 2001 12:43:24 BST."
             <200101061143.MAA01733@db0bm.ampr.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jan 2001 23:37:18 +1100
Message-ID: <25047.978784638@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001 12:43:24 +0100, 
f5ibh <f5ibh@db0bm.ampr.org> wrote:
>NET4: Unix domain sockets 1.0 for Linux NET4.0.
>insmod: /lib/modules/2.2.19pre6/misc/unix.o: cannot create /var/log/ksymoops/20010106112242.ksyms Read-only file system

man insmod, look for /var/log/ksymoops.  If you define this directory
then it is expected to be writable when modules are loaded.  Logging
module data for ksymoops is a user selectable option, you have to
decide to use it, and you have done so.

>insmod:/lib/modules/2.4.0/kernel/net/unix/unix.o : insmod net-pf-1 failed.

"alias net-pf-1 unix" is a built in alias.  Looks like you did not
compile for Unix sockets and something in the kernel wants Unix
sockets.  If you really do not want Unix sockets, "alias net-pf-1 off".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
