Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUIHMCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUIHMCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbUIHMCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:02:45 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:59298 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269161AbUIHMCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:02:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: latency.c [was: Re: 2.6.9-rc1-mm1]
Date: Wed, 8 Sep 2004 14:02:39 +0200
User-Agent: KMail/1.6.2
References: <200409080812.i888CDo29381@owlet.beaverton.ibm.com>
In-Reply-To: <200409080812.i888CDo29381@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081402.39607.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 10:12, Rick Lindsley wrote:
>     I've fiddled a bit with both the latency.c programs.  I've added some
>     options to them etc.  In particular, now you can specify a program
>     to run and monitor instead of a pid, which is handy if you need to
>     monitor processes that exit quickly.  Everything is documented in
>     the sources (attached).  I thought you might find this useful. :-)
> 
> Thank you much! yes, that will make it more useful.  I'll add it to my
> backlog and see if I can't get it out to the web page this week.

Great!  There is a missing #include in my sources which produces a misleading 
warning.  Also, I think that the hint about latency.c working only with 
versions 4 and 5 of schedstat is no longer valid. :-)

Please, apply:

--- old/latency-v10.c	2004-09-08 13:48:37.176519744 +0200
+++ latency-v10.c	2004-09-08 13:55:01.956024368 +0200
@@ -7,9 +7,6 @@
  *	it on a kernel that does not have the schedstat patch compiled in
  *	will cause it to happily produce bizarre results.
  *
- *	Note too that this is known to work only with versions 4 and 5
- *	of the schedstat patch, for similar reasons.
- *
  *	This currently monitors only one pid at a time but could easily
  *	be modified to do more.
  */
@@ -28,6 +25,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <stdio.h>
 #include <getopt.h>
 #include <string.h>

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
