Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWJED3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWJED3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 23:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJED3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 23:29:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19337 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750939AbWJED3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 23:29:20 -0400
Date: Wed, 4 Oct 2006 20:29:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Merge window closed: v2.6.19-rc1
Message-ID: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.

As usual for -rc1 with a lot of pending merges, it's a huge thing with 
tons of changes, and in fact since 2.6.18 took longer than normal due to 
me traveling (and others probably also being on vacations), it's possibly 
even larger than usual.

I think we got updates to pretty much all of the active architectures, 
we've got VM changes (dirty shared page tracking, for example), we've got 
networking, drivers, you name it. Even the shortlog and the diffstats are 
too big to make the kernel mailing list, but even just the summary says 
something:

 4998 total commits
 6535 files changed, 414890 insertions(+), 233881 deletions(-)

so please give it a good testing, and let's see if there are any 
regressions.

As usual, the best way to get some grip on a particular subsystem would 
tend to be with some script like

	git log --no-merges v2.6.18.. drivers/usb | git shortlog | less -S 

which gives a more manageable overview of any particular area you're 
interested in (in the example that would be 'drivers/usb', but you can 
use this to browse any interesting area).

			Linus
