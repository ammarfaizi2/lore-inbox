Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUFAOYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUFAOYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUFAOXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:23:00 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:13512 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265074AbUFAOWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:22:12 -0400
Date: Tue, 1 Jun 2004 17:22:11 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: [Announce] noca - pagecache control
Message-ID: <Pine.LNX.4.60.0406011713570.3003@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I follow the recent thread about swapping and fadvise.

So, I made a little shared library that hooks read, lseek and close.
After 128KiB readed (configurable by a environment variable) this 
functions call fadvise.

Code is at: http://kernel.umbrella.ro/index.php?vm=1

What is this good for?

If you know that you'll need a file once, use this program so
it will not pollute the pagecache.

I know it is not perfect.
Patches are welcomed.

Examples:
 	noca cat BIG_FILE_THAT_IS_NEEDED_ONLY_ONCE > /dev/null
and watch "vmstat 1".

Comments welcomed.

P.S. It only works on i386 for now.
It was tested on Slackware with a hack for fadvise64_64 (on Slack, glibc 
does call kernel's fadvise).
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
