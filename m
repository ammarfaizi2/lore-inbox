Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278095AbRJRT3l>; Thu, 18 Oct 2001 15:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRJRT3b>; Thu, 18 Oct 2001 15:29:31 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:47624 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S278025AbRJRT3Y>;
	Thu, 18 Oct 2001 15:29:24 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: 2.2.x process limits (NR_TASKS)?
Date: Thu, 18 Oct 2001 19:29:57 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9qnajl$plc$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org>
X-Trace: ncc1701.cistron.net 1003433397 26284 195.64.65.67 (18 Oct 2001 19:29:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110181139380.30308-100000@tigger.unnerving.org>,
Gregory Ade  <gkade@bigbrother.net> wrote:
>We're running into what appears to be a 256-process-per-user limit on one
>of our webservers, due to the number of processes running as a specific
>user for our application.  I'd like to increase the process limit, and
>*THINK* that to do so i need to increase NR_TASKS in
>/usr/src/linux/include/linux/tasks.h.

--- linux-2.2.19.orig/include/linux/tasks.h	Mon Dec 11 01:49:44 2000
+++ linux-2.2.19/include/linux/tasks.h	Thu Mar 29 13:08:16 2001
@@ -11,7 +11,7 @@
 #define NR_CPUS 1
 #endif
 
-#define NR_TASKS	512	/* On x86 Max about 4000 */
+#define NR_TASKS	2048	/* On x86 Max about 4000 */
 
 #define MAX_TASKS_PER_USER (NR_TASKS/2)
 #define MIN_TASKS_LEFT_FOR_ROOT 4

>Also, where can this limit be changed in 2.4.x?

/proc/sys/kernel/threads-max

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

