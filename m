Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUFSWeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUFSWeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUFSWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:34:19 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28076 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262450AbUFSWeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:34:18 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org
Content-Type: text/plain
Organization: 
Message-Id: <1087675920.9831.941.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Jun 2004 16:12:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> Please don't do that -- it makes printing UTF-8 impossible.
> While I'd not argue that now is the time to start outputting
> UTF-8 all over the place, I wouldn't accept that it's a good
> time to _prevent_ it either, as your patch would do.
>
> If you want to post-process printk output, don't do it in the kernel. 

It is dangerous to let the 0x9b character go out
to a serial console. It means the same as ESC [ does
when you have a normal 8-bit terminal.

Non-cannonical UTF-8 encoding for ESC and other
troublesome characters may also cause problems.


