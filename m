Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTEZRNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEZRM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:12:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37642 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261820AbTEZRL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:11:57 -0400
Date: Mon, 26 May 2003 10:11:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [2.5 patch] Change strlcpy and strlcat
In-Reply-To: <20030526132955.GC9104@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0305261009050.12186-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Adrian Bunk wrote:
> 
> Your API is compatible with *BSD but I'm wondering whether something 
> slightly different might make error handling for callers easier:

Well, judging by the fact that pretty much 99.9% of all users won't ever
care about the return value. And coupled with the fact that the current
behaviour is compatible with BSD (except for the BUG_ON() that I added,
and I have no idea what BSD does for that case, since it pretty clearly
_is_ a bug), I definitely prefer having standard return values than trying 
to make it "easier".

The BSD return values do actually make sense for nested operations.

		Linus

