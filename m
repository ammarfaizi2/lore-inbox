Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTEXOHH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTEXOHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:07:07 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:60164 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262465AbTEXOHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:07:06 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O problems in 2.4.19/2.4.20/2.4.21-rc3
Date: Sat, 24 May 2003 16:19:40 +0200
User-Agent: KMail/1.5.1
References: <200305231405.54599.christian.klose@freenet.de> <200305231546.27463.christian.klose@freenet.de>
In-Reply-To: <200305231546.27463.christian.klose@freenet.de>
Cc: Christian Klose <christian.klose@freenet.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305241615.49463.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_893z+nrFQrSWzXf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_893z+nrFQrSWzXf
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 May 2003 15:46, Christian Klose wrote:

Hi Christian,

> > I have a problem since Linux Kernel 2.4.19. Copying huge amount of data
> > gives me pauses where pauses are disk io pauses, keyboard does not accept
> > input and mouse won't move. This depends, sometimes those pauses are 1 to
> > 2 seconds, sometimes even more up to 15 seconds where I can not do
> > anything with my linux but waiting :-(
> I forgot to mention that this is filesystem independant. ext2, ext3,
> reiserfs; always same problem.
You've mentioned that you also tried 2.5 and you don't see any difference 
there. I am very interrested to hear what version of 2.5 you tried.

I am using 2.5.69 + some patches and it does not suck or behave brain dead 
like 2.4 does. For me I've quit with 2.4 from now on.

2.5 still has many things to do / to fix but 2.5 is _active_ developed and 
fixes _are_ going into 2.5 where 2.4 does not accept real bug fixes.

If you want to give 2.5.69 a try, please apply the attached patch if you want 
to use it for your desktop. It gives you more interactivity.

ciao, Marc
--Boundary-00=_893z+nrFQrSWzXf
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="sched-interactivity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sched-interactivity.patch"

--- old/kernel/sched.c	2003-05-24 14:45:57.000000000 +0200
+++ 2.5-mcp/kernel/sched.c	2003-05-24 16:18:42.000000000 +0200
@@ -65,7 +65,7 @@
  * they expire.
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
-#define MAX_TIMESLICE		(200 * HZ / 1000)
+#define MAX_TIMESLICE		( 10 * HZ / 1000)
 #define CHILD_PENALTY		50
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3

--Boundary-00=_893z+nrFQrSWzXf--

