Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbRBYIEO>; Sun, 25 Feb 2001 03:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129934AbRBYIEE>; Sun, 25 Feb 2001 03:04:04 -0500
Received: from www.wen-online.de ([212.223.88.39]:43014 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129932AbRBYIEA>;
	Sun, 25 Feb 2001 03:04:00 -0500
Date: Sun, 25 Feb 2001 09:03:54 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Shawn Starr <spstarr@sh0n.net>
cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <3A98A7C9.B7F512DD@sh0n.net>
Message-ID: <Pine.LNX.4.33.0102250848340.2015-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The way sg_low_malloc() tries to allocate, failure messages are
pretty much garanteed.  It tries high order allocations (which
are unreliable even when not stressed) and backs off until it
succeeds.

In other words, the messages are a red herring.

	-Mike

