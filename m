Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269143AbUJEQ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269143AbUJEQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUJEQ7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:59:03 -0400
Received: from secundus.edoceo.com ([216.162.208.165]:53890 "EHLO
	secundus.edoceo.com") by vger.kernel.org with ESMTP id S269050AbUJEQ4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:56:04 -0400
From: "David Busby" <DBusby@SeattleMortgage.com>
To: <linux-kernel@vger.kernel.org>
Subject: /dev/misc/inotify 0.11
Date: Tue, 5 Oct 2004 09:55:58 -0700
Message-ID: <82C88232E64C7340BF749593380762021166F3@seattleexchange.SMC.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,
  I patched my 2.6.8.1 kernel with the inotify-0.11.  There were some
sample utils that in C that came with it.  Thanks.  I've successfully
used those to work with inotify.  Here's what's bad:

1> When I say `cat /dev/misc/inotify' my machine stops responding
instantly.  I've not had a chance to see what happens.  I know I'll not
normally say that but when I say something else dumb like cat
/dev/misc/rtc cat will simply wait, not choke up my whole system.

2> Reading from /dev/misc/inotify with PERL produces the same effect.

I don't know enough about kernel hacking to really debug this really
well.  I peeked at the code and there still seems to be calls to dnotify
functions, can't I remove those?  I said this in
drivers/char/inotify.c(54) static int inotify_debug_flags =
INOTIFY_DEBUG_ALL; so I'll recompile and see what happens.


David Busby
Edoceo, Inc.
http://www.edoceo.com/

Linux version 2.6.8.1 (root@busby-devel) (gcc version 3.2.2) #1 Mon Oct
4 12:50:38 PDT 2004

