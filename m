Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVAKTGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVAKTGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVAKTGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:06:05 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:129 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262045AbVAKTFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:05:48 -0500
To: Michael.Waychison@Sun.COM
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <41E40D19.8010806@sun.com> (message from Mike Waychison on Tue,
	11 Jan 2005 12:30:01 -0500)
Subject: Re: [PATCH 3/11] FUSE - device functions
References: <E1Co4mF-00045N-00@dorka.pomaz.szeredi.hu> <41E40D19.8010806@sun.com>
Message-Id: <E1CoRKX-0003YT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 20:05:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	sigset_t sigmask;
> > +
> > +	siginitsetinv(&sigmask, sigmask(SIGKILL));
> > +	sigprocmask(SIG_BLOCK, &sigmask, oldset);
> 
> sigmask shadows sigmask.  I'm surprised this works actually. (I see that
> sigmask() is a macro..)

Ugly.  Though, I think I copied the code from some place, so it's not
such a big wonder that it works.

Thanks,
Miklos
