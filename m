Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWCUSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWCUSDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWCUSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:03:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932352AbWCUSDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:03:33 -0500
Date: Tue, 21 Mar 2006 10:03:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <1142962995.4749.39.camel@praia>
Message-ID: <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org> 
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>  <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
 <1142962995.4749.39.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
>
> > Looking closer, the commit after that is a _real_ merge, and it looks like 
> > you did something strange when that at first conflicted in saa7134-dvb.c 
> > or something. I just don't even see _how_ you created that bogus non-merge 
> > commit. Are you using cogito? It has some problems with conflict 
> > resolution, I think. Real git should not even have allowed you to commit 
> > something that hadn't been resolved.
> 
> I'm using stgit. It allows me to export the patches from V4L/DVB
> Mercurial tree, removing backward compatible code and correcting the
> patches. Is it broken?

Hmm. I don't know if it's stgit per se. Maybe the breakage came from a 
mercurial merge that got exported to git as a patch, rather than as a 
merge.

If that's the case, then I'm afraid that the problem is the mercurial 
part, or at least the hg->git conversion. I have no idea how hg does 
merges, and maybe the broken merge was done in the hg tree. 

The really sad part about this is that it means I have to be much more 
careful with dvb merges, since I can't trust the tree any more, when it 
apparently has something strange going on. If things like this keep on 
happening, I'll have to ask you guys to change your work habits.

That said, I _tried_ to check for similar cases in the past history, and I 
couldn't find any. So hopefully this was a one-off occurrence.

			Linus
