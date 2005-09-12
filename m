Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVILSmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVILSmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVILSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:42:39 -0400
Received: from mail.autoweb.net ([198.172.237.26]:26345 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750893AbVILSmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:42:39 -0400
Date: Mon, 12 Sep 2005 14:42:14 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
       Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Message-ID: <20050912184214.GB5276@mythryan2.michonline.com>
References: <m3mzmjvbh7.fsf@telia.com> <Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net> <200509112145.33994.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509112145.33994.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 09:45:33PM -0500, Dmitry Torokhov wrote:
> 
> Call me brain-dead but all of this just makes me rsync my tree to
> kernel.org and then manually do "ln -f" for all the packs that Linus
> has. This way I am sure tht the tree is what I have plus and it is
> "pullable".

If you have access to make hardlinks, you should be able to use
git-relink to do the hard work for you.

>From memory:
	git relink my_dir1 my_dir2 ... master_dir

or:
	git relink my-kernel-tree /pub/scm/.../torvalds/linux.git/

(I think that will work - via a bug in my initial attempt to write
git-relink, I look to make sure the path ends in ".git/" not "/.git/".
So the above should work.  I think.)

-- 

Ryan Anderson
  sometimes Pug Majere
