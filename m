Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161969AbWKOWOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161969AbWKOWOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161970AbWKOWOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:14:16 -0500
Received: from hosting.zipcon.net ([209.221.136.3]:55177 "EHLO
	hosting.zipcon.net") by vger.kernel.org with ESMTP id S1161969AbWKOWOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:14:15 -0500
Message-ID: <455B9133.9030704@beezmo.com>
Date: Wed, 15 Nov 2006 14:14:11 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFCLUE3] flagging kernel interface changes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried submitting a patch a while back:
"[PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype"
to add #define __PT_REGS to include/linux/interrupt.h to flag the change
to the new interrupt handler prototype.  It wasn't well received :(

No big surprise.  The #define wasn't my idea and I hadn't submitted a
patch before.  I wanted to see how the patch procedure worked, and
hoped that the flag would be included so I could mod my drivers and
move on...

What I'm curious about is why flagging kernel/driver interface changes
is considered a bad idea.  From my point of view as a low-life out-of-
tree driver maintainer,

#ifdef NEW_INTERFACE
#define <my new internals>
#endif

(w/maybe an #else...)

is cleaner and safer than trying to track specific kernel versions in
a multi-kernel-version driver.  It seems that in some cases, the new
interface has been, like HAVE_COMPAT_IOCTL for instance.

I don't want to start an argument about	"stable_api_nonsense" or the
wisdom of out-of-tree drivers.  Just curious about the - why - and
whether it is indifference or antagonism toward drivers outside the
fold. Or ???

Apologies for the long post, and thanks for your time.

Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
