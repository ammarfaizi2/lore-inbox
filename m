Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269283AbUJKVsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269283AbUJKVsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJKVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:48:09 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:45797 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269283AbUJKVsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:48:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.9-rc4-mm1: swsusp not freeing memory on AMD64
Date: Mon, 11 Oct 2004 23:49:40 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112349.40551.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that on 2.6.9-rc4-mm1 swsusp is unable to free memory on my AMD64 
box:

Stopping tasks: 
========================================================================|
Freeing memory...  done (0 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x5b1]...............................................................................................................
....swsusp: Need to copy 114733 pages
suspend: (pages needed: 114733 + 512 free: 16146)
swsusp: Not enough free pages: Have 16146

On 2.6.9-rc4, for the same set of apps started (after fresh boot), I get:

Stopping tasks: 
==========================================================================|
Freeing 
memory: ......................................................................................................................
.....................................................|
Losing some ticks... checking if CPU frequency changed.
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x58d]..........................................................................................swsusp: 
Need to copy
45510 pages
suspend: (pages needed: 45510 + 512 free: 85369)

On 2.6.9-rc3-mm3 it was OK.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
