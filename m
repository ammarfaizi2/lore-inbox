Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWJDSqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJDSqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWJDSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:46:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422781AbWJDSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:46:41 -0400
Date: Wed, 4 Oct 2006 11:38:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <20061004181032.GA4272@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
 <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
 <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2006, Jean Tourrilhes wrote:
> 
> 	You can't froze kernel userspace API forever. That is simply
> not workable

Stop arguing this way.

It's not what we have ever done. We've _extended_ the API. But we don't 
break old ones.

I don't even see why you argue. Even the people directly involved with 
this thing seem to say that it should have some simple translation layer 
and do the internal format thing. We've had major subsystem that do that, 
and I don't see why you think wireless is so different, and so special in 
this respect.

The whole _point_ of a kernel is to act as a abstraction layer and 
resource management between user programs and hardware/outside world. 
That's why kernels _exist_. Breaking user-land API's is thus by definition 
something totally idiotic.

If you need to break something, you create a new interface, and try to 
translate between the two, and maybe you deprecate the old one so that it 
can be removed once it's not in use any more. If you can't see that this 
is how a kernel should work, you're missing the point of having a kernel 
in the first place.

Also, I don't want to hear about how this makes things harder and more 
complicated. The fact is, we're programmers, and we should care about the 
_users_. If we don't, we're just masturbating. There's a whole other side 
to this "create software" than just the "me, me, me" side, and if you lose 
sight of that side, that's a really bad thing.

			Linus
