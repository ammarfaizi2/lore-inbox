Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUBNRGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBNRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 12:06:13 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.15]:6088 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S262652AbUBNRGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 12:06:09 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 Paging Fault, Cache tries to swap with no swap partition
Date: Sun, 15 Feb 2004 03:06:35 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402150306.35704.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have an imaging system writing files to removable hard drives.
Compact Flash boot with ram drives so I usually have no swap partition or file.

Recently I upgraded kernel from 2.4.20 to 2.4.24.

System has "mem=460M" (512M ram fitted) and starts with about
400M free. After recording for a while the Cached ram acquires all
but about 4Mb MemFree.

On a hot 38C day it started Oops'ing re paging memory. It runs the
same 2 programs all day gathering and compressing images.
Sorry I have no detail on the Oops at the moment, computer is in a vehicle and
does not normally have a screen. From memory it couldn't allocate a virtual 
page.

I found if I put in a 16Mb ram drive as swap then it would grab
roughly 1.4Mb of it on occasion and keep it until recording stopped
for a while. SwapCached is either 0Kb or 1024Kb, not anything else.

Is this behaviour expected - to require a swap file? 
Can the paging cache be tuned in /proc or somewhere to prevent it being so 
greedy as to want more memory than the machine has?

Is the quickest fix to give it more ram. I read on another posting that with
greater than 512Mb the cache won't grab any more?

Regards
Ross.
