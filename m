Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTD0XJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 19:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTD0XJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 19:09:24 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:8353 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261927AbTD0XJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 19:09:23 -0400
Date: Sun, 27 Apr 2003 19:20:11 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: CRAP it crashes
In-reply-to: <200304271832150570.027F05E9@smtp.comcast.net>
To: linux-kernel@vger.kernel.org
Message-id: <200304271920110140.02AAE835@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200304271832150570.027F05E9@smtp.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/27/2003 at 6:32 PM rmoser wrote:

>Segfault in fcomp_push() in test.  Debugging.

fcomp_scan() being dumb.  I have to alter it.  Also a little bit in fcomp_push()
(I thought realloc(0, n) would be like malloc(n)).

BruteForce() needs to be altered a bit because of a compiler bug:

for (j = 0; blah blah; j++){ }

must become

for (j = 0; blah blah; ) { j++; }

For some odd reason.  Debugging, it seems to infinitely loop here and
leave j as 0.

You know it would help if someone would grab GDB, grab the source,
and debug it!  My head is starting to hurt....

Any takers?

--Bluefox Icy
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



