Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIBco>; Mon, 8 Jan 2001 20:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbRAIBce>; Mon, 8 Jan 2001 20:32:34 -0500
Received: from cc493382-b.whmh1.md.home.com ([24.3.58.253]:36398 "EHLO
	legion.wienholt.net") by vger.kernel.org with ESMTP
	id <S129811AbRAIBcU>; Mon, 8 Jan 2001 20:32:20 -0500
Reply-To: <elixer@erols.com>
From: "Sean R. Bright" <elixer@erols.com>
To: <linux-kernel@vger.kernel.org>
Subject: FS callback routines
Message-ID: <000c01c079db$78ab39e0$59aa0141@cc230545b>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Date: Mon, 8 Jan 2001 20:21:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Ok, before I begin, don't shoot me down, but I had an idea for a kernel
modification and was wondering how feasible the group thought it was.

	I was writing a user space application to monitor a folder's contents.  The
folder itself contained 100 folders, and each of those contained 24 folders.
While writing the code to traverse the directory structure I realized that
instead of my software figuring out when things change, why not just have
the fs tell my application when something was updated.  For example, say we
had a function called watch_fs(), that took an inode reference and a
function pointer and maybe a bitmask of events to watch for.  When that
inode (or its children) were changed, why couldn't the fs code call the
callback function I specified?

	I have no idea how expensive this would be or if its even worth it at this
point.  It also wouldn't be portable at all considering that I know of no
other OS that does this (could be wrong).

	Like I said, I am not asking that this be (necessarily) implemented, I am
just curious as to what the percieved performance ramifications would be if
it were to implemented, say, by a virgin kernel developer ;)

	Thanks,
	Sean
	elixer@erols.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
