Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUJEQwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUJEQwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUJEQps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:45:48 -0400
Received: from seattlemail.seattlemortgage.com ([65.121.191.30]:29388 "EHLO
	seattleexchange.SMC.LOCAL") by vger.kernel.org with ESMTP
	id S270165AbUJEQoB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:44:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: /dev/misc/inotify 0.11
Date: Tue, 5 Oct 2004 09:43:58 -0700
Message-ID: <82C88232E64C7340BF749593380762028A1D02@seattleexchange.SMC.LOCAL>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /dev/misc/inotify 0.11
Thread-Index: AcSq+oJ2AREhWkX4Rni3/ICJW6iQ+Q==
From: "David Busby" <DBusby@SeattleSavingsBank.com>
To: <linux-kernel@vger.kernel.org>
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
