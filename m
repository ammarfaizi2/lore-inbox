Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVD1TmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVD1TmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVD1TmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:42:19 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:65449 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262248AbVD1TmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:42:09 -0400
To: pavel@suse.cz
CC: mj@ucw.cz, lmb@suse.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050428130819.GF2226@openzaurus.ucw.cz> (message from Pavel
	Machek on Thu, 28 Apr 2005 15:08:19 +0200)
Subject: Re: [PATCH] private mounts
References: <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz> <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu> <20050428130819.GF2226@openzaurus.ucw.cz>
Message-Id: <E1DREtK-0006Ha-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 21:41:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Exactly. So can we simply merge root-only fuse, and then worry
> how to make it safe with user-mounted fuse. See your own unfsd example
> why user-mounting is bad.
> 
> One possible solution would be to have root-owned fused that
> talks to user-owned fused-s and checks they are behaving correctly?

It's very hard to do that.  What should be the timeout for requests,
so that valid filesystems don't break, yet it's not possible to do a
fairly ugly DoS?  It's almost impossible I'd say.

> Second is somehow improving those two lines this long thread is all about...

That's what I did.  See the recent documentation and code patches
(cc-d to -fsdevel).  I'm pretty convinced it's the right thing to do.
OK, I was with the previous solution too, but anyway ;)

Thanks,
Miklos
