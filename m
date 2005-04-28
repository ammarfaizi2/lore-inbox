Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVD1KW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVD1KW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 06:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVD1KW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 06:22:27 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:61864 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261962AbVD1KWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 06:22:16 -0400
Message-ID: <4270B94B.30604@dgreaves.com>
Date: Thu, 28 Apr 2005 11:22:03 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@ucw.cz,
       torvalds@osdl.org, Greg KH <greg@kroah.com>,
       GIT Mailing Lists <git@vger.kernel.org>
Subject: Re: kernel hacker's git howto
References: <20050428085657.GA30800@elf.ucw.cz>
In-Reply-To: <20050428085657.GA30800@elf.ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think a lot of people on the git list would like to see this - please 
CC :)

David

Pavel Machek wrote:

>Hi!
>
>Here's my current version of git HOWTO. I'd like your comments...
>
>	Kernel hacker's guide to git
>	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      2005 Pavel Machek <pavel@suse.cz>
>
>You can get cogito at http://www.kernel.org/pub/software/scm/cogito/
>. Compile it, and place it somewhere in $PATH. Then you can get kernel
>by running
>
>mkdir clean-cg; cd clean-cg
>cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
>... Do cg-update origin to pickup latest changes from Linus. You can
>do cg-diff to see what changes you done in your local tree. cg-cancel
>will kill any such changes, and cg-commit will make them permanent.
>
>To get diff between your working tree and "next tree up", do cg-diff
>-r origin: . If you want to get the same diff but separated
>patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
>from the "up" tree to your working tree, do cg-pull origin followed by
>cg-merge origin.
>
>
>How to set up your trees so that you can cooperate with linus
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>What I did:
>
>Created clean-cg. Initialized straight from Linus (as above). Then I
>created "nice" tree, good for Linus to pull from 
>
>mkdir /data/l/linux-good; cd /data/l/linux-good
>cg-init /data/l/clean-cg
>
>and then my working tree, based on linux-good
>
>mkdir /data/l/linux-cg; cd /data/l/linux-cg
>cg-init /data/l/linux-good
>
>. I do my work in linux-cg. If someone sends me nice patch I should
>pass up, I apply it to linux-good with nice message and do
>
>cd /data/l/linux-cg; cg-pull origin; cg-merge origin
>
>  
>

-- 

