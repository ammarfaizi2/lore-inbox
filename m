Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJRWOy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJRWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:14:54 -0400
Received: from aeimail.aei.ca ([206.123.6.14]:52984 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261875AbTJRWOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:14:53 -0400
Subject: [FIX] fs/proc/array.c gcc 2.96 compiler bug
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066515287.2364.5.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Oct 2003 18:14:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround for a gcc 2.96 (at least) compiler bug. 

--- linux-2.6.0-test8/fs/proc/array.c.orig      Sat Oct 18 17:30:54 2003
+++ linux-2.6.0-test8/fs/proc/array.c   Sat Oct 18 17:52:09 2003
@@ -295,7 +295,8 @@
 {
        unsigned long vsize, eip, esp, wchan;
        long priority, nice;
-       int tty_pgrp = -1, tty_nr = 0;
+       int tty_pgrp = -1;
+       volatile int tty_nr = 0;
        sigset_t sigign, sigcatch;
        char state;
        int res;

Regards,

shane

