Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUFHJ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUFHJ5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUFHJ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:57:46 -0400
Received: from web25109.mail.ukl.yahoo.com ([217.12.10.57]:20879 "HELO
	web25109.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264922AbUFHJ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:57:33 -0400
Message-ID: <20040608095730.39955.qmail@web25109.mail.ukl.yahoo.com>
Date: Tue, 8 Jun 2004 10:57:30 +0100 (BST)
From: =?iso-8859-1?q?Patric=20Ho?= <patric1972uk@yahoo.co.uk>
Subject: kenel memory usage question.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on linux used in embedded devices. I use
following method to calculate the actual amount of
memory used by kernel+processes (not including page
caches and swap is off in my system):

(from /proc/meminfo) MemTotal - MemFree - Buffers -
Cached.

I thought this should be a fairly constant number for
a minimal kernel, e.g. no network support, and
statistics are collected right after login. However
when I use different "mem=" kernel cmd-line option, I
got quite different numbers:

7M: 2580K
8M: 2612K
16M: 2648K
128M: 3584K

Any idea why this happens? I can even see "Slab:"
changes from 1220K when mem=7M to 1968K when mem=128K.
It looks like kernel can adjust memory usage depends
on the actual physical memory available. I previously
thought only page caches can shrink in such way.

Thanks a lot.

Patric


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
