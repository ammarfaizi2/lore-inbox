Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131598AbRAOWTs>; Mon, 15 Jan 2001 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131774AbRAOWTj>; Mon, 15 Jan 2001 17:19:39 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:22802 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131617AbRAOWT2>; Mon, 15 Jan 2001 17:19:28 -0500
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Netzwerkadministrator WH8/DD
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Bug in swapfs (2.4.0-ac9)
Date: Mon, 15 Jan 2001 23:19:26 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Message-Id: <01011523192600.00565@backfire>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've found a bug in swapfs:

fstab:
swapfs          /dev/shm        swapfs  defaults 0 0
swapfs         /tmp    swapfs  defaults 0 0

When I hit <enter> on a tar.gz file in Midnight Commander nothing happens. If 
I do a umonut /tmp and hit <enter> again it works as It should (I see the 
archived files).
Nearly the same Problem with the Acrobat Reader pluin for Netscape. It shows 
only a blank page when /tmp is swapfs.

I've noticed that it's possible to mount /tmp more than once. mount shows then
[snip]
swapfs on /dev/shm type swapfs (rw)
swapfs on /tmp type swapfs (rw)
swapfs on /tmp type swapfs (rw)
swapfs on /tmp type swapfs (rw)
swapfs on /tmp type swapfs (rw)

The permissions for /tmp are rwxrwxrwt, and even -omode=777,exec didn't help.

Any Ideas?

-Gregor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
