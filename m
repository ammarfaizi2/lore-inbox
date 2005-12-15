Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVLOTUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVLOTUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVLOTUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:20:23 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9440 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751036AbVLOTUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:20:22 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Date: Thu, 15 Dec 2005 21:20:01 +0200
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com> <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
In-Reply-To: <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512152120.01271.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 December 2005 00:28, Jesper Juhl wrote:
> On 12/14/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 12/14/05, Adrian Bunk <bunk@stusta.de> wrote:
> > > On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > >
> > > > > Hi Linus,
> > > > >
> > > > > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken
> > > > > the EMBEDDED menu.
> > > >
> > > > It looks like that patch needs to be reverted or altered anyway.  sparc64
> > > > machines are failing all over the place, possibly due to newly-exposed
> > > > compiler bugs.
> > > >
> > > > Whether it's the compiler or it's genuine kernel bugs, the same problems
> > > > are likely to bite other architectures.
> > >
> > > The help text already contains a bold warning.
> > >
> > > What about marking it as EXPERIMENTAL?
> > > That is not that heavy as EMBEDDED but expresses this.
> > >
> >
> > I, for one, definately think this is a good idea.
> > Actually, it boggles my mind what this is doing outside of EMBEDDED -
> > I just noticed it had moved when I build -git4 and oldconfig promted
> > me about it.
> >
> I should probably back this up with *why* it boggles my mind.
> 
> -Os has been in EMBEDDED for ages, so it's not been tested by the
> majority of users with the wide range of compilers etc that people
> use. Putting it in as prominent a location as it occupies now means a
> *lot* of people are going to enable it and potentially get breakage -
> not good.

I always compile with -Os, not only kernel, but most of userspace.
So far no problems on i386 arch.
--
vda
