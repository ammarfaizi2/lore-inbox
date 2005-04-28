Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVD1UVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVD1UVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVD1UVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:21:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23515 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262111AbVD1UVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:21:46 -0400
Date: Thu, 28 Apr 2005 22:21:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mj@ucw.cz, lmb@suse.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050428202127.GC12431@elf.ucw.cz>
References: <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz> <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu> <20050428130819.GF2226@openzaurus.ucw.cz> <E1DREtK-0006Ha-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DREtK-0006Ha-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Exactly. So can we simply merge root-only fuse, and then worry
> > how to make it safe with user-mounted fuse. See your own unfsd example
> > why user-mounting is bad.
> > 
> > One possible solution would be to have root-owned fused that
> > talks to user-owned fused-s and checks they are behaving correctly?
> 
> It's very hard to do that.  What should be the timeout for requests,
> so that valid filesystems don't break, yet it's not possible to do a
> fairly ugly DoS?  It's almost impossible I'd say.

You can still put those two lines into root-owned fused, where people
are less likely to notice them ;-).
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
