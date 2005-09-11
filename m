Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVIKT4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVIKT4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIKT4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:56:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbVIKT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:56:18 -0400
Date: Sun, 11 Sep 2005 12:56:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <20050911194630.GB22951@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
 <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
 <20050911194630.GB22951@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Sam Ravnborg wrote:
> 
> I had to specify both GIT_DIR and GIT_OBJECT_DIRECTORY to make
> git-prune-packed behave as expected. I assume this is normal when I
> rename the .git directory like in this case.

You should only need to specify GIT_DIR - it should figure out that the 
object directory follows GIT_DIR on its own.

Also, I forget what version of git is installed on kernel.org. The
"alternates" support has been around for a while, and looking at the date
of "/usr/bin/git" it _seems_ recent (Sep 7), but I haven't seen any
announcement of updating since the last one (which was git-0.99.4, which
is too old).

You can try removing all the packs in your .git/objects/packs directory. 
Everything _should_ still work fine.

Famous last words.

		Linus
