Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751860AbWCJREG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWCJREG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWCJREG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:04:06 -0500
Received: from s93.xrea.com ([218.216.67.44]:55786 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S1751860AbWCJREF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:04:05 -0500
Message-Id: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Sat, 11 Mar 2006 02:04:10 +0900
To: linux-kernel@vger.kernel.org
Subject: Faster resuming of suspend technology.
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As you might know, one of the key technology of fast booting is suspending.
actually, using suspending does fast booting. And very good point is
not only can do booting desktop and daemons, but apps at once.
but one big fault --- it is slow for a while after booted because of HDD thrashing.
(I mention a term suspend as generic one, not refering only to Nigel Cunningham's one)

One of the solution of thrashing issue is like this.
1. log disk access pattern after booted.
2. analyze the log and find common disk access pattern.
2. re-order a suspend image using the pattern.
3. read-aheading the image after booted.

so far is okay. this is common technique to reduce disk seek.

The problem of above way is,  "Is there common access pattern?".
I guess there would be.
The reason is that even what user does is always different, but what pages
it needs has common pattern. For example, pages which contain glibc or gtk
libs are always used. So, reading ahead these pages is meaningful, I suppose.

What you think? Your opinion is very welcome.


                 --- Okajima, Jun. Tokyo, Japan.
                     http://www.machboot.com



