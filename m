Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbVGORgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbVGORgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbVGORgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:36:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29149 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263340AbVGORg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:36:29 -0400
Message-ID: <42D7F415.30609@pobox.com>
Date: Fri, 15 Jul 2005 13:36:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Git Mailing List <git@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Kernel Hacker's guide to git (updated)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've updated my git quickstart guide at

	http://linux.yyz.us/git-howto.html

It now points to DaveJ's daily snapshots for the initial bootstrap 
tarball, is reorganized for better navigation, and other things.


Also, a bonus recipe:  how to import Linus's pack files (it's easy).

This recipe presumes that you have a vanilla-Linus repo 
(/repo/linux-2.6) and your own repo (/repo/myrepo-2.6).

$ cd /repo/myrepo-2.6
$ git-fsck-cache		# fsck, make sure we're OK
$ git pull /repo/linux-2.6/.git	# make sure we're up-to-date
$ cp -al ../linux-2.6/.git/objects/pack .git/objects
$ cp ../linux-2.6/.git/refs/tags/* .git/refs/tags
$ git-prune-packed
$ git-fsck-cache		# fsck #2, make sure we're OK

This recipe reduced my kernel.org sync from ~50,000 files to ~5,000 files.

	Jeff



