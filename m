Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVIKToj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVIKToj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVIKToj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:44:39 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:54395 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750826AbVIKToi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:44:38 -0400
Date: Sun, 11 Sep 2005 21:46:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Message-ID: <20050911194630.GB22951@mars.ravnborg.org>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org> <20050911185711.GA22556@mars.ravnborg.org> <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Can you post a small description how to utilize this method?
> 
> Just do
> 
> 	echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects > objects/info/alternates
> 
> in your tree, and that will tell git that your tree can use my object 
> directory as an "alternate" source of objects. At that point, you can 
> remove all objects that I have.

OK - what I did:

cd /pub/scm/linux/kernel/git/sam
rm -rf kbuild.git
git clone /pub/scm/linux/kernel/git/torvalds/linux-2.6.git kbuild.git
rename to .git to kbuild.git

I had to specify both GIT_DIR and GIT_OBJECT_DIRECTORY to make
git-prune-packed behave as expected. I assume this is normal when I
rename the .git directory like in this case.

I will se if any pullers complins (mostly/only Andrew I think).

	Sam
