Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVKAFNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVKAFNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVKAFNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:13:12 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:33057 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965017AbVKAFNL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:13:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QfKxbluwUJkYWXmuRjZYzEepA2ElngPxu63EinmkQiBSlwrXh/ODTYN4Jo16MMzdx53XZ22elcCpUG6i5xWTzRQgfadbZzN6VnJ3FgOZCBOi+MrKqnmd/wHuoLi45zwBezBbXPWpYz2TFxlsEZYZ8CPch7EXVZQBCxVC0u7jaHs=
Message-ID: <787b0d920510312113v715b22e0m8e25dbf0aac317b@mail.gmail.com>
Date: Tue, 1 Nov 2005 01:13:10 -0400
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: /proc/*/smaps
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at those files, trying not to crack up laughing
at the file format. Maybe you will cry. Imagine that some
apps try to parse those... all of them, repeatedly, while
being tolerant of unspecified future changes.

(remember that a filename may have a colon, new fields
may be added, new lines may differ in unknown ways, etc.)

Could we fix this ASAP? How about just commenting it
out right now, so nothing important starts to rely on it.
CONFIG_EXPERIMENTAL would do I guess.

I'll gladly do something sane, but not tonight. I'm sorry I
did not catch this earlier; I've been rather sick and I never
imagined that this thing would get accepted without a
major rework of the file format.

-------- unbelievable example follows --------

08048000-080dc000 r-xp /bin/bash
Size:               592 KB
Rss:                500 KB
Shared_Clean:       500 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:        0 KB
080dc000-080e2000 rw-p /bin/bash
Size:                24 KB
Rss:                 24 KB
Shared_Clean:         0 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:       24 KB
080e2000-08116000 rw-p
Size:               208 KB
Rss:                208 KB
Shared_Clean:         0 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:      208 KB
b7e2b000-b7e34000 r-xp /lib/tls/libnss_files-2.3.2.so
Size:                36 KB
Rss:                 12 KB
Shared_Clean:        12 KB
Shared_Dirty:         0 KB
Private_Clean:        0 KB
Private_Dirty:        0 KB
...
