Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVD0JwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVD0JwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVD0JwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:52:23 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:7089 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261353AbVD0JwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:52:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Date: Wed, 27 Apr 2005 11:52:15 +0200
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504271152.15423.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
on AMD64.  Namely, after trying to open a web page containing a Java
applet, my browser starts a java process that takes almost 100% of the CPU
(system load, according to gkrellm) and cannot be killed (even by root,
although it executes with a non-root UID).  Apparently, it is in TASK_RUNNING
(according to ps).

The problem is 100% reproducible (it is enough to visit
http://java.sun.com/docs/books/tutorial/getStarted/index.html to trigger it)
and it does not depend on the web browser used.

The Java JRE version is:

java version "1.4.2_06"
Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_06-b03)
Java HotSpot(TM) Client VM (build 1.4.2_06-b03, mixed mode)

(I guess it's 32-bit, but I'm not quite sure) and I've installed it from the
SuSE 9.2 RPM.

It really is a show stopper to me, so please advise.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
