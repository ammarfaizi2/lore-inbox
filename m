Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTJQBuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTJQBuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:50:22 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:24060 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263282AbTJQBuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:50:16 -0400
Subject: unsafe printk
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066354577.15921.111.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Oct 2003 21:36:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose I name an executable this:
"\n<0>Oops: EIP=0"

That comes out as a KERN_EMERG log message,
hitting the console and maybe a pager even.

There seem to be a number of places in the
kernel that printk current->comm without
concern for what it may contain.

Escape codes and non-ASCII can make for some
interesting log messages as well. Terminals
may have some programmable keys or answerback
messages. So one day root is using grep on
the log files, and they program the answerback
string to contain a "\r\nrm -r /\r\n"...

BTW, the 0x9b character is often an escape.


