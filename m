Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274870AbTHFFNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274871AbTHFFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:13:50 -0400
Received: from [203.53.213.67] ([203.53.213.67]:35338 "EHLO exchange.world.net")
	by vger.kernel.org with ESMTP id S274870AbTHFFNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:13:23 -0400
Message-ID: <6416776FCC55D511BC4E0090274EFEF508002521@exchange.world.net>
From: Steven Micallef <steven.micallef@world.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: File descriptors allocated
Date: Wed, 6 Aug 2003 15:13:17 +1000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On the 2.4.20 kernel, looking at /proc/sys/fs/file-nr, as far as I know the
three values (from left to right) represent file descriptors allocated, file
descriptors free (from those allocated) and maximum file descriptors
available.

My question is, should the first figure ever decrease? On a fairly loaded
system, I've seen it go from 400 to 1700+ in a couple of days, and it just
keeps getting higher and higher. The first value minus the second should
tell me exactly how many are in use on my system, and this figure remains
(fairly) consistent, so it's probably no big deal. I just figured that the
kernel would "de-allocate" FDs after they weren't in use for a period of
time.

Any ideas?

Thanks,

Steve Micallef
